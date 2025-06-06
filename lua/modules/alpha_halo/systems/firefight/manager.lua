-- 📁 modules/project_modules/systems/firefight/manager.lua
local balltze = Balltze
local engine = Engine
local eventsManager = require "alpha_halo.systems.firefight.events"
local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local announcer = require "alpha_halo.systems.combat.announcer"
local script = require "script"
local hsc = require "hsc"

local manager = {}

-------------------------------------------------------
-- Firefight Config
-------------------------------------------------------

local firefightIsOn = false
local waveIsOn = false
local cooldown = false
local counter = 0
local time = 150

---This table holds the initial configuration for the firefight system, 
---and could be edited with Insurrection in the future.
manager.firefight = { --------------
    set = 0,
    round = 0,
    wave = 0,
    maxSet = 3,
    maxWave = 5,
    maxRound = 3,
    ---@deprecated
    randomSkull = false,
}

local firefight = manager.firefight

---Firefight Start Welcome
function manager.whenMapLoads(call, sleep)
    logger:debug("Welcome to Alpha Firefight")
    logger:debug("firefight is On '{}'", firefightIsOn)
    manager.cleanup()
    logger:debug("Waiting 150 ticks before starting Firefight")
    sleep(150)
    script.startup(manager.start)
end

---Start the Firefight
---This function is called when the firefight is initiated, setting the initial conditions and starting the first set.
function manager.start(call, sleep)
    if firefightIsOn then
        return
    end
    firefightIsOn = true
    logger:debug("Firefight is On '{}'", firefightIsOn)
    logger:debug("Waiing 90 ticks")
    sleep(90)
    script.wake(manager.startSet)
end

---Start a Set of Firefight
function manager.startSet(call, sleep)
    cooldown = false
    logger:debug("Cooldown is Active '{}'", cooldown)
    if firefight.set < 1 then
        firefight.set = 1
    else
        firefight.set = firefight.set
    end
    if firefight.set > firefight.maxSet then
        logger:debug("Firefight Completed, Thanks for playing!")
        manager.stop()
        return
    end
    -- eventsManager.triggerSetEvent(firefight.set)
    ---Aquí podemos agregar eventos de inicio de set, como las asistencias, entrega de armas, 
    ---calaveras etc.
    logger:debug("-------------- Set '{}' started", firefight.set)
    script.thread(announcer.setStart)()
    logger:debug("Waiting 90 ticks")
    sleep(90)
    script.wake(manager.startRound)
end

---Start a Round of Firefight
function manager.startRound(call, sleep)
    firefight.round = 1
    logger:debug("-------------- Round '{}' started", firefight.round)
    -- eventsManager.triggerRoundEvent(firefight.round)
    ---Aquí podemos agregar eventos en los rounds, como las asistencias, entrega de armas, 
    ---calaveras etc.
    logger:debug("Waiting 90 ticks")
    sleep(90)
    script.wake(manager.startWave)
end

---Start a Wave of Firefight
function manager.startWave(call, sleep)
    firefight.wave = 0
    manager.progression()
    ---Aquí podemos agregar eventos en OLEADA INICIAL, como las asistencias, entrega de armas, 
    ---calaveras etc.
    skullsManager.enableSkull("silver", "random")
    script.wake(announcer.skullOn)
    cooldown = true
    counter = time ---Función que salta la progresión de oleadas, rondas y sets.
end

---Progresion del tiroteo a través de oleadas, rondas y sets.
---Esta función se llama cuando se completa una oleada y verifica si se debe iniciar la siguiente 
---oleada, ronda o set.
function manager.progression()
    if firefight.wave < 5 then
        firefight.wave = firefight.wave + 1
        logger:debug("Wave '{}' started", firefight.wave)
    elseif firefight.wave == 5 and firefight.set < 4 then
        -- firefight.wave = 0
        script.wake(manager.startWave)
        if firefight.round < 3 then
            firefight.round = firefight.round + 1
            logger:debug("-------------- Set '{}' Round '{}' started", firefight.set, firefight.round)
            script.thread(announcer.roundStart)()
        elseif firefight.round == 3 then
            firefight.set = firefight.set + 1
            script.wake(manager.startSet)
        end
    end
    --- Aquí podemos agregar eventos en alguna oleada en específico ,siguiendo este ejemplo:
    if firefight.wave == 5 then
        firefight.wave = firefight.wave
        logger:debug("Inserte función aquí")
        --script.wake(unitDeployer.pelicanDeployer)
    end
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
function manager.delay()
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
function manager.waveCycle()
    if waveIsOn == true then
        if squadLeft > 0 then
            logger:debug("|Deploy Enemy|")
            manager.bypassDeployer() ---Función que se encarga de desplegar las tropas enemigas.
        elseif livingCount <= 0 then
            if firefight.wave > 0 and firefight.wave < 5 then
                logger:debug("----- Reinforcements -----")
                script.thread(announcer.reinforcements)()
                hsc.garbage_collect_now()
            end
            waveIsOn = false
            cooldown = true
            counter = time
            manager.progression()
        end
    else
        manager.delay()
    end
end

---Agregar deploy de tropas aquí.
function manager.bypassDeployer()
    script.wake(unitDeployer.enemySpawner) ---Función importada desde unitDeployer.lua
    squadLeft = squadLeft - 1
    --hsc.garbage_collect_now()
end

---Funciones que se ejecutan cada tick del juego.
function manager.eachTick()
    if firefightIsOn == true then
        manager.aiCheck()
        manager.aiNavpoint()
        manager.waveCycle()
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
function manager.cleanup()
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
function manager.stop()
    firefightIsOn = false
    waveIsOn = false
    -- logger:debug("Firefight is on '{}'", firefightIsOn)
    -- logger:debug("Wave is on '{}'", waveIsOn)
    firefight.set = 0
    firefight.round = 0
    firefight.wave = 0
    -- logger:debug("Set, Round and Wave reset to '0'")
    hsc.ai_erase_all()
    hsc.garbage_collect_now()
    execute_script("sv_end_game")
end

function manager.aiNavpoint()
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
function manager.aiCheck()
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
        manager.aiSight()
    end
end

-- Each 10 seconds, enemy AI will try to magically see each player if they exist & aren't invisible.
function manager.aiSight()
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


return manager
