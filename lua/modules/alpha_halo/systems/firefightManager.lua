-- 📁 modules/project_modules/systems/firefight/manager.lua
local balltze = Balltze
local engine = Engine

local blam = require "blam"
local script = require "script"
local hsc = require "hsc"

local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local pigPen = require "alpha_halo.systems.core.pigPen"
local healthManager = require "alpha_halo.systems.combat.healthManager"
--local eventsManager = require "alpha_halo.systems.firefight.eventsManager"
local announcer = require "alpha_halo.systems.combat.announcer"

local firefightManager = {}

-------------------------------------------------------
-- Firefight Config
-------------------------------------------------------

---Base Firefight Settings.
---Could be customizable in the future from the Ins menu.
---@enum
firefightManager.firefightSettings = { --------------
    playerInitialLives = 7,

    bossWaveFrequency = 0,
    wavesPerRound = 5,
    roundsPerSet = 3,
    setsPerGame = 3,

    waveLivingMin = 4,
    bossWaveLivingMin = 0, -- The game kinda brokes if this is set for continuous waves.

    waveCooldown = 270,
    roundCooldown = 300,
    setCooldown = 30,
    gameCooldown = 30,
    --eventsManager.eventsSettings.randomEventTimer == 4200,

    startingEnemyTeam = 1, -- 1 = Covenant, 2 = Flood, 3 = Random

    ---Index (Gotta proper find a solution for this):
    ---0 = Each Wave
    ---1 = Each Round
    ---2 = Each Set
    ---3 = Each Boss Wave
    ---4 = Never
    switchTeamFrequency = 2, -- We swap teams each set start.
    gameAssistancesFrequency = 1, -- We spawn assistances each round start.
    alliesArrivalFrequency = 4, -- We deploy allies each round start for singleplayer version.
    temporalSkullsFrequency = 1, -- We apply temporal skulls each round start.
    resetSkullsFrequency = 4, -- We reset skulls NEVEEEEER NEVER.
    permanentSkullsFrequency = 2 -- We apply permanent skulls each set start.
}
local settings = firefightManager.firefightSettings

---This is the progression of the Firefight.
---It gets updated with firefightManager.progression()
---@enum
firefightManager.gameProgression = { --------------
    wave = 1,
    round = 1,
    set = 1,
    wavesTilBoss = 1,
    currentEnemyTeam = 0,
    deploymentAllowed = unitDeployer.deployerSettings.deploymentAllowed
}
local progression = firefightManager.gameProgression

---Map Loads. This happens right at the very first tick of the game.
local gameIsOn = false
function firefightManager.whenMapLoads(call, sleep)
    logger:debug("Welcome to Alpha Firefight")
    --hsc.hud_set_objective_text("Welcome to Alpha Firefight")
    logger:debug("firefight is On '{}'", gameIsOn)
    firefightManager.reloadGame()
    logger:debug("Waiting 30 ticks before starting game")
    sleep(30)
    script.startup(firefightManager.startGame)
end

---Game Start. This begins the process that cycles the firefight to move forward.
function firefightManager.startGame(call, sleep)
    -- If the game is already on, we don't need to start it again.
    if gameIsOn then
        return
    end
    -- We set the starting enemy team based on the settings.
    if settings.startingEnemyTeam == 1 then
        progression.currentEnemyTeam = 1 --"Covenant_Wave"
        unitDeployer.deployerSettings.currentTeam = 1 -- Tell unitDeployer we're having Covies.
    elseif settings.startingEnemyTeam == 2 then
        progression.currentEnemyTeam = 2 --"Flood_Wave"
        unitDeployer.deployerSettings.currentTeam = 2 -- Tell unitDeployer we're having Flood.
    elseif settings.startingEnemyTeam == 3 then
        local randomTeam = math.random(1, 2)
        progression.currentEnemyTeam = randomTeam
        unitDeployer.deployerSettings.currentTeam = randomTeam -- Tell unitDeployer we're having whichever team was selected.
        logger:debug("Randomly selected starting enemy team: {}", randomTeam)
    end
    -- We wait for the game cooldown before starting the game.
    logger:debug("Waiting {} ticks to start the game", settings.gameCooldown)
    sleep(settings.gameCooldown)
    --script.thread(announcer.gameStart)() -- Sound not available?
    gameIsOn = true
    firefightManager.waveDefinition() -- Define in which type of wave are we depending on the settings.
    script.wake(firefightManager.startSet) -- Start the first set.
    logger:debug("Game is on! Pain is coming in hot!")
