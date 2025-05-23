local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block
local const = require "alpha_halo.constants"
local pigPen = require "alpha_halo.pigPen"
local healthManager = require "alpha_halo.gameplay_core.healthManager"
local skullsManager = require "alpha_halo.gameplay_core.skullsManager"

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
local dropshipsAsigned = 3
local dropshipsLeft = 0
local randomDropship = 1
local dropshipTemplate = "dropship_%s_%s"
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
local playSound = engine.userInterface.playSound

local function getRandomTeamWave()
    local randomTeam = math.random(1) -- This should be (1, 2)
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
    firefightManager.GameAssists()
    currentWaveType = getRandomTeamWave()
    firefightManager.WaveProgression()
    waveCooldownStart = true
    waveCooldownCounter = roundCooldownTimer
    --hsc.objectCreateANew("mortar_1")
    --hsc.objectCreateANew("mortar_2")
end

-- Esta función ocurre cada tick. Ejecuta al resto de funciones cuando se dan las condiciones.
function firefightManager.eachTick()
    if gameIsOn == true then
        -- Actualizamos constantemente el estado de la IA.
        firefightManager.AiCheck()
        firefightManager.killStagnateAi()
        -- Revisamos constantemente el countdown de las Dropships.
        firefightManager.DropshipCountdown()
        -- Revisamos constantemente si puedes o no subir al Ghost.
        firefightManager.GetOutOfGhost()
        -- Revisamos constantemente si puedes o no marcar a los enemigos resagados.
        firefightManager.aiNavpoint()
        -- Si waveIsOn = true, se inician los procesos de la oleaada. Si no, se inicia el cooldown.
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                firefightManager.DropshipDeployer()
            elseif bossWave == false and waveLivingCount <= 4 then
                if currentWave > 0 then
                    logger:debug("Reinforcements!")
                    playSound(const.sounds.reinforcements.handle)
                end
                waveIsOn = false
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                firefightManager.WaveProgression()
            elseif bossWave == true and waveLivingCount <= 0 then
                logger:debug("Round Complete!")
                --playSound(const.sounds.roundComplete.handle)
                waveIsOn = false
                bossWaveCooldown = true
                waveCooldownStart = true
                waveCooldownCounter = roundCooldownTimer
                firefightManager.WaveProgression()
            end
        else
            firefightManager.WaveCooldown()
        end
    end
end

-- Esta función se llama cuando pasas de oleada. Progresa el juego y realiza cambios en base a esto.
function firefightManager.WaveProgression()
    -- Si la Wave es menor que 5, avanaz una. Si es 5, se reinicia y Round avanza una.
    if (currentWave < 5) then
        currentWave = currentWave + 1
        if currentSet >= 4 then
            currentWaveType = getRandomTeamWave()
        end
    elseif currentWave == 5 then
        currentWave = 1
        -- Si la ronda acaba de comenzar, spawneamos las asistencias y randomizamos el team.
        firefightManager.GameAssists()
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
            skullsManager.resetSilverSkulls()
        end
    end
    -- Si la ronda es 5, entonces es una Boss Wave.
    if currentWave == 5 then
        bossWave = true
        randomGhost = math.random (1, 3)
    else
        bossWave = false
    end
    -- Recibimos el nombre actual de nuestra oleada.
    actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
    -- Aquí llamamos la función de los Sentinelas.
    firefightManager.SentinelChance()
end

-- Esta función se llama cuando waveIsOn = false. Maneja el cooldown de las waves a la espera de iniciar otra.
function firefightManager.WaveCooldown()
    if waveCooldownStart == true and waveCooldownCounter > 0 then
        waveCooldownCounter = waveCooldownCounter - 1
    elseif waveCooldownStart == true and waveCooldownCounter <= 0 then
        logger:debug(actualWave)
        waveIsOn = true
        bossWaveCooldown = false
        dropshipsLeft = dropshipsAsigned
        waveCooldownStart = false
        waveCooldownCounter = 0
        if currentWave == 1 and currentRound == 1 then
            playSound(const.sounds.setStart.handle)
        elseif currentWave == 1 and currentRound > 1 then
            playSound(const.sounds.roundStart.handle)
        end
        -- Si recién iniciamos una ronda, encendemos una calavera plateada.
        if currentWave == 1 then
            skullsManager.silverSkulls()
        end
        -- Si recién iniciamos un nuevo set, encendemos una calavera dorada.
        if currentRound == 1 and currentSet > 1 then
            skullsManager.goldenSkulls()
        end
    end
end

