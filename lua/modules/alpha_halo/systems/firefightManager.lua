local engine = Engine
local balltze = Balltze
-- local blam = require "blam"
local pigPen = require "alpha_halo.systems.core.pigPen"
local healthManager = require "alpha_halo.systems.combat.healthManager"
local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local announcer = require "alpha_halo.systems.combat.announcer"
local script = require "script"
local hsc = require "hsc"


local firefightManager = {}

-- VARIABLES DE LA FUNCIÓN firefightManager.whenMapLoads
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.eachTick
local waveIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveProgression
local currentWave = 0
local currentRound = 0
local currentSet = 0
local waveTemplate = "Wave %s, Round %s, Set %s."
local actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
local bossWave = false
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveCooldown
local waveCooldownTimer = 300
local roundCooldownTimer = 330
local waveCooldownStart = false
local waveCooldownCounter = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipDeployer relacionadas al Squad.
local randomTeamIndex
local currentTier = 1
local randomSquad = math.random(1, 6)
local currentWaveType
local currentSupportType
local squadTemplate = "Enemy_Team_%s/Tier_%s_Squad_%s"
local selectedSquad = squadTemplate:format(randomTeamIndex, currentTier, randomSquad)
local bossSquadTemplate = "Enemy_Team_%s/Boss_Wave"
local selectedBossSquad = bossSquadTemplate:format(randomTeamIndex)
local startingSquadTemplate = "Enemy_Team_%s/Starting_Wave"
local selectedStartingSquad = startingSquadTemplate:format(randomTeamIndex)
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipDeployer relacionadas al Vehicle.
local dropshipsAsigned = 3 -- set to 3
local dropshipsLeft = 0 -- set to 1 or 0
local randomDropship = 1
local dropshipTemplate = "dropship_%s_%s"
local dropshipFlagTemplate = "dropship_%s_%s_flag"
local selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipCountdown
local dropshipCountdownTimer = 720
local dropshipCountdownStart = false
local dropshipCountdownCounter = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.AiCheck
local waveLivingCount = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.SentinelChance
local sentinelCooldown = 0
local sentinelChance = 0
local sentinelRandomMath = 0
local randomSentinelSquad = math.random(1, 6)
local sentinelSquadTemplate = "Sentinel_Team/Sentinels_%s"
local selectedSentinelSquad = sentinelSquadTemplate:format(randomSentinelSquad)
-- VARIALBES DE LA FUNCIÓN firefightManager.GhostLoader()
local randomGhost = 0
local ghostTemplate = "ghost_var%s_drop%s"
local selectedGhost = ghostTemplate:format(randomGhost, dropshipsLeft)
local selectedGhostA = ghostTemplate:format(randomGhost, 1)
local selectedGhostB = ghostTemplate:format(randomGhost, 2)
local selectedGhostC = ghostTemplate:format(randomGhost, 3)
local ghostPilotTemplate = "Enemy_Team_%s/Ghost_Pilot"
local selectedGhostPilot = ghostPilotTemplate:format(randomTeamIndex)
-- VARIABLES DE LA FUNCIÓN firefightManager.GameAssists()
local randomWarthog = math.random(1, 3)
local warthogTemplate = "warthog_%s"
local selectedWarthog = warthogTemplate:format(randomWarthog)
local ghostAssistTemplate = "reward_ghost_var%s"
local selectedAssistGhost = ghostAssistTemplate:format(randomGhost)
-- VARIABLES DE LA FUNCIÓN firefightManager.GetOutOfGhost()
local bossWaveCooldown = false
local getOutOfGhost = false

local function getRandomTeamWave()
    local randomTeam = math.random(1, 1) -- This should be (1, 2)
    local team
    if randomTeam == 1 then
        team = "Covenant_Wave"
        randomTeamIndex = 1
        currentSupportType = "Covenant_Support"
    elseif randomTeam == 2 then
        team = "Flood_Wave"
        randomTeamIndex = 2
        currentSupportType = "Flood_Support"
    end
    return team
end

-- Make current enemies to be Covenant.
function firefightManager.debugCovenantTeam()
    randomTeamIndex = 1
    currentWaveType = "Covenant_Wave"
    currentSupportType = "Covenant_Support"
end

-- Make current enemies to be Flood.
function firefightManager.debugFloodTeam()
    randomTeamIndex = 1
    currentWaveType = "Covenant_Wave"
    currentSupportType = "Covenant_Support"
end

