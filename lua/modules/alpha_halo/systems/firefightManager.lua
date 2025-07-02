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
local announcer = require "alpha_halo.systems.combat.announcer"

local firefightManager = {}

-------------------------------------------------------
-- Firefight Config
-------------------------------------------------------

---Base Firefight Settings.
---Could be customizable in the future from the Ins menu.
---@enum
firefightManager.firefightSettings = { --------------
    wavesPerRound = 5,
    roundsPerSet = 3,
    setsPerGame = 3,

    waveCooldown = 150,
    roundCooldown = 150,
    setCooldown = 30,
    gameCooldown = 30,

    startingEnemyTeam = 2, -- 1 = Covenant, 2 = Flood, 3 = Random

    ---Index (Gotta proper find a solution for this):
    ---0 = Each Wave
    ---1 = Each Round
    ---2 = Each Set
    ---3 = Each Boss Wave
    ---4 = Never
    switchTeamFrequency = 2, -- We swap teams each set start.
    gameAssistancesFrequency = 1, -- We spawn assistances each round start.
    alliesArrivalFrequency = 3, -- We deploy allies each boss wave.
    temporalSkullsFrequency = 1, -- We apply temporal skulls each round start.
    resetSkullsFrequency = 4, -- We reset skulls NEVEEER NEVER FOREVER.
    permanentSkullsFrequency = 2 -- We apply permanent skulls each set start.
}
local settings = firefightManager.firefightSettings

---This is the progression of the Firefight.
---It gets updated with firefightManager.progression()
---@enum
firefightManager.gameProgression = { --------------
    wave = 0,
    round = 0,
    set = 0,
    currentEnemyTeam = 0, --0 till defined by startingEnemyTeam on startGame. Get's changed my switchTeams.
}
local progression = firefightManager.gameProgression

---Map Loads. This happens right at the very first tick of the game.
local gameIsOn = false
function firefightManager.whenMapLoads(call, sleep)
    logger:debug("Welcome to Alpha Firefight")
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
    firefightManager.firefightProgression()
    logger:debug("Game is on! Pain is coming in hot!")
end

---Funciones que se ejecutan cada tick del juego.
local waveIsOn = false
local livingCount = 0
function firefightManager.eachTick()
    if gameIsOn == true then
        firefightManager.aiCheck()
        if waveIsOn == true then
            if livingCount <= 4 then
                script.thread(announcer.reinforcements)()
                firefightManager.aiNavpoint()
                firefightManager.firefightProgression()
                waveIsOn = false
            end
        end
    end
end

---This moves the Firefight one wave, round or set forward.
---It's called when game starts and after a completed wave.
function firefightManager.firefightProgression()
    if progression.wave == 0 then
        progression.wave = progression.wave + 1
        progression.round = progression.round + 1
        progression.set = progression.set + 1
        script.wake(firefightManager.startSet)
    elseif progression.wave < settings.wavesPerRound then
        progression.wave = progression.wave + 1
        script.wake(firefightManager.startWave)
    elseif progression.wave == settings.wavesPerRound then
        if progression.round < settings.roundsPerSet then
            progression.wave = progression.wave + 1
            script.wake(firefightManager.startRound)
        elseif progression.round == settings.roundsPerSet then
            progression.set = progression.set + 1
            script.wake(firefightManager.startSet)
        end
    end
    firefightManager.switchTeams()
    firefightManager.gameAssistances()
    firefightManager.alliesDeployer()
    firefightManager.temporalSkull()
    firefightManager.resetSkulls()
    firefightManager.permanentSkull()
end

---Set Start. Primes first round and calls it.
function firefightManager.startSet(call, sleep)
    sleep(settings.setCooldown)
    script.thread(announcer.setStart)()
    progression.round = 1
    script.wake(firefightManager.startRound)
end

---Round Start. Primes first wave and calls it.
function firefightManager.startRound(call, sleep)
    sleep(settings.roundCooldown)
    script.thread(announcer.roundStart)()
    progression.wave = 1
    script.wake(firefightManager.startWave)
end

---Wave Starts. Deploys wave units.
function firefightManager.startWave(call, sleep)
    sleep(settings.waveCooldown)
    --script.thread(announcer.waveStart)() -- Sound not available?
    if progression.wave == 1 then
        unitDeployer.waveDeployer("starting")
    elseif progression.wave < settings.wavesPerRound then
        unitDeployer.waveDeployer("random")
    elseif progression.wave == settings.wavesPerRound then
        unitDeployer.waveDeployer("boss")
    end
    hsc.garbage_collect_now()
    local waveTemplate = "Wave %s, Round %s, Set %s."
    local actualWave = waveTemplate:format(progression.wave, progression.round, progression.set)
    logger:debug(actualWave) -- This will be eventually replaced by a proper UI message.
    waveIsOn = true
end

-------------------------------------------------------
-- Special Events
-------------------------------------------------------
---- SWITCH ENEMY TEAMS ----
function firefightManager.switchTeams()
    local switchFreq = settings.switchTeamFrequency
    local wave = progression.wave
    local round = progression.round
    local set = progression.set
    local startingGame = (wave == 1 and round == 1 and set == 1)
    if (not startingGame) and ((switchFreq == 0) or (switchFreq == 1 and wave == 1) or (switchFreq == 2 and wave == 1 and round == 1) or (switchFreq == 3 and wave == 5)) then
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
    if (assistFreq == 0) or (assistFreq == 1 and wave == 1) or (assistFreq == 2 and wave == 1 and round == 1) or (assistFreq == 3 and wave == 5) then
        script.thread(healthManager.livesGained)()
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
    if (alliesFreq == 0) or (alliesFreq == 1 and wave == 1) or (alliesFreq == 2 and wave == 1 and round == 1) or (alliesFreq == 3 and wave == 5) then
        script.wake(unitDeployer.pelicanDeployer)
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
    if (temporalFreq == 0) or (temporalFreq == 1 and wave == 1) or (temporalFreq == 2 and wave == 1 and round == 1) or (temporalFreq == 3 and wave == 5) then
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
    if (permanentFreq == 0) or (permanentFreq == 1 and wave == 1) or (permanentFreq == 2 and wave == 1 and round == 1) or (permanentFreq == 3 and wave == 5) then
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
    if (resetFreq == 0) or (resetFreq == 1 and wave == 1) or (resetFreq == 2 and wave == 1 and round == 1) or (resetFreq == 3 and wave == 5) then
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
        hsc.ai_follow_target_players(badGuy)
        hsc.ai_magically_see_encounter("Human_Team", badGuy)
        hsc.ai_magically_see_encounter(badGuy, "Human_Team")
    end
    -- For each player, each enemy team tries to see and follow them if not invisible.
    local player = blam.biped(get_dynamic_player())
    assert(player)
    if player.camoScale < 1 then
        for _, badGuy in pairs(badGuys) do
            hsc.ai_follow_target_players(badGuy)
            hsc.ai_magically_see_players(badGuy)
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
