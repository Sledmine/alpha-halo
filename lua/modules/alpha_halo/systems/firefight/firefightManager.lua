-- 📁 modules/project_modules/systems/firefight/manager.lua
local balltze = Balltze
local engine = Engine
local eventsManager = require "alpha_halo.systems.firefight.events"
local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local pigPen = require "alpha_halo.systems.core.pigPen"
local healthManager = require "alpha_halo.systems.combat.healthManager"
local announcer = require "alpha_halo.systems.combat.announcer"
local script = require "script"
local hsc = require "hsc"

local firefightManager = {}

-------------------------------------------------------
-- Firefight Config
-------------------------------------------------------

local firefightIsOn = false
local waveIsOn = false
local cooldown = false
local counter = 0
local time = 150

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

    startingEnemyTeam = 2, -- 0 = Covenant, 1 = Flood, 2 = Random

    ---Index (Gotta proper find a solution for this):
    ---0 = Each Wave
    ---1 = Each Round
    ---2 = Each Set
    ---3 = Each Boss Wave
    ---4 = Never
    switchTeamFrequency = 1,
    gameAssistancesFrequency = 1,
    alliesArrivalFrequency = 3,
    temporalSkullsFrequency = 0,
    resetSkullsFrequency = 1,
    permanentSkullsFrequency = 1
}
local settings = firefightManager.firefightSettings

---This is the progression of the Firefight.
---It gets updated with firefightManager.progression()
---@enum
firefightManager.gameProgression = { --------------
    wave = 0,
    round = 0,
    set = 0,
    currentEnemyTeam = 1, --1 = Covenant, 2 = Flood
}
local progression = firefightManager.gameProgression

---Firefight Start Welcome
function firefightManager.whenMapLoads(call, sleep)
    logger:debug("Welcome to Alpha Firefight")
    logger:debug("firefight is On '{}'", firefightIsOn)
    firefightManager.cleanup()
    logger:debug("Waiting 30 ticks before starting Firefight")
    sleep(30)
    script.startup(firefightManager.startGame)
end

---Game Start. This begins the process that cycles the firefight to move forward.
function firefightManager.startGame(call, sleep)
    if firefightIsOn then
        return
    end
    firefightIsOn = true
    --script.thread(announcer.gameStart)() -- Sound not available?
    logger:debug("Firefight is On '{}'", firefightIsOn)
    logger:debug("Waiing 30 ticks")
    sleep(30)
    firefightManager.firefightProgression()
    if settings.startingEnemyTeam == 0 then
        progression.currentEnemyTeam = 1 --"Covenant_Wave"
    elseif settings.startingEnemyTeam == 1 then
        progression.currentEnemyTeam = 2 --"Flood_Wave"
    elseif settings.startingEnemyTeam == 2 then
        local randomTeam = math.random(1, 2)
        progression.currentEnemyTeam = randomTeam
    end
end

---This moves the Firefight one wave, round or set forward.
---It's called when game starts and after a completed wave.
function firefightManager.firefightProgression()
    if progression.wave < settings.wavesPerRound then
        progression.wave = progression.wave + 1
        script.wake(firefightManager.startWave)
    elseif progression.wave == settings.wavesPerRound then
        if progression.round < settings.roundsPerSet then
            progression.wave = progression.wave + 1
            script.wake(firefightManager.startRound)
            --script.thread(announcer.roundStart)
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
    local waveTemplate = "Wave %s, Round %s, Set %s."
    local actualWave = waveTemplate:format(progression.wave, progression.round, progression.set)
    logger:debug(actualWave) -- This will be eventually replaced by a proper UI message.
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
    script.thread(announcer.waveStart)()
    script.wake(firefightManager.waveCycle)
    hsc.garbage_collect_now()
end

-------------------------------------------------------
-- Wave Cycle
-------------------------------------------------------

local squadAsigned = 1
local squadLeft = 1
local livingCount = 0
local bossWave = false

---Tiempo de espera entre oleadas.
---Esta función se encarga de manejar el tiempo de espera entre oleadas.
---NO AGREGAR FUNCIONES NI CONDICIONES AQUÍ.
function firefightManager.delay()
    if cooldown == true and counter > 0 then
        counter = counter - 1
    elseif cooldown == true and counter <= 0 then
        waveIsOn = true
        squadLeft = squadAsigned
        cooldown = false
        counter = 0
    end
end

---Esta funcion maneja el ciclo de oleadas de Firefight.
---Cuando se activa, verifica si hay oleadas activas y si hay tropas asignadas para desplegar, 
---de lo contrario, verifica si todas las tropas han sido eliminadas y procede a la siguiente 
---oleada.
function firefightManager.waveCycle()
    if waveIsOn == true then
        if squadLeft > 0 then
            logger:debug("|Deploy Enemy|")
            firefightManager.bypassDeployer() ---Función que se encarga de desplegar las tropas enemigas.
        elseif livingCount <= 0 then
            if progression.wave > 0 and progression.wave < 5 then
                logger:debug("----- Reinforcements -----")
                script.thread(announcer.reinforcements)()
                --hsc.garbage_collect_now()
            end
            waveIsOn = false
            cooldown = true
            counter = time
            firefightManager.progression()
        end
    else
        firefightManager.delay()
    end
end

---Agregar deploy de tropas aquí.
function firefightManager.bypassDeployer()
    script.wake(unitDeployer.enemySpawner) ---Función importada desde unitDeployer.lua
    squadLeft = squadLeft - 1
    --hsc.garbage_collect_now()
end

---Funciones que se ejecutan cada tick del juego.
function firefightManager.eachTick()
    if firefightIsOn == true then
        firefightManager.aiCheck()
        firefightManager.aiNavpoint()
        firefightManager.waveCycle()
    end
end

-------------------------------------------------------
-- Special Events
-------------------------------------------------------
local round = progression.round
local set = progression.set

---- SWITCH ENEMY TEAMS ----
function firefightManager.switchTeams()
    local switchFreq = settings.teamSwitchFrequency
    if (switchFreq == 0) or (switchFreq == 1 and round == 1) or (switchFreq == 2 and set == 1) then
        local randomTeam = math.random(1, 2)
        if randomTeam == 1 then
            progression.currentEnemyTeam = 1 -- "Covenant_Wave"
            logger:debug("Switching to Covenant Team")
        else
            progression.currentEnemyTeam = 2 -- "Flood_Wave"
            logger:debug("Switching to Flood Team")
        end
    else
        logger:debug("No criteria was met for switchTeam")
        return
    end
end

---- GAIN A LIFE & SPAWN WARTHOGS AND GHOSTS ----
function firefightManager.gameAssistances()
    local assistFreq = settings.gameAssistancesFrequency
    if (assistFreq == 0) or (assistFreq == 1 and round == 1) or (assistFreq == 2 and set == 1) then
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
    if (alliesFreq == 0) or (alliesFreq == 1 and round == 1) or (alliesFreq == 2 and set == 1) then
        sleep(700)
        hsc.ai_place("Human_Team/ODSTs")
        hsc.ai_place("human_support/pelican_pilot")
        hsc.object_create_anew("foehammer_cliff")
        hsc.vehicle_load_magic("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs"))
        hsc.vehicle_load_magic("foehammer_cliff", "driver", hsc.ai_actors("human_support/pelican_pilot"))
        hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
        --sleep(30)
        hsc.unit_set_enterable_by_player("foehammer_cliff", false)
        hsc.unit_close("foehammer_cliff")
        hsc.object_teleport("foehammer_cliff", "foehammer_cliff_flag")
        hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), true)
        hsc.recording_play_and_hover( "foehammer_cliff", "foehammer_cliff_in")
        sleep(1200)
        hsc.unit_open("foehammer_cliff")
        sleep(90)
        hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), false)
        hsc.vehicle_unload("foehammer_cliff", "rider")
        sleep(120)
        if not hsc.vehicle_test_seat_list("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs")) then
            hsc.unit_close("foehammer_cliff")
            sleep(120)
            hsc.vehicle_hover("foehammer_cliff", false)
            hsc.recording_play_and_delete("foehammer_cliff", "foehammer_cliff_out")
        end
    else
        logger:debug("No criteria was met for alliesDeployer")
        return
    end
end

function firefightManager.temporalSkull()
    local temporalFreq = settings.temporalSkullsFrequency
    if (temporalFreq == 0) or (temporalFreq == 1 and round == 1) or (temporalFreq == 2 and set == 1) then
        skullsManager.enableSkull("silver", "random")
    else
        logger:debug("No criteria was met for temporalSkull")
        return
    end