-- Esta función ocurre al iniciar el mapa. Causa cambios a la función onTick.
-- APARENTEMENTE ESTO ESTÁ FUNCIONANDO, PESE A QUE EL ONMAPLOAD YA NO FUNCIONA.
function firefightManager.whenMapLoads()
    logger:debug("Welcome to Alpha Firefight.")
    gameIsOn = true
    currentRound = 1
    currentSet = 1
    firefightManager.gameAssists()
    currentWaveType = getRandomTeamWave()
    firefightManager.waveProgression()
    waveCooldownStart = true
    waveCooldownCounter = roundCooldownTimer
    -- hsc.object_create_anew("mortar_1")
    -- hsc.object_create_anew("mortar_2")
end


-- Esta función ocurre cada tick. Ejecuta al resto de funciones cuando se dan las condiciones.
function firefightManager.eachTick()
    if gameIsOn == true then
        -- Actualizamos constantemente el estado de la IA.
        firefightManager.aiCheck()
        -- firefightManager.killStagnateAi()
        -- Revisamos constantemente el countdown de las Dropships.
        firefightManager.dropshipCountdown()
        -- Revisamos constantemente si puedes o no subir al Ghost.
        firefightManager.getOutOfGhost()
        -- Revisamos constantemente si puedes o no marcar a los enemigos resagados.
        firefightManager.aiNavpoint()
        -- Si waveIsOn = true, se inician los procesos de la oleaada. Si no, se inicia el cooldown.
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                firefightManager.dropshipDeployer()
            elseif bossWave == false and waveLivingCount <= 4 then
                if currentWave > 0 then
                    logger:debug("Reinforcements!")
                    script.thread(announcer.reinforcements)()
                end
                waveIsOn = false
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                firefightManager.waveProgression()
            elseif bossWave == true and waveLivingCount <= 0 then
                logger:debug("Round Complete!")
                script.thread(announcer.roundCompleted)()
                skullsManager.disableSkull("silver", "is_spent")
                script.thread(announcer.skullsResetDelay)()
                waveIsOn = false
                bossWaveCooldown = true
                getOutOfGhost = true
                waveCooldownStart = true
                waveCooldownCounter = roundCooldownTimer
                firefightManager.waveProgression()
            end
        else
            firefightManager.waveCooldown()
        end
    end
end

-- Esta función se llama cuando pasas de oleada. Progresa el juego y realiza cambios en base a esto.
function firefightManager.waveProgression()
    -- Si la Wave es menor que 5, avanaz una. Si es 5, se reinicia y Round avanza una.
    if (currentWave < 5) then
        currentWave = currentWave + 1
        if currentSet >= 4 then
            currentWaveType = getRandomTeamWave()
        end
    elseif currentWave == 5 then
        currentWave = 1
        -- Si la ronda acaba de comenzar, spawneamos las asistencias y randomizamos el team.
        firefightManager.gameAssists()
        currentWaveType = getRandomTeamWave()
        -- Si el Tier es menor que 3, avanza uno.
        if currentTier < 3 then
            currentTier = currentTier + 1
        end
        -- Si la Round es menor que 3, avanaz una. Si es 3, se reinicia y Set avanza una.
        if (currentRound < 3) then
            currentRound = currentRound + 1
        elseif currentRound == 3 then
            currentRound = 1
            currentSet = currentSet + 1
        end
    end
    -- Si la ronda es 5, entonces es una Boss Wave.
    if currentWave == 5 then
        bossWave = true
        randomGhost = math.random(1, 3)
    else
        bossWave = false
    end
    -- Recibimos el nombre actual de nuestra oleada.
    actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
    -- Aquí llamamos la función de los Sentinelas.
    firefightManager.sentinelChance()
end

-- Esta función se llama cuando waveIsOn = false. Maneja el cooldown de las waves a la espera de iniciar otra.
function firefightManager.waveCooldown()
    if waveCooldownStart == true and waveCooldownCounter > 0 then
        waveCooldownCounter = waveCooldownCounter - 1
    elseif waveCooldownStart == true and waveCooldownCounter <= 0 then
        logger:debug(actualWave)
        waveIsOn = true
        bossWaveCooldown = false
        dropshipsLeft = dropshipsAsigned
        waveCooldownStart = false
        waveCooldownCounter = 0
        if currentWave == 1 and currentRound == 1 and currentSet >= 1 then
            script.thread(announcer.setStart)()
            hsc.object_create_anew("cyborg")
        elseif currentWave == 1 and currentRound > 1 then
            script.thread(announcer.roundStart)()
        end
        -- Si recién iniciamos una ronda, encendemos una calavera plateada y una dorada
        if currentWave == 1 then
            skullsManager.enableSkull("golden", "random")
            skullsManager.enableSkull("golden", "restore")
        elseif currentWave > 1 then
            skullsManager.enableSkull("silver", "random")
        end
        script.thread(announcer.skullOnDelay)()
        hsc.ai_erase(currentSupportType)
        if currentWave == 5 then
            script.startup(firefightManager.pelicanDeployer)
            logger:debug("Here comes the help!")
        end
    end