end

---Functions that are being called each tick.
local waveIsOn = false
local drawNavPoint = false
local livingCount = 0
local bossWave = false -- This should be with the other variables on top of firefightProgression...
local lastWave = false -- ...but it's needed here by the eachTick function.
function firefightManager.eachTick()
    if gameIsOn == true then
        firefightManager.aiCheck()
        progression.deploymentAllowed = unitDeployer.deployerSettings.deploymentAllowed -- Do we really need to check this each tick?
        if waveIsOn == true and progression.deploymentAllowed == true then -- We hold this 'til aiExitVehicle is over.
            if not lastWave and ((not bossWave and livingCount <= settings.waveLivingMin)
            or (bossWave and livingCount <= settings.bossWaveLivingMin)) then
                script.thread(announcer.reinforcements)()
                firefightManager.firefightProgression()
                waveIsOn = false
            elseif lastWave and livingCount <= 0 then
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

---This moves the Firefight one wave, round or set forward.
---It's called AFTER a completed wave, not when the game starts.
---This is the only function that can alter the progression list.
function firefightManager.firefightProgression()
    if not (progression.wave == settings.wavesPerRound) then -- If we hadn't reach the wavePerRound limit...
        progression.wave = progression.wave + 1
        script.wake(firefightManager.startWave) -- Keep counting and start the next wave, and...!
        if not (progression.wavesTilBoss == settings.bossWaveFrequency) then
            progression.wavesTilBoss = progression.wavesTilBoss + 1
        else
            progression.wavesTilBoss = 1
        end
    else -- If we reached the wavePerRound limit...
        progression.wave = 1
        progression.wavesTilBoss = 1 -- Reset the wave to 1 and check round status!
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
                firefightManager.endGame() -- End the game!
            end
        end
    end
    firefightManager.waveDefinition()
    -- We announce bad guys coming in.
    logger:debug("Bad guys coming in...")
end

local firstWave = false -- First wave of the game.
local startingWave = false -- First wave of the round.
local randomWave = false -- Random wave.
-- local lastWave = false -- Last wave of the game. These two bools are actually above eachTick...
-- local bossWave = false -- Boss wave. ...bc that function needs them for the livingCount.
function firefightManager.waveDefinition()
    -- We define what is the startingWave.
    startingWave = (progression.wave == 1)
    -- We define what is the bossWave.
    bossWave = ((progression.wave == settings.wavesPerRound) or
            (progression.wavesTilBoss == settings.bossWaveFrequency))
    -- We define what is the firstWave.
    firstWave = ((progression.wave == 1) and
            (progression.round == 1) and
            (progression.set == 1))
    -- We define what is the lastWave.
    lastWave = ((progression.wave == settings.wavesPerRound) and
            (progression.round == settings.roundsPerSet) and
            (progression.set == settings.setsPerGame))
    -- We define what is a randomWave.
    randomWave = not (startingWave or bossWave or firstWave or lastWave)
end

---Set Start. Calls round start.
function firefightManager.startSet(call, sleep)
    sleep(settings.setCooldown)
    script.thread(announcer.setStart)()
    script.wake(firefightManager.startRound)
end

---Round Start. Calls wave start.
function firefightManager.startRound(call, sleep)
    sleep(settings.roundCooldown)
    script.thread(announcer.roundStart)()
    script.wake(firefightManager.startWave)
end