end

function firefightManager.permanentSkull()
    local permanentFreq = settings.permanentSkullsFrequency
    if (permanentFreq == 0) or (permanentFreq == 1 and round == 1) or (permanentFreq == 2 and set == 1) then
        skullsManager.enableSkull("golden", "random")
    else
        logger:debug("No criteria was met for permanentSkull")
        return
    end
end

function firefightManager.resetSkulls()
    local resetFreq = settings.resetSkullsFrequency
    if (resetFreq == 0) or (resetFreq == 1 and round == 1) or (resetFreq == 2 and set == 1) then
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

---Funciones de utilidad para el sistema de Firefight. 
---Estas funciones se encargan de limpiar y detener el Firefight.

---Clean function for Firefight
---This function is called to reset the firefight system, clearing all AI and resetting all the states.
---It's coming handy when you execute |balltze_reload_plugins|
function firefightManager.cleanup()
    firefightIsOn = false
    waveIsOn = false
    cooldown = false
    hsc.ai_erase_all()
    hsc.object_destroy_containing("dropship")
    hsc.garbage_collect_now()
    skullsManager.enableSkull("silver", "all")
    skullsManager.enableSkull("golden", "all")
    skullsManager.disableSkull("silver", "is_active")
    skullsManager.disableSkull("golden", "is_active")
    logger:debug("Firefight cleanup completed")
end

---Stop the Firefight
function firefightManager.stop()
    firefightIsOn = false
    waveIsOn = false
    -- logger:debug("Firefight is on '{}'", firefightIsOn)
    -- logger:debug("Wave is on '{}'", waveIsOn)
    progression.set = 0
    progression.round = 0
    progression.wave = 0
    -- logger:debug("Set, Round and Wave reset to '0'")
    hsc.ai_erase_all()
    hsc.garbage_collect_now()
    execute_script("sv_end_game")
end

function firefightManager.aiNavpoint()
    local navpointType = "default_red"
    local navpointOffset = 0.6
    if waveIsOn == true or bossWave == true then
        if livingCount <= 2 then
            local playerCount = hsc.list_count(hsc.players())
            for i = 0, playerCount - 1 do
                local playerUnit = hsc.unit(hsc.list_get(hsc.players(), i))
                for actorIndex = 0, 3 do
                    local actorUnit = hsc.unit(hsc.list_get(hsc.ai_actors("Covenant_Wave"), actorIndex))
                    hsc.activate_nav_point_object(navpointType, playerUnit, actorUnit, navpointOffset)
                end
            end
        end
    end
end

local magicalSightCounter = 300
local magicalSightTimer = 0
function firefightManager.aiCheck()
    livingCount = hsc.ai_living_count("Covenant_Wave")
    hsc.ai_follow_target_players("Covenant_Support")
    hsc.ai_follow_target_players("Covenant_Wave")
    hsc.ai_magically_see_players("Human_Team") -- Allys are the only ones who see all players all the time.
    hsc.ai_magically_see_encounter("Human_Team", "Covenant_Wave")
    hsc.ai_magically_see_encounter("Human_Team", "Covenant_Support")
    hsc.ai_magically_see_encounter("Covenant_Wave", "Human_Team")
    hsc.ai_magically_see_encounter("Covenant_Support", "Human_Team")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        firefightManager.aiSight()
    end
end

-- Each 10 seconds, enemy AI will try to magically see each player if they exist & aren't invisible.
function firefightManager.aiSight()
    local playerCount = hsc.list_count(hsc.players())
    for i = 0, playerCount - 1 do
        local playerUnit = hsc.unit(hsc.list_get(hsc.players(), i))
        assert(playerUnit)
        if playerUnit.isCamoActive == false then
            hsc.ai_magically_see_unit("Covenant_Wave", playerUnit)
            hsc.ai_magically_see_unit("Covenant_Support", playerUnit)
            hsc.ai_magically_see_unit("Flood_Wave", playerUnit)
            hsc.ai_magically_see_unit("Flood_Support", playerUnit)
            hsc.ai_magically_see_unit("Covenant_Banshees", playerUnit)
            hsc.ai_magically_see_unit("Covenant_Snipers", playerUnit)
            hsc.ai_magically_see_unit("Sentinel_Team", playerUnit)
        end
    end
end


return firefightManager