end

---@deprecated
function firefightManager.dropshipFlags()
    --hsc.object_create_anew(selectedDropship)
    local dropshipFlag = dropshipFlagTemplate:format(dropshipsLeft, randomDropship)
    hsc.object_teleport(selectedDropship, dropshipFlag)
    logger:debug("Dropship '{}' teleported to '{}' : ", selectedDropship, dropshipFlag)
end

-- Esta función es llamada una vez por cada dropship asignada a una oleada. Se encarga de cargar y enviar las dropships.
function firefightManager.dropshipDeployer()
    -- Randomizamos la dropship cada que esta función es llamada.
    --firefightManager.dropshipFlags()
    randomDropship = math.random(1)
    selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
    local dropshipGunnerFormat = "Enemy_Team_%s/Spirit_Gunner"
    local selectedDropshipGunner = dropshipGunnerFormat:format(randomTeamIndex)
    hsc.ai_place(selectedDropshipGunner)
    hsc.vehicle_load_magic(selectedDropship, "gunseat", hsc.ai_actors(selectedDropshipGunner))
    hsc.ai_migrate(selectedDropshipGunner, currentSupportType)
    -- Randomizamos el squad cada que esta función es llamada.
    -- La Dropship 1 será identica a la Dropship 2.
    -- Si es una Boss Wave, la Dropship 1 carga el Boss Squad y los Ghost.
    if dropshipsLeft > 1 then
        randomSquad = math.random(1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeamIndex, currentTier, randomSquad)
    if currentWave == 1 then
        selectedStartingSquad = startingSquadTemplate:format(randomTeamIndex)
        selectedSquad = selectedStartingSquad
    end
    if bossWave == true then
        firefightManager.ghostLoader()
        if dropshipsLeft == 1 then
            selectedBossSquad = bossSquadTemplate:format(randomTeamIndex)
            selectedSquad = selectedBossSquad
        end
    end
    hsc.ai_place(selectedSquad)
    -- Cargamos a los squads en sus respectivas dropships y los migramos a sus encounters.
    hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors(selectedSquad))
    hsc.custom_animation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, false)
    -- Dependiendo del team, lo migramos a su respectivo encounter.
    hsc.ai_migrate(selectedSquad, currentWaveType)
    -- Iniciamos los contadores y vamos extinguiendo el script.
    dropshipsLeft = dropshipsLeft - 1
    dropshipCountdownStart = true
    dropshipCountdownCounter = dropshipCountdownTimer
end


function firefightManager.pelicanDeployer(call, sleep)
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
end


-- Esto carga al Ghost en la Spirit.
function firefightManager.ghostLoader()
    selectedGhost = ghostTemplate:format(randomGhost, dropshipsLeft)
    selectedGhostA = ghostTemplate:format(randomGhost, 1)
    selectedGhostB = ghostTemplate:format(randomGhost, 2)
    selectedGhostC = ghostTemplate:format(randomGhost, 3)
    selectedGhostPilot = ghostPilotTemplate:format(randomTeamIndex)
    hsc.object_create_anew(selectedGhost)
    firefightManager.setGhostEntrable()
    ---- Ghost is now spawned dynamically
    -- local ghostObjectHandle = pigPen.compactSpawnNamedVehicle(selectedGhost)
    ---- All of the following hscLegacy commands must be replaced by Balltze alternatives, anywhere where the hsc.objectCreate calls were replaced by pigPen module calls
    -- if ghostObjectHandle then
    --    local ghostObject = engine.gameState.getObject(ghostObjectHandle, engine.tag.objectType.vehicle)
    --    -- We need to get the ghost driver unit (biped) object handle somehow to use it here. And look up the seat index from Guerilla:
    --    -- engine.gameState.unitEnterVehicle(, ghostObjectHandle, )
    --
    -- end
    -- Esto POSIBLEMENTE de segmentation. Se necesitan más pruebas. No funciona con el Flood.
    hsc.ai_place(selectedGhostPilot)
    hsc.vehicle_load_magic(selectedGhost, "driver", "(ai_actors " .. selectedGhostPilot .. ")")
    hsc.ai_migrate(selectedGhostPilot, currentSupportType)
    hsc.unit_enter_vehicle(selectedGhost, selectedDropship, "cargo_ghost02")
end

-- Esta función es llamada por tick cuando sus condiciones son activadas por el DropshipDeployer.
function firefightManager.dropshipCountdown()
    if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
        dropshipCountdownCounter = dropshipCountdownCounter - 1
    elseif dropshipCountdownStart == true and dropshipCountdownCounter <= 0 then
        hsc.ai_exit_vehicle(currentWaveType)
        hsc.unit_exit_vehicle(selectedGhostA)
        hsc.unit_exit_vehicle(selectedGhostC)
        hsc.unit_exit_vehicle(selectedGhostB)
        dropshipCountdownStart = false
        dropshipCountdownCounter = 0
    end
end

-- Esto spawnea a los Centinelas.
function firefightManager.sentinelChance()
    -- Aquí progresamos el Cooldown y el Chance de los Sentinels.
    if sentinelCooldown < 5 then
        sentinelCooldown = sentinelCooldown + 1
    elseif sentinelChance < 5 then
        sentinelChance = sentinelChance + 1
    end
    -- Aquí randomizamos el si tendremos Sentinelas o no.
    if sentinelCooldown == 5 then
        if sentinelChance == 1 then
            sentinelRandomMath = math.random(1, 5)
        elseif sentinelChance == 2 then
            sentinelRandomMath = math.random(1, 4)
        elseif sentinelChance == 3 then
            sentinelRandomMath = math.random(1, 3)
        elseif sentinelChance == 4 then
            sentinelRandomMath = math.random(1, 2)
        elseif sentinelChance == 5 then
            sentinelRandomMath = math.random(1)
        end
    end
    -- Aquí spawneamos el squad random de Sentinelas y reiniciamos todo.
    if sentinelRandomMath == 1 then
        logger:debug("Here come Sentinels!")
        script.thread(announcer.enemyIncoming)()
        randomSentinelSquad = math.random(1, 6)
        selectedSentinelSquad = sentinelSquadTemplate:format(randomSentinelSquad)
        hsc.ai_place(selectedSentinelSquad)
        sentinelCooldown = 0
        sentinelChance = 0
        sentinelRandomMath = 0
    end
end

-- Esto spawnea las ayudas para el jugador.
function firefightManager.gameAssists()
    -- Te damos una vida y spawneamos a los aliados & ayudas.
    script.thread(healthManager.livesGained)()
    --hsc.ai_place("Human_Team/ODSTs")
    -- Le otorgamos los Warthos estandar al jugador.
    -- TODO: create a replacement function to spawn assist_warthog dynamically
    -- Spawneamos el Ghost de recompenza.
    randomGhost = math.random(1, 3)
    selectedAssistGhost = ghostAssistTemplate:format(randomGhost)
    -- hsc.object_create_anew(selectedAssistGhost)
    -- Ghost is now spawned dynamically
    pigPen.compactSpawnNamedVehicle(selectedAssistGhost)
    hsc.ai_vehicle_enterable_distance(selectedAssistGhost, 20.0)
    -- hsc.object_teleporteleport(selectedAssistGhost, "Selected_Ghost")
    -- Aca hacemos el mambo para spawnear el SuperHog en turno.
    randomWarthog = math.random(1, 3)
    selectedWarthog = warthogTemplate:format(randomWarthog)
    -- hsc.object_create_anew(selectedWarthog)
    -- Warthog is now spawned dynamically
    pigPen.compactSpawnNamedVehicle(selectedWarthog)
    hsc.ai_vehicle_enterable_distance(selectedWarthog, 20.0)
    -- hsc.object_teleporteleport(selectedWarthog, "Selected_Warthog")
end

-- Esto parcha horriblemente el problema del Ghost en el Spirit.
function firefightManager.getOutOfGhost()
    if getOutOfGhost == true then
        if bossWaveCooldown == true then
            hsc.vehicle_unload(selectedGhostA, "driver")
            hsc.vehicle_unload(selectedGhostB, "driver")
            hsc.vehicle_unload(selectedGhostC, "driver")
            hsc.unit_set_enterable_by_player(selectedGhostA, false)
            hsc.unit_set_enterable_by_player(selectedGhostB, false)
            hsc.unit_set_enterable_by_player(selectedGhostC, false)
            hsc.ai_vehicle_enterable_distance(selectedGhostA, 0)
            hsc.ai_vehicle_enterable_distance(selectedGhostB, 0)
            hsc.ai_vehicle_enterable_distance(selectedGhostC, 0)
        elseif bossWaveCooldown == false then
            firefightManager.setGhostEntrable()
            getOutOfGhost = false
        end
    end
end