-- Esta función es llamada una vez por cada dropship asignada a una oleada. Se encarga de cargar y enviar las dropships.
function firefightManager.DropshipDeployer()
    -- Randomizamos la dropship cada que esta función es llamada.
    randomDropship = math.random (1)
    selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
    hsc.objectCreateANew(selectedDropship)
    local dropshipGunnerFormat = "Enemy_Team_%s/Spirit_Gunner"
    local selectedDropshipGunner = dropshipGunnerFormat:format(randomTeamIndex)
    hsc.aiSpawn(1, selectedDropshipGunner)
    hsc.vehicleLoadMagic(selectedDropship, "gunseat", selectedDropshipGunner)
    hsc.aiMigrate(selectedDropshipGunner, currentSupportType)
    -- Randomizamos el squad cada que esta función es llamada.
    -- La Dropship 1 será identica a la Dropship 2.
    -- Si es una Boss Wave, la Dropship 1 carga el Boss Squad y los Ghost.
    if dropshipsLeft > 1 then
        randomSquad = math.random (1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeamIndex, currentTier, randomSquad)
    if currentWave == 1 then
        selectedStartingSquad = startingSquadTemplate:format(randomTeamIndex)
        selectedSquad = selectedStartingSquad
    end
    if bossWave == true then
        firefightManager.GhostLoader()
        if dropshipsLeft == 1 then
            selectedBossSquad = bossSquadTemplate:format(randomTeamIndex)
            selectedSquad = selectedBossSquad
        end
    end
    hsc.aiSpawn(1, selectedSquad)
    -- Cargamos a los squads en sus respectivas dropships y los migramos a sus encounters.
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, "false")
    -- Dependiendo del team, lo migramos a su respectivo encounter.
    hsc.aiMigrate(selectedSquad, currentWaveType)
    -- Iniciamos los contadores y vamos extinguiendo el script.
    dropshipsLeft = dropshipsLeft - 1
    dropshipCountdownStart = true
    dropshipCountdownCounter = dropshipCountdownTimer
end

-- Esto carga al Ghost en la Spirit.
function firefightManager.GhostLoader()
    selectedGhost = ghostTemplate:format(randomGhost, dropshipsLeft)
    selectedGhostA = ghostTemplate:format(randomGhost, 1)
    selectedGhostB = ghostTemplate:format(randomGhost, 2)
    selectedGhostC = ghostTemplate:format(randomGhost, 3)
    selectedGhostPilot = ghostPilotTemplate:format(randomTeamIndex)
    hsc.objectCreateANew(selectedGhost)

    ---- Ghost is now spawned dynamically
    --local ghostObjectHandle = pigPen.compactSpawnNamedVehicle(selectedGhost)
    ---- All of the following HSC commands must be replaced by Balltze alternatives, anywhere where the hsc.objectCreate calls were replaced by pigPen module calls
    --if ghostObjectHandle then
    --    local ghostObject = engine.gameState.getObject(ghostObjectHandle, engine.tag.objectType.vehicle)
    --    -- We need to get the ghost driver unit (biped) object handle somehow to use it here. And look up the seat index from Guerilla:
    --    -- engine.gameState.unitEnterVehicle(, ghostObjectHandle, )
    --    
    --end

    -- Esto POSIBLEMENTE de segmentation. Se necesitan más pruebas. No funciona con el Flood.
    hsc.aiSpawn(1, selectedGhostPilot)
    hsc.vehicleLoadMagic(selectedGhost, "driver", selectedGhostPilot)
    hsc.aiMigrate(selectedGhostPilot, currentSupportType)
    hsc.unitEnterVehicle(selectedGhost, selectedDropship, "cargo_ghost02")
end

-- Esta función es llamada por tick cuando sus condiciones son activadas por el DropshipDeployer.
function firefightManager.DropshipCountdown()
    if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
        dropshipCountdownCounter = dropshipCountdownCounter - 1
    elseif dropshipCountdownStart == true and dropshipCountdownCounter <= 0 then
        hsc.aiExitVehicle(currentWaveType)
        hsc.unitExitVehicle(selectedGhostA)
        hsc.unitExitVehicle(selectedGhostC)
        hsc.unitExitVehicle(selectedGhostB)
        dropshipCountdownStart = false
        dropshipCountdownCounter = 0
    end
end

-- Esto spawnea a los Centinelas.
function firefightManager.SentinelChance()
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
        randomSentinelSquad = math.random(1, 6)
        selectedSentinelSquad = sentinelSquadTemplate:format(randomSentinelSquad)
        hsc.aiSpawn(1, selectedSentinelSquad)
        sentinelCooldown = 0
        sentinelChance = 0
        sentinelRandomMath = 0
    end
end

-- Esto spawnea las ayudas para el jugador.
function firefightManager.GameAssists()
    -- Te damos una vida y spawneamos a los aliados & ayudas.
    healthManager.livesGained()
    hsc.aiSpawn(1, "Human_Team/ODSTs")
    -- Le otorgamos los Warthos estandar al jugador.
    -- TODO: create a replacement function to spawn assist_warthog dynamically
    hsc.objectCreateANewContaining("assist_warthog")
    -- Spawneamos el Ghost de recompenza.
    randomGhost = math.random (1, 3)
    selectedAssistGhost = ghostAssistTemplate:format(randomGhost)
    -- hsc.objectCreateANew(selectedAssistGhost)
    -- Ghost is now spawned dynamically
    pigPen.compactSpawnNamedVehicle(selectedAssistGhost)
    --hsc.objectTeleport(selectedAssistGhost, "Selected_Ghost")
    -- Aca hacemos el mambo para spawnear el SuperHog en turno.
    randomWarthog = math.random (1, 3)
    selectedWarthog = warthogTemplate:format(randomWarthog)
    -- hsc.objectCreateANew(selectedWarthog)
    -- Warthog is now spawned dynamically
    pigPen.compactSpawnNamedVehicle(selectedWarthog)
    --hsc.objectTeleport(selectedWarthog, "Selected_Warthog")
