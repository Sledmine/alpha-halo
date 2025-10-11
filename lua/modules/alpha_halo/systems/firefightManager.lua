local balltze = Balltze
local engine = Engine
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local playSound = engine.userInterface.playSound

local blam = require "blam"
local script = require "script"
local hsc = require "hsc"
local luna = require "luna"
local json = require "json"

local skullsManager = require "alpha_halo.systems.gameplay.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local pigPen = require "alpha_halo.systems.core.pigPen"
local announcer = require "alpha_halo.systems.combat.announcer"
local utils = require "alpha_halo.utils"
local const = require "alpha_halo.systems.core.constants"

local firefightManager = {}

-------------------------------------------------------
-- Firefight Config
-------------------------------------------------------

---@enum eventNames
local eventNames = {never = 1, eachWave = 2, eachRound = 3, eachSet = 4, eachBossWave = 5}

---Base Firefight Settings.
---Could be customizable in the future from the Ins menu.
---@class firefightSettings
firefightManager.firefightSettings = {
    _version = 1,
    -- Player properties
    playerInitialLives = 7,
    extraLivesGained = 1,
    livesLostPerDead = 1,
    -- Firefight flow properties
    bossWaveFrequency = 0,
    wavesPerRound = 5,
    roundsPerSet = 3,
    setsPerGame = 3,
    waveLivingMin = 4,
    bossWaveLivingMin = 0,
    startingEnemyTeam = 1, -- 1 = Covenant, 2 = Flood, 3 = Random
    roundEndingBoss = true,
    -- Time properties
    waveCooldownSeconds = 9,
    roundCooldownSeconds = 10,
    setCooldownSeconds = 1,
    gameCooldownSeconds = 1,
    -- Event properties
    activateTemporalSkullEach = eventNames.eachRound,
    resetTemporalSkullEach = eventNames.eachSet,
    activatePermanentSkullEach = eventNames.eachSet,
    permanentSkullsCanBeRandom = true,
    deployAlliesEach = eventNames.eachBossWave
}
local settings = firefightManager.firefightSettings
-- By default, boss waves are the last wave of each round.
settings.bossWaveFrequency = settings.wavesPerRound or 0

local isFirstGameWave = false -- First wave of the game.
local isFirstRoundWave = false -- First wave of the round.
local intermediateWave = false -- Any wave that is not first, boss or last.
local isLastWave = false -- Is the current wave the last wave of the game?
local isCurrentWaveBoss = false -- Is the current wave a boss wave?

---This is the progression of the Firefight.
---It gets updated with firefightManager.progression()
---@enum
firefightManager.gameProgression = { --------------
    totalWaves = 1,
    wave = 1,
    round = 1,
    set = 1,
    currentEnemyTeam = 1,
    isGameOn = false,
    deploymentAllowed = unitDeployer.deployerSettings.deploymentAllowed
}
local progression = firefightManager.gameProgression

function firefightManager.whenMapLoads(call, sleep)
    logger:debug("Welcome to Alpha Firefight")
    logger:debug("firefight is On '{}'", progression.isGameOn)
    firefightManager.reloadGame()
    logger:debug("Waiting 30 ticks before starting game")
    sleep(30)
    script.startup(firefightManager.startGame)
    script.continuous(firefightManager.playerCheck)
end

---Game Start. This begins the process that cycles the firefight to move forward.
function firefightManager.startGame(call, sleep)
    -- If the game is already on, we don't need to start it again.
    if progression.isGameOn then
        return
    end
    -- We set the starting enemy team based on the settings.
    if settings.startingEnemyTeam == 1 then
        progression.currentEnemyTeam = 1 -- "Covenant_Wave"
        unitDeployer.deployerSettings.currentTeam = 1 -- Tell unitDeployer we're having Covies.
    elseif settings.startingEnemyTeam == 2 then
        progression.currentEnemyTeam = 2 -- "Flood_Wave"
        unitDeployer.deployerSettings.currentTeam = 2 -- Tell unitDeployer we're having Flood.
    elseif settings.startingEnemyTeam == 3 then
        local randomTeam = math.random(1, 2)
        progression.currentEnemyTeam = randomTeam
        unitDeployer.deployerSettings.currentTeam = randomTeam -- Tell unitDeployer we're having whichever team was selected.
        logger:debug("Randomly selected starting enemy team: {}", randomTeam)
    end
    -- We wait for the game cooldown before starting the game.
    logger:debug("Waiting {} seconds to start the game", settings.gameCooldownSeconds)
    sleep(utils.secondsToTicks(settings.gameCooldownSeconds))
    -- script.thread(announcer.gameStart)() -- Sound not available?
    progression.isGameOn = true
    firefightManager.waveDefinition()

    -- Start the first set.
    script.wake(firefightManager.startSet)

    -- TODO For testing purposes only, remove for release.
    -- Enable some skulls from the start.
    -- skullsManager.skulls.havok.isEnabled = true
    -- skullsManager.skulls.newton.isEnabled = true

    firefightManager.enableStartingSkulls()

    logger:debug("Game is on! Pain is coming in hot!")
end

-- Functions that are being called each tick.

local waveIsOn = false
local drawNavPoint = false
local livingCount = 0

function firefightManager.eachTick()
    firefightManager.updateSkullsHud()

    if progression.isGameOn then
        firefightManager.aiCheck()
        if waveIsOn and unitDeployer.deployerSettings.deploymentAllowed then -- We hold the wave progression check until previous deployment is done.
            if not isLastWave and
                ((not isCurrentWaveBoss and livingCount <= settings.waveLivingMin) or
                    (isCurrentWaveBoss and livingCount <= settings.bossWaveLivingMin)) then
                script.thread(announcer.reinforcements)()
                firefightManager.firefightProgression()
                waveIsOn = false
            elseif isLastWave and livingCount <= 0 then
                firefightManager.firefightProgression()
                waveIsOn = false
            end
        end
        if drawNavPoint == false and (livingCount <= 4) then
            firefightManager.aiNavpoint()
            drawNavPoint = true
        end
    end
end

-------------------------------------------------------
-- Special Events
-------------------------------------------------------

local events = {}

-- Event Dispatcher. Call events or functions depending on certain conditions.
local function eventDispatcher()
    logger:debug("Dispatching events...")
    logger:debug("#events.eachWave: {}", #events.eachWave)
    if isFirstGameWave or isFirstRoundWave then
        logger:debug("First wave of the game or round!")
        for _, event in pairs(events.eachSet) do
            event()
        end
    end
    if isFirstRoundWave then
        logger:debug("First wave of the round!")
        for _, event in pairs(events.eachRound) do
            event()
        end
    end
    if isCurrentWaveBoss then
        logger:debug("Boss wave!")
        for _, event in pairs(events.eachBossWave) do
            event()
        end
    end
    for _, event in ipairs(events.eachWave) do
        event()
    end
end

events = {
    eachWave = {},
    eachRound = {
        firefightManager.enableTemporalSkull,
        firefightManager.conditionedSpawnPlayerAssistances,
        firefightManager.conditionalAddPlayerLives
    },
    eachSet = {
        firefightManager.conditionedResetAllTemporalSkulls,
        -- firefightManager.conditionedSwitchTeams,
        firefightManager.enablePermanentSkull
    },
    eachBossWave = {firefightManager.deployPlayerAllies}
}

-- Helper function to get function name from its reference, for debug purposes.
---@param fn function
---@return string|nil
local function getModuleFunctionName(fn)
    for name, func in pairs(firefightManager) do
        if func == fn then
            return name
        end
    end
end

--- Load an event into the appropriate list.
---@param actionFunction function The function to be called during the event.
---@param eventIndex? eventNames The index of the event list to load the function into.
local function loadEvent(actionFunction, eventIndex)
    local actionFunctionName = getModuleFunctionName(actionFunction)
    if not eventIndex then
        logger:debug("Skipping action {}, no event index provided", tostring(actionFunctionName))
        return
    end
    local eventName = table.flip(eventNames)[eventIndex]
    if not eventName then
        logger:debug("Skipping action {}, invalid index: {}", tostring(actionFunctionName),
                     tostring(eventIndex))
        return
    end

    local isNever = eventIndex == eventNames.never
    -- Filter out event if it already exists
    for eventName, event in pairs(events) do
        events[eventName] = table.filter(event, function(existingEvent)
            return existingEvent ~= actionFunction or isNever
        end)
    end

    -- Add event to the appropriate list
    if not isNever then
        table.insert(events[eventName], actionFunction)
    end
    logger:debug("Loading event: {} into {}", tostring(actionFunctionName), tostring(eventName))
end

local objectTypes = Engine.tag.objectType
local playerLives
local playerIsDead = false -- This by default is false, obviously.

--- Handle player respawn and lives.
function firefightManager.playerCheck(call, sleep)
    if not playerLives then
        playerLives = settings.playerInitialLives
        logger:debug("Player initial lives: {}", playerLives)
    end
    -- We check if the game is on.
    if not progression.isGameOn then
        return
    end
    -- We get the player.
    local player = getPlayer()
    if not player then
        return
    end
    -- We get the player biped.
    local biped = getObject(player.objectHandle, engine.tag.objectType.biped)
    if not biped then
        -- logger:debug("Player is dead.")
        playerIsDead = true
        -- If lifes are 0 and there's no player biped, then we end the game.
        if playerLives <= 0 then
            logger:info("You lost, sucker!!!")
            script.wake(firefightManager.scriptEndGame)
        end
        return
    end
    -- We do stuff as soon as the player reapears.
    if playerIsDead and biped then
        playerIsDead = false
        playerLives = playerLives - settings.livesLostPerDead
        if playerLives > 0 then
            logger:debug("Lifes left... {}", playerLives)
        end
        if playerLives == 5 then
            sleep(15)
            script.thread(announcer.fiveLivesLeft)()
        end
        if playerLives == 1 then
            sleep(15)
            script.thread(announcer.oneLiveLeft)()
        end
        if playerLives == 0 then
            logger:debug("No lives left.")
            logger:debug("You feel a sense of dread crawling up your spine...")
            sleep(15)
            script.thread(announcer.noLivesLeft)()
        end
    end
end

-- Here we put all out encounter blocks that had bad guys in it.
local badGuys = {
    "Covenant_Wave",
    "Covenant_Support",
    "Flood_Wave",
    "Flood_Support",
    "Covenant_Banshee",
    "Covenant_Snipers",
    "Sentinel_Team",
    "Standby_Dropship"
}

-- We check how many living enemies we have. Also, we call magicalSight every 10 seconds.
local magicalSightCounter = 300
local magicalSightTimer = 0
function firefightManager.aiCheck()
    livingCount = hsc.ai_living_count("Covenant_Wave") + hsc.ai_living_count("Flood_Wave") +
                      hsc.ai_living_count("Standby_Dropship")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        firefightManager.aiSight()
    end
end

-- Enemy AI will magically see and pursuit each other. Will try against players if they're not invisible.
function firefightManager.aiSight()
    -- ODSTs see and follow players.
    hsc.ai_follow_target_players("Human_Team")
    hsc.ai_magically_see_players("Human_Team")

    -- Each enemy team sees and follows ODSTs.
    for _, badGuy in pairs(badGuys) do
        hsc.ai_magically_see_encounter("Human_Team", badGuy)
        hsc.ai_magically_see_encounter(badGuy, "Human_Team")
    end

    -- For each player, each enemy team tries to see and follow them if not invisible.
    local player = blam.biped(get_dynamic_player())
    if not player then
        return
    end
    if player.camoScale < 1 then
        for _, badGuy in pairs(badGuys) do
            hsc.ai_magically_see_players(badGuy)
            if not (badGuy == "Covenant_Banshee") then
                hsc.ai_follow_target_players(badGuy)
            end
        end
    end
end

-- Set a navpoint for remaining enemies.
function firefightManager.aiNavpoint()
    local currentTeam = progression.currentEnemyTeam == 1 and "Covenant_Wave" or "Flood_Wave"
    local navpointType = "default_red"
    local navpointOffset = 0.6
    local playerCount = hsc.list_count(hsc.players())
    for i = 0, playerCount - 1 do
        local playerUnit = hsc.unit(hsc.list_get(hsc.players(), i))
        for actorIndex = 0, 3 do
            local actorUnit = hsc.unit(hsc.list_get(hsc.ai_actors(currentTeam), actorIndex))
            hsc.activate_nav_point_object(navpointType, playerUnit, actorUnit, navpointOffset)
        end
    end
end

-- Give extra lives to the player.
function firefightManager.addPlayerLives()
    -- We add a life to the player.
    logger:info("Lives added!")
    playerLives = playerLives + settings.extraLivesGained
    logger:debug("Current lives: {}", playerLives)
    script.thread(announcer.livesAdded)()
    -- If the player exist, then we restore his health.
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    if biped.vitals.health < 1 then
        biped.vitals.health = 1
    end
end

function firefightManager.conditionalAddPlayerLives()
    if not isFirstGameWave then
        firefightManager.addPlayerLives()
    end
end

-- Switch enemy teams.
function firefightManager.switchTeams()
    if progression.currentEnemyTeam == 1 then
        progression.currentEnemyTeam = 2 -- If we just had Covies, gimme Flood.
        unitDeployer.deployerSettings.currentTeam = 2 -- Tell unitDeployer we're having Floods.
        logger:debug("Switching to Flood Team")
    else
        progression.currentEnemyTeam = 1 -- If we just had Flood, gimme Covies.
        unitDeployer.deployerSettings.currentTeam = 1 -- Tell unitDeployer we're having Covies.
        logger:debug("Switching to Covenant Team")
    end
end

function firefightManager.conditionedSwitchTeams()
    if not isFirstGameWave then
        firefightManager.switchTeams()
    end
end

-- Spawn player assistances (Warthogs and Ghosts).
function firefightManager.spawnPlayerAssistances()
    logger:debug("Spawning player assistances...")
    local ghostAssistTemplate = "reward_ghost_var%s"
    local randomGhost = math.random(1, 3)
    local selectedAssistGhost = ghostAssistTemplate:format(randomGhost)
    pigPen.compactSpawnNamedVehicle(selectedAssistGhost)
    hsc.ai_vehicle_enterable_distance(selectedAssistGhost, 20.0)
    local warthogTemplate = "warthog_%s"
    local randomWarthog = math.random(1, 3)
    local selectedWarthog = warthogTemplate:format(randomWarthog)
    pigPen.compactSpawnNamedVehicle(selectedWarthog)
    hsc.ai_vehicle_enterable_distance(selectedWarthog, 20.0)
end

function firefightManager.conditionedSpawnPlayerAssistances()
    if not isFirstGameWave then
        firefightManager.spawnPlayerAssistances()
    end
end

-- Deploy allies in a Pelican. (ODSTs for now)
function firefightManager.deployPlayerAllies(call, sleep)
    script.wake(unitDeployer.scriptDeployPelicans)
    logger:debug("ODSTs are coming in hot!")
end

-- Turn on all starting skulls.
function firefightManager.enableStartingSkulls()
    local startingSkulls = table.filter(skullsManager.skullList, function(skull)
        return skull.isEnabled
    end)
    if #startingSkulls > 0 then
        logger:info("Activating initial skulls...")
        -- Enable skull with balance
        skullsManager.enableSkulls(startingSkulls, true)
        return
    end
    logger:info("No starting skulls to enable.")
end

-- Turn on a random temporal skull.
function firefightManager.enableTemporalSkull()
    -- playSound(const.sounds.skullOn.handle)
    playSound(const.sounds.hillMove.handle)
    local temporalSkulls = table.filter(skullsManager.skullList, function(skull)
        return not (skull.state.count == skull.state.max) and skull.allowedInRandom
    end)
    if #temporalSkulls > 0 then
        local randomIndex = math.random(1, #temporalSkulls)
        local selectedSkull = temporalSkulls[randomIndex]
        logger:info("Chosen random skull: {}", selectedSkull.name)
        -- Enable skull with balance
        skullsManager.enableSkulls({selectedSkull}, true)
    end
end

-- Turn on a random permanent skull.
function firefightManager.enablePermanentSkull()
    local permanentSkulls = table.filter(skullsManager.skullList, function(skull)
        return skull.isPermanent and not (skull.state.count == skull.state.max) and
                   skull.allowedInRandom
    end)
    if settings.permanentSkullsCanBeRandom then -- If we allow random skulls...
        permanentSkulls = table.filter(skullsManager.skullList, function(skull)
            return not (skull.state.count == skull.state.max) and skull.allowedInRandom -- ... We no longer check previous permanency.
        end)
    end
    if #permanentSkulls > 0 then
        local randomIndex = math.random(1, #permanentSkulls)
        local selectedSkull = permanentSkulls[randomIndex]
        logger:info("Chosen permanent skull: {}", selectedSkull.name)
        -- Enable skull with balance
        selectedSkull.isPermanent = true
        skullsManager.enableSkulls({selectedSkull}, true)
    end
end

-- Reset only temporal skulls.
function firefightManager.resetAllTemporalSkulls()
    playSound(const.sounds.skullsReset.handle)
    local temporalSkulls = table.filter(skullsManager.skullList, function(skull)
        return not skull.isPermanent
    end)
    -- We disable all temporal skulls regardless of balance
    skullsManager.disableSkulls(temporalSkulls)
end

function firefightManager.conditionedResetAllTemporalSkulls()
    if not isFirstGameWave then
        firefightManager.resetAllTemporalSkulls()
    end
end

-------------------------------------------------------
-- HUD Render Functions
-------------------------------------------------------

-- Update the skulls HUD elements
function firefightManager.updateSkullsHud()
    if not (const.hud.skullsIcons and const.hud.skullsInfo) then
        return
    end

    local hudIcons = const.hud.skullsIcons.data
    local hudInfo = const.hud.skullsInfo.data
    local timers = firefightManager.skullInfoTimers or {}
    local prevSkullState = firefightManager.prevSkullStates or {}
    firefightManager.skullInfoTimers = timers
    firefightManager.prevSkullStates = prevSkullState

    local infoColor = {255, 255, 255, 255}
    local emptyColor = {0, 0, 0, 0}

    local function setElementColor(element, color)
        local channels = {"alpha", "red", "green", "blue"}
        for channelIndex, channelName in ipairs(channels) do
            element.defaultColor[channelName] = color[channelIndex]
            element.disabledColor[channelName] = color[channelIndex]
            element.flashingColor[channelName] = color[channelIndex]
        end
    end

    -- We create a table with the currently active skulls in the queue for easy lookup.
    local activeInfoInQueue = {}
    for _, skullObj in ipairs(skullsManager.enabledSkullsQueue) do
        if skullObj and skullObj.isEnabled then
            local skullName = table.keyof(skullsManager.skulls, skullObj)
            if skullName then
                activeInfoInQueue[skullName] = true
            end
        end
    end

    -- We clean up prevSkullState and timers tables from skulls that are no longer active.
    for existingKey, _ in pairs(prevSkullState) do
        if not activeInfoInQueue[existingKey] then
            prevSkullState[existingKey] = false
            timers[existingKey] = nil
        end
    end

    -- Skull Icons HUD
    for i = 1, hudIcons.staticElements.count do
        local currentSkullIcon =
            skullsManager.enabledSkullsQueue[#skullsManager.enabledSkullsQueue - (i - 1)]
        local skullIconElement = hudIcons.staticElements.elements[i]

        if currentSkullIcon and currentSkullIcon.isEnabled then
            local skullName = table.keyof(skullsManager.skulls, currentSkullIcon)
            skullIconElement.sequenceIndex =
                (table.indexof(skullsManager.skullsHudOrder, skullName) or 1) - 1

            -- Kiwi Color
            local colorToUse = {255, 89, 255, 5}

            if currentSkullIcon.isPermanent then
                -- Red Color
                colorToUse = {255, 248, 57, 15}
            end

            setElementColor(skullIconElement, colorToUse)
        else
            skullIconElement.sequenceIndex = 0
            setElementColor(skullIconElement, emptyColor)
        end
    end

    -- Skull Info HUD
    for i = 1, hudInfo.staticElements.count do
        local currentSkullInfo =
            skullsManager.enabledSkullsQueue[#skullsManager.enabledSkullsQueue - (i - 1)]
        local skullInfoElement = hudInfo.staticElements.elements[i]
        local skullName = currentSkullInfo and table.keyof(skullsManager.skulls, currentSkullInfo)
        local skullIsActive = currentSkullInfo and skullName and currentSkullInfo.isEnabled
        local skullWasActive = skullName and prevSkullState[skullName]
        -- We manage the timers for showing/hiding skull info.
        if skullName then
            if skullIsActive and not skullWasActive then
                timers[skullName] = os.clock()
            elseif not skullIsActive and skullWasActive then
                timers[skullName] = nil
            end
        end

        -- We show the skull info if it's active or if it was recently deactivated.
        if skullName and timers[skullName] then
            local disappearTime = 12
            local elapsed = os.clock() - timers[skullName]
            if elapsed < disappearTime then
                skullInfoElement.sequenceIndex = (table.indexof(skullsManager.skullsHudOrder,
                                                                skullName) or 1) - 1
                setElementColor(skullInfoElement, infoColor)
            else
                skullInfoElement.sequenceIndex = 0
                setElementColor(skullInfoElement, emptyColor)
                timers[skullName] = nil
            end
        else
            skullInfoElement.sequenceIndex = 0
            setElementColor(skullInfoElement, emptyColor)
        end

        if skullName then
            prevSkullState[skullName] = skullIsActive
        end
    end
end

function firefightManager.onEachFrame()
    local drawText = balltze.chimera.draw_text
    local align = "right"
    local bounds = {left = -8, top = 390, right = 640, bottom = 480}
    local r, g, b = 255, 187, 0
    local textColor = {1.0, r / 255, g / 255, b / 255}
    local titleText = const.fonts.title.handle.value
    local standardText = const.fonts.text.handle.value
    local textColorW = {1.0, 1.0, 1.0, 1.0}

    -- Show current game progression info
    local text = ("Set: {set} Round: {round} Wave: {wave}"):template(
                     firefightManager.gameProgression)
    drawText(text, bounds.left, bounds.top, bounds.right, bounds.bottom, titleText, align,
             table.unpack(textColor))

    -- Draw current lifes
    local livesText = ("Lives: {lives}"):template({lives = playerLives or 0})
    drawText(livesText, bounds.left, bounds.top - 20, bounds.right, bounds.bottom, titleText, align,
             table.unpack(textColor))

    -- Draw the number of times each skull was activated
    if const.hud.skullsIcons then
        local hudIcons = const.hud.skullsIcons.data

        for i = 1, hudIcons.staticElements.count do
            local skullObj = skullsManager.enabledSkullsQueue[#skullsManager.enabledSkullsQueue -
                                 (i - 1)]
            local skullElement = hudIcons.staticElements.elements[i]

            if skullObj and skullObj.isEnabled then
                local skullName = table.keyof(skullsManager.skulls, skullObj)

                if skullName then
                    local count = skullsManager.skulls[skullName].state.count or 1

                    if count >= 1 then
                        local y = bounds.top - skullElement.anchorOffset.y + 80
                        local multText = "x" .. tostring(count)
                        drawText(multText, bounds.left, y, bounds.right + 5, bounds.bottom,
                                 standardText, align, table.unpack(textColorW))
                    end
                end
            end
        end
    end
end

-------------------------------------------------------
-- Firefight Progression
-------------------------------------------------------

---This moves the Firefight one wave, round or set forward.
---It's called AFTER a completed wave, not when the game starts.
---This is the only function that can alter the progression list.
function firefightManager.firefightProgression()
    if not (progression.wave == settings.wavesPerRound) then -- If we hadn't reach the wavePerRound limit...
        progression.wave = progression.wave + 1
        script.wake(firefightManager.startWave) -- Keep counting and start the next wave, and...!
    else -- If we reached the wavePerRound limit...
        progression.wave = 1
        if not (progression.round == settings.roundsPerSet) then -- If we hadn't reach the roundsPerSet limit...
            progression.round = progression.round + 1
            script.wake(firefightManager.startRound) -- Keep counting and start the next round!
        else -- If we reached the roundsPerSet limit...
            progression.round = 1 -- Reset the round to 1 and check set status!
            if not (progression.set == settings.setsPerGame) then -- If we hadn't reach the setsPerGame limit...
                progression.set = progression.set + 1
                script.wake(firefightManager.startSet) -- Keep counting and start the next set!
            else -- If we reached the setsPerGame limit...
                logger:debug("You won. Go brag about it, prick.")
                script.wake(firefightManager.scriptEndGame) -- End the game!
            end
        end
    end
    progression.totalWaves = progression.totalWaves + 1
    firefightManager.waveDefinition()
    -- We announce bad guys coming in.
    logger:debug("Bad guys coming in...")
end

--- Define in which type of wave are we depending on the settings.
function firefightManager.waveDefinition()
    isFirstRoundWave = progression.wave == 1
    local isRoundEndingBoss = (settings.roundEndingBoss == true) and
                                  (progression.wave == settings.wavesPerRound) -- Boss at the end of the round.
    local isBossFrequencyMeet = (settings.bossWaveFrequency > 0 and
                                    math.fmod(progression.totalWaves, settings.bossWaveFrequency) ==
                                    0) -- Boss at the player's choice.
    isCurrentWaveBoss = isRoundEndingBoss or isBossFrequencyMeet -- Either methods can coexist or not in a game. Both are considered as bossWaves.
    isFirstGameWave = (progression.wave == 1) and (progression.round == 1) and
                          (progression.set == 1)
    -- progression.totalWaves == 1 (for unknown reasons, using totalWaves don't work)
    isLastWave = (progression.wave == settings.wavesPerRound) and
                     (progression.round == settings.roundsPerSet) and
                     (progression.set == settings.setsPerGame)
    -- We define what is a randomWave.
    intermediateWave = not (isFirstRoundWave or isCurrentWaveBoss or isFirstGameWave or isLastWave)
end

---Set Start. Calls round start.
function firefightManager.startSet(call, sleep)
    sleep(utils.secondsToTicks(settings.setCooldownSeconds))
    script.thread(announcer.setStart)()
    script.wake(firefightManager.startRound)
end

---Round Start. Calls wave start.
function firefightManager.startRound(call, sleep)
    sleep(utils.secondsToTicks(settings.roundCooldownSeconds))
    script.thread(announcer.roundStart)()
    script.wake(firefightManager.startWave)
end

---Wave Starts. Deploys wave units.
function firefightManager.startWave(call, sleep)
    eventDispatcher()
    sleep(utils.secondsToTicks(settings.waveCooldownSeconds))
    -- script.thread(announcer.waveStart)() -- Sound not available?
    if (isFirstGameWave or isFirstRoundWave) and (not isCurrentWaveBoss) then
        unitDeployer.waveDeployer("starting")
    elseif intermediateWave then
        unitDeployer.waveDeployer("random")
    elseif isCurrentWaveBoss then
        unitDeployer.waveDeployer("boss")
    end
    hsc.garbage_collect_now()
    -- This will be eventually replaced by a proper UI message.
    logger:debug("Wave {}, Round {}, Set {}.", progression.wave, progression.round, progression.set)
    if isLastWave then
        logger:debug("Hang in there, just one final effort...")
    end
    waveIsOn = true
    drawNavPoint = false
end

-------------------------------------------------------
-- Utils
-------------------------------------------------------

---Useful functions for the game.
---This is where reloadGame, endGame and onTick functions are located.

---Reload Game.
---This function is called to reset all systems, clearing AI and resetting all states.
---It's coming handy when you execute |balltze_reload_plugins|
function firefightManager.reloadGame()
    progression.isGameOn = false
    waveIsOn = false
    progression.set = 1
    progression.round = 1
    progression.wave = 1
    hsc.ai_erase_all()
    hsc.object_destroy_containing("dropship")
    hsc.garbage_collect_now()
    skullsManager.disableSkull("all")
    logger:debug("Game reload completed")
end

---End Game.
function firefightManager.scriptEndGame(call, sleep)
    progression.isGameOn = false
    waveIsOn = false
    hsc.ai_erase_all()
    hsc.object_destroy_containing("dropship")
    hsc.garbage_collect_now()
    sleep(utils.secondsToTicks(3))
    execute_script("sv_end_game")
end

function firefightManager.loadSettings()
    logger:debug("Loading Firefight settings from file...")
    local path = balltze.filesystem.getPluginPath():split("\\")
    local pluginsPath = table.concat(path, "\\", 1, #path - 1)
    local settingsPath = pluginsPath .. "\\lua_insurrection\\firefight_settings.json"
    logger:debug("Settings path: {}", settingsPath)
    local settingsFile = luna.file.read(settingsPath)

    -- local settingsFile = balltze.filesystem.readFile(settingsPath)
    if settingsFile then
        local success, data = pcall(json.decode, settingsFile)
        if success and type(data) == "table" then
            settings = table.merge(settings, data) --[[@as firefightSettings]]

            -- Load events properties
            loadEvent(firefightManager.enableTemporalSkull, settings.activateTemporalSkullEach)
            loadEvent(firefightManager.enablePermanentSkull, settings.activatePermanentSkullEach)
            loadEvent(firefightManager.conditionedResetAllTemporalSkulls,
                      settings.resetTemporalSkullEach)
            loadEvent(firefightManager.deployPlayerAllies, settings.deployAlliesEach)
            logger:info("Firefight settings loaded from file.")
            return
        end
        logger:warn("Failed to decode settings file, using default settings. Error: {}", data)
        return
    end
    logger:warn("Settings file not found, using default settings.")
end

return firefightManager