function firefightManager.setGhostEntrable()
    hsc.unit_set_enterable_by_player(selectedGhostA, true)
    hsc.unit_set_enterable_by_player(selectedGhostB, true)
    hsc.unit_set_enterable_by_player(selectedGhostC, true)
    hsc.ai_vehicle_enterable_distance(selectedGhostA, 20.0)
    hsc.ai_vehicle_enterable_distance(selectedGhostB, 20.0)
    hsc.ai_vehicle_enterable_distance(selectedGhostC, 20.0)
end

-- Esto genera un navpoint en las unidades resagadas.
function firefightManager.aiNavpoint()
    local navpointType = "default_red"
    local navpointOffset = 0.6
    if waveIsOn == false or bossWave == true then
        if waveLivingCount <= 4 then
            local playerCount = hsc.list_count(hsc.players())
            for i = 0, playerCount - 1 do
                local playerUnit = hsc.unit(hsc.list_get(hsc.players(), i))
                for actorIndex = 0, 3 do
                    local actorUnit = hsc.unit(hsc.list_get(hsc.ai_actors(currentWaveType), actorIndex))
                    hsc.activate_nav_point_object(navpointType, playerUnit, actorUnit, navpointOffset)
                end
            end
        end
    end
end


-- function firefightManager.killStagnateAi()
--    --Here goes super code to kill AI bellow certain z cord on the map.
-- end

-- Esta función es llamada cada tick si gameIsOn = true. Revisa y gestiona los actores en tiempo real.
local magicalSightCounter = 300
local magicalSightTimer = 0
function firefightManager.aiCheck()
    waveLivingCount = hsc.ai_living_count("Covenant_Wave") + hsc.ai_living_count("Flood_Wave")
    hsc.ai_follow_target_players("Covenant_Support")
    hsc.ai_follow_target_players("Flood_Support")
    hsc.ai_follow_target_players("Covenant_Wave")
    hsc.ai_follow_target_players("Flood_Wave")
    hsc.ai_follow_target_players("Sentinel_Team")
    hsc.ai_follow_target_players("Human_Team")
    hsc.ai_magically_see_players("Human_Team") -- Allys are the only ones who see all players all the time.
    hsc.ai_magically_see_encounter("Human_Team", "Covenant_Wave")
    hsc.ai_magically_see_encounter("Human_Team", "Covenant_Support")
    hsc.ai_magically_see_encounter("Human_Team", "Flood_Wave")
    hsc.ai_magically_see_encounter("Human_Team", "Flood_Support")
    hsc.ai_magically_see_encounter("Human_Team", "Sentinel_Team")
    hsc.ai_magically_see_encounter("Covenant_Wave", "Human_Team")
    hsc.ai_magically_see_encounter("Covenant_Support", "Human_Team")
    hsc.ai_magically_see_encounter("Flood_Wave", "Human_Team")
    hsc.ai_magically_see_encounter("Flood_Support", "Human_Team")
    hsc.ai_magically_see_encounter("Sentinel_Team", "Human_Team")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        firefightManager.aiSight()
    end
end

-- Each 10 seconds, enemy AI will try to magically see each player if they exist & aren't invisible.
function firefightManager.aiSight()
    hsc.ai_magically_see_players("Covenant_Wave")
    hsc.ai_magically_see_players("Covenant_Support")
    hsc.ai_magically_see_players("Flood_Wave")
    hsc.ai_magically_see_players("Flood_Support")
    hsc.ai_magically_see_players("Covenant_Banshees")
    hsc.ai_magically_see_players("Covenant_Snipers")
    hsc.ai_magically_see_players("Sentinel_Team")
    ----This bellow is not working, but it should be used to magically see players.
    ----In theory, this should iterate the conditions for each player and units magically seeing them.
    --local playerCount = hsc.list_count(hsc.players())
    --for i = 0, playerCount - 1 do
    --    local playerUnit = hsc.unit(hsc.list_get(hsc.players(), i))
    --    assert(playerUnit)
    --    if playerUnit.isCamoActive == false then
    --        hsc.ai_magically_see_unit("Covenant_Wave", playerUnit)
    --        hsc.ai_magically_see_unit("Covenant_Support", playerUnit)
    --        hsc.ai_magically_see_unit("Flood_Wave", playerUnit)
    --        hsc.ai_magically_see_unit("Flood_Support", playerUnit)
    --        hsc.ai_magically_see_unit("Covenant_Banshees", playerUnit)
    --        hsc.ai_magically_see_unit("Covenant_Snipers", playerUnit)
    --        hsc.ai_magically_see_unit("Sentinel_Team", playerUnit)
    --    end
    --end
end

return firefightManager