---Wave Starts. Deploys wave units.
function firefightManager.startWave(call, sleep)
    firefightManager.switchTeams()
    firefightManager.gameAssistances()
    firefightManager.alliesDeployer()
    firefightManager.temporalSkull()
    firefightManager.resetSkulls()
    firefightManager.permanentSkull()
    sleep(settings.waveCooldown)
    --script.thread(announcer.waveStart)() -- Sound not available?
    if (firstWave or startingWave) and (not bossWave) then
        unitDeployer.waveDeployer("starting")
    elseif randomWave then
        unitDeployer.waveDeployer("random")
    elseif bossWave then
        unitDeployer.waveDeployer("boss")
    end
    hsc.garbage_collect_now()
    local waveTemplate = "Wave %s, Round %s, Set %s."
    local actualWave = waveTemplate:format(progression.wave, progression.round, progression.set)
    logger:debug(actualWave) -- This will be eventually replaced by a proper UI message.
    if lastWave then
        logger:debug("Hang in there, just one final effort...")
    end
    waveIsOn = true
    drawNavPoint = false
end

---- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ----
---- THIS FUNCTION HANDLES THE PLAYER RESPAWN ----
---- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ----
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local objectTypes = Engine.tag.objectType
local playerLives = settings.playerInitialLives
local playerIsDead = false -- This by default is false, obviously.
function firefightManager.playerCheck(call, sleep)
    -- We check if the game is on.
    if gameIsOn == true then
        -- We get the player.
        local player = getPlayer()
        if not player then
            return
        end
        -- We get the player biped.
        local biped = getObject(player.objectHandle, engine.tag.objectType.biped)
        if not biped then
            playerIsDead = true
            -- If lifes are 0 and there's no player biped, then we end the game.
            if playerLives == 0 then
                logger:debug("You lost, sucker!!!")
                firefightManager.endGame()
            end
            return -- Do we really need these returns here?
        end
        -- We do stuff as soon as the player reapears.
        if playerIsDead and biped then
            playerIsDead = false
            playerLives = playerLives - 1
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
end
script.continuous(firefightManager.playerCheck)

---- THIS FUNCTION GAVES A LIFE TO THE PLAYER ----
function firefightManager.livesGained(call, sleep)
    logger:debug("Lives added!")
    playerLives = playerLives + 1
    sleep(90)
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    script.thread(announcer.livesAdded)()
    biped.vitals.health = 1
end

-------------------------------------------------------
-- Special Events
-------------------------------------------------------
---- SWITCH ENEMY TEAMS ----
function firefightManager.switchTeams()
    local switchFreq = settings.switchTeamFrequency
    local wave = progression.wave
    local round = progression.round
    if (not firstWave) and ((switchFreq == 0) or (switchFreq == 1 and wave == 1) or (switchFreq == 2 and wave == 1 and round == 1) or (switchFreq == 3 and bossWave)) then
        if progression.currentEnemyTeam == 1 then
            progression.currentEnemyTeam = 2 -- If we just had Covies, gimme Flood.
            unitDeployer.deployerSettings.currentTeam = 2 -- Tell unitDeployer we're having Floods.
            logger:debug("Switching to Flood Team")
        else
            progression.currentEnemyTeam = 1 -- If we just had Flood, gimme Covies.
            unitDeployer.deployerSettings.currentTeam = 1 -- Tell unitDeployer we're having Covies.
            logger:debug("Switching to Covenant Team")
        end
    else
        logger:debug("No criteria was met for switchTeam")
        return
    end
end

---- GAIN A LIFE & SPAWN WARTHOGS AND GHOSTS ----
function firefightManager.gameAssistances()
    local assistFreq = settings.gameAssistancesFrequency
    local wave = firefightManager.gameProgression.wave
    local round = firefightManager.gameProgression.round
    if (assistFreq == 0) or (assistFreq == 1 and wave == 1) or (assistFreq == 2 and wave == 1 and round == 1) or (assistFreq == 3 and bossWave) then
        script.thread(firefightManager.livesGained)()
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
    else
        logger:debug("No criteria was met for gameAssistances")
        return
    end
end

---- DEPLOY ODSTS IN PELICAN ----
function firefightManager.alliesDeployer(call, sleep)
    local alliesFreq = settings.alliesArrivalFrequency
    local wave = firefightManager.gameProgression.wave
    local round = firefightManager.gameProgression.round
    if (alliesFreq == 0) or (alliesFreq == 1 and wave == 1) or (alliesFreq == 2 and wave == 1 and round == 1) or (alliesFreq == 3 and bossWave) then
        script.wake(unitDeployer.pelicanDeployer)
        logger:debug("ODSTs are coming in hot!")
    else
        logger:debug("No criteria was met for alliesDeployer")
        return
    end
end

---- TURN ON A TEMPORAL SKULL ----
function firefightManager.temporalSkull()
    local temporalFreq = settings.temporalSkullsFrequency
    local wave = firefightManager.gameProgression.wave
    local round = firefightManager.gameProgression.round
    if (temporalFreq == 0) or (temporalFreq == 1 and wave == 1) or (temporalFreq == 2 and wave == 1 and round == 1) or (temporalFreq == 3 and bossWave) then
        skullsManager.enableSkull("silver", "random")
    else
        logger:debug("Freq: {} - Wave: {} - Round: {} - No criteria was met for temporalSkull", temporalFreq, wave, round)
        return
    end
end

---- TURN ON A PERMANENT SKULL ----
function firefightManager.permanentSkull()
    local permanentFreq = settings.permanentSkullsFrequency
    local wave = firefightManager.gameProgression.wave
    local round = firefightManager.gameProgression.round
    if (permanentFreq == 0) or (permanentFreq == 1 and wave == 1) or (permanentFreq == 2 and wave == 1 and round == 1) or (permanentFreq == 3 and bossWave) then
        skullsManager.enableSkull("golden", "random")
    else
        logger:debug("Freq: {} - Wave: {} - Round: {} - No criteria was met for permanentSkull", permanentFreq, wave, round)
        return
    end
end

---- RESETS ALL SKULLS, THEN RESTORE PERMANENT SKULLS ----
function firefightManager.resetSkulls()
    local resetFreq = settings.resetSkullsFrequency
    local wave = firefightManager.gameProgression.wave
    local round = firefightManager.gameProgression.round
    if (resetFreq == 0) or (resetFreq == 1 and wave == 1) or (resetFreq == 2 and wave == 1 and round == 1) or (resetFreq == 3 and bossWave) then
        skullsManager.disableSkull("silver", "all")
        skullsManager.disableSkull("golden", "all")
        skullsManager.enableSkull("golden", "is_permanent")
    else
        logger:debug("No criteria was met for resetSkulls")
        return
    end
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
    gameIsOn = false
    waveIsOn = false
    drawNavPoint = false
    hsc.ai_erase_all()
    hsc.object_destroy_containing("dropship")
    hsc.garbage_collect_now()
    skullsManager.disableSkull("silver", "is_spent")
    skullsManager.disableSkull("golden", "is_spent")
    logger:debug("Game reload completed")
end

---End Game.
function firefightManager.endGame()
    gameIsOn = false
    waveIsOn = false
    drawNavPoint = false
    -- logger:debug("Firefight is on '{}'", gameIsOn)
    -- logger:debug("Wave is on '{}'", waveIsOn)
    progression.set = 0
    progression.round = 0
    progression.wave = 0
    -- logger:debug("Set, Round and Wave reset to '0'")
    hsc.ai_erase_all()
    hsc.garbage_collect_now()
    execute_script("sv_end_game")
end

-- We check how many living enemies we have. Also, we call magicalSight every 10 seconds.
local magicalSightCounter = 30
local magicalSightTimer = 0
function firefightManager.aiCheck()
    livingCount = hsc.ai_living_count("Covenant_Wave") + hsc.ai_living_count("Flood_Wave") + hsc.ai_living_count("Standby_Dropship")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        firefightManager.aiSight()
    end
end

-- Here we put all out encounter blocks that had bad guys in it.
local badGuys = {
    "Covenant_Wave",
    "Covenant_Support",
    "Flood_Wave",
    "Flood_Support",
    "Covenant_Banshees",
    "Covenant_Snipers",
    "Sentinel_Team",
    "Standby_Dropship",
}

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


return firefightManager