end

-- Esto parcha horriblemente el problema del Ghost en el Spirit.
function firefightManager.GetOutOfGhost()
    if bossWaveCooldown == true then
        hsc.vehicleUnload(selectedGhostA, "driver")
        hsc.vehicleUnload(selectedGhostB, "driver")
        hsc.vehicleUnload(selectedGhostC, "driver")
        hsc.unitEnterable(selectedGhostA, 0)
        hsc.unitEnterable(selectedGhostB, 0)
        hsc.unitEnterable(selectedGhostC, 0)
        hsc.aiVehicleEntrableDistance(selectedGhostA, 0)
        hsc.aiVehicleEntrableDistance(selectedGhostB, 0)
        hsc.aiVehicleEntrableDistance(selectedGhostC, 0)
    elseif bossWaveCooldown == false then
        hsc.unitEnterable(selectedGhostA, 1)
        hsc.unitEnterable(selectedGhostB, 1)
        hsc.unitEnterable(selectedGhostC, 1)
        hsc.aiVehicleEntrableDistance(selectedGhostA, 20.0)
        hsc.aiVehicleEntrableDistance(selectedGhostB, 20.0)
        hsc.aiVehicleEntrableDistance(selectedGhostC, 20.0)
    end
end

-- Esto genera un navpoint en las unidades resagadas.
function firefightManager.aiNavpoint()
    if waveIsOn == false or bossWave == true then
        if waveLivingCount <= 4 then
            hsc.navpointEnemy("(player0)", currentWaveType, 0)
            hsc.navpointEnemy("(player0)", currentWaveType, 1)
            hsc.navpointEnemy("(player0)", currentWaveType, 2)
            hsc.navpointEnemy("(player0)", currentWaveType, 3)
        end
    end
end

function firefightManager.killStagnateAi()
    --Here goes super code to kill AI bellow certain z cord on the map.
end

-- Esta función es llamada cada tick si gameIsOn = true. Revisa y gestiona los actores en tiempo real.
local magicalSightCounter = 300
local magicalSightTimer = 0
function firefightManager.AiCheck()
    waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")
    hsc.aiAction(1, "Covenant_Support")
    hsc.aiAction(1, "Flood_Support")
    hsc.aiAction(1, "Covenant_Wave")
    hsc.aiAction(1, "Flood_Wave")
    hsc.aiAction(1, "Sentinel_Team")
    hsc.aiAction(1, "Human_Team")
    hsc.aiMagicallySeePlayers("Human_Team")
    hsc.aiMagicallySee("encounter", "Human_Team", "Covenant_Wave")
    hsc.aiMagicallySee("encounter", "Human_Team", "Covenant_Support")
    hsc.aiMagicallySee("encounter", "Human_Team", "Flood_Wave")
    hsc.aiMagicallySee("encounter", "Human_Team", "Flood_Support")
    hsc.aiMagicallySee("encounter", "Human_Team", "Sentinel_Team")
    hsc.aiMagicallySee("encounter", "Covenant_Wave", "Human_Team")
    hsc.aiMagicallySee("encounter", "Covenant_Support", "Human_Team")
    hsc.aiMagicallySee("encounter", "Flood_Wave", "Human_Team")
    hsc.aiMagicallySee("encounter", "Flood_Support", "Human_Team")
    hsc.aiMagicallySee("encounter", "Sentinel_Team", "Human_Team")
    hsc.aiVehicleEntrableDistance(selectedAssistGhost, 20.0)
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        firefightManager.AiSight()
    end
end

-- Each 10 seconds, AI will try to magically see each player if they're not invisible.
local player
---@param playerIndex? number
function firefightManager.AiSight(playerIndex)
    if playerIndex then
        player = blam.biped(get_dynamic_player(playerIndex))
    else
        player = blam.biped(get_dynamic_player())
    end
    if player then
        if player.isCamoActive == false then -- attempt to concatenate a table value (local 'targetObj')
            --hsc.aiMagicallySee("unit", "Covenant_Wave", player)
            --hsc.aiMagicallySee("unit", "Covenant_Support", player)
            --hsc.aiMagicallySee("unit", "Flood_Wave", player)
            --hsc.aiMagicallySee("unit", "Flood_Support", player)
            --hsc.aiMagicallySee("unit", "Sentinel_Team", player)
        end
    end
end

return firefightManager