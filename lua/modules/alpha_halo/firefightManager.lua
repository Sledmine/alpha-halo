local firefightManager = {}
local hsc = require "hsc"
-- VARIABLES DE LA FUNCIÓN firefightManager.WhenMapLoads
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.EachTick
local waveIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveProgression
local currentWave = 0
local currentRound = 0
local currentSet = 0
local waveTemplate = "Wave %s, Round %s, Set %s."
local actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
local bossWave = false
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveCooldown
local waveCooldownTimer = 450
local waveCooldownStart = false
local waveCooldownCounter = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipDeployer relacionadas al Squad.
local randomTeam = 1
local currentTier = 1
local randomSquad = 1
local currentTeam = "Covenant_Wave"
local squadTemplate = "Enemy_Team_%s/Tier_%s_Squad_%s"
local selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
local bossSquadTemplate = "Enemy_Team_%s/Boss_Wave"
local selectedBossSquad = bossSquadTemplate:format(randomTeam)
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
local randomSentinelSquad = 1
local sentinelSquadTemplate = "Sentinel_Team/Sentinels_%s"
local selectedSentinelSquad = sentinelSquadTemplate:format(randomSentinelSquad)
-- VARIALBES DE LA FUNCIÓN firefightManager.GhostLoader()
local randomGhost = 0
local ghostATemplate = "ghost_%s_A"
local ghostBTemplate = "ghost_%s_B"
local ghostCTemplate = "ghost_%s_C"
local selectedGhostA = ghostATemplate:format(randomGhost)
local selectedGhostB = ghostBTemplate:format(randomGhost)
local selectedGhostC = ghostCTemplate:format(randomGhost)
-- VARIABLES DE LA FUNCIÓN firefightManager.GameAssists()
local randomWarthog = 0
local warthogTemplate = "warthog_%s"
local selectedWarthog = warthogTemplate:format(randomWarthog)

-- Esta función ocurre al iniciar el mapa. Causa cambios a la función onTick.
function firefightManager.WhenMapLoads()
    console_out("Welcome to Alpha Firefight.")
    gameIsOn = true
    waveIsOn = true
    currentRound = 1
    currentSet = 1
    randomTeam = math.random (1, 2)
    if randomTeam == 1 then
        currentTeam = "Covenant_Wave"
    elseif randomTeam == 2 then
        currentTeam = "Flood_Wave"
    end
end

-- Esta función ocurre cada tick. Ejecuta al resto de funciones cuando se dan las condiciones.
function firefightManager.EachTick()
    if gameIsOn == true then
        -- Actualizamos constantemente el estado de la IA.
        firefightManager.AiCheck()
        -- Revisamos constantemente el countdown de las Dropships.
        firefightManager.DropshipCountdown()
        -- Si waveIsOn = true, se inician los procesos de la oleaada. Si no, se inicia el cooldown.
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                firefightManager.DropshipDeployer()
            elseif bossWave == false and waveLivingCount <= 8 then
                console_out("Bad guys comming in!")
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                waveIsOn = false
                firefightManager.WaveProgression()
            elseif bossWave == true and waveLivingCount <= 0 then
                console_out("Round Complete!")
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                waveIsOn = false
                firefightManager.WaveProgression()
            end
        else
            firefightManager.WaveCooldown()
        end
    end
end

-- Esta función se llama cuando pasas de oleada. Progresa el juego y realiza cambios en base a esto.
function firefightManager.WaveProgression()
    -- Si la Wave es menor que 5, avanaz una. Si es 5, se reinicia y Set avanza una.
    if (currentWave < 5) then
        currentWave = currentWave + 1
        if currentSet >= 4 then
            randomTeam = math.random (1, 2)
            if randomTeam == 1 then
                currentTeam = "Covenant_Wave"
            elseif randomTeam == 2 then
                currentTeam = "Flood_Wave"
            end
        end
    elseif currentWave == 5 then
        currentWave = 1
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
    -- Si la ronda acaba de comenzar, randomizamos el team y spawneamos las asistencias.
    if currentWave == 1 then
        if currentSet < 4 then
            if randomTeam == 2 then
                randomTeam = 1
                currentTeam = "Covenant_Wave"
            elseif randomTeam == 1 then
                randomTeam = 2
                currentTeam = "Flood_Wave"
            end
        end
        firefightManager.GameAssists()
    end
    -- Si la ronda es 5, entonces es una Boss Wave.
    if currentWave == 5 then
        bossWave = true
    else
        bossWave = false
    end
    actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
    -- Aquí llamamos la función de los Sentinelas.
    firefightManager.SentinelChance()
end

-- Esta función se llama cuando waveIsOn = false. Maneja el cooldown de las waves a la espera de iniciar otra.
function firefightManager.WaveCooldown()
    if waveCooldownStart == true and waveCooldownCounter > 0 then
        waveCooldownCounter = waveCooldownCounter - 1
    elseif waveCooldownStart == true and waveCooldownCounter <= 0 then
        console_out(actualWave)
        waveIsOn = true
        dropshipsLeft = dropshipsAsigned
        waveCooldownStart = false
        waveCooldownCounter = 0
    end
end

-- Esta función es llamada una vez por cada dropship asignada a una oleada. Se encarga de cargar y enviar las dropships.
function firefightManager.DropshipDeployer()
    -- Randomizamos la dropship cada que esta función es llamada.
    randomDropship = math.random (1)
    selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
    hsc.objectCreateANew(selectedDropship)
    -- Randomizamos el squad cada que esta función es llamada.
    -- La Dropship 1 será identica a la Dropship 2.
    -- Si es una Boss Wave, la Dropship 1 carga el Boss Squad y los Ghost.
    if dropshipsLeft > 1 then
        randomSquad = math.random (1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
    selectedBossSquad = bossSquadTemplate:format(randomTeam)
    if dropshipsLeft == 1 and bossWave == true then
        selectedSquad = selectedBossSquad
        firefightManager.GhostLoader()
    end
    hsc.aiSpawn(1, selectedSquad)
    -- Cargamos a los squads en sus respectivas dropships y los migramos a sus encounters.
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, "false")
    -- Dependiendo del team, lo migramos a su respectivo encounter.
    hsc.aiMigrate(selectedSquad, currentTeam)
    -- Iniciamos los contadores y vamos extinguiendo el script.
    dropshipsLeft = dropshipsLeft - 1
    dropshipCountdownStart = true
    dropshipCountdownCounter = dropshipCountdownTimer
end

function firefightManager.GhostLoader()
    randomGhost = math.random (1, 3)
    selectedGhostA = ghostATemplate:format(randomGhost)
    selectedGhostB = ghostBTemplate:format(randomGhost)
    selectedGhostC = ghostCTemplate:format(randomGhost)
    hsc.objectCreateANew(selectedGhostA)
    hsc.objectCreateANew(selectedGhostB)
    hsc.objectCreateANew(selectedGhostC)
    hsc.unitEnterVehicle(selectedGhostA, selectedDropship, "cargo_ghost01")
    hsc.unitEnterVehicle(selectedGhostB, selectedDropship, "cargo_ghost02")
    hsc.unitEnterVehicle(selectedGhostC, selectedDropship, "cargo_ghost03")
    hsc.aiVehicleEncounter(selectedGhostA, currentTeam)
    hsc.aiVehicleEncounter(selectedGhostB, currentTeam)
    hsc.aiVehicleEncounter(selectedGhostC, currentTeam)
end

-- Esta función es llamada por tick cuando sus condiciones son activadas por el DropshipDeployer.
function firefightManager.DropshipCountdown()
    if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
        dropshipCountdownCounter = dropshipCountdownCounter - 1
    elseif dropshipCountdownStart == true and dropshipCountdownCounter <= 0 then
        hsc.aiExitVehicle("Covenant_Wave")
        hsc.aiExitVehicle("Flood_Wave")
        hsc.unitExitVehicle(selectedGhostA)
        hsc.unitExitVehicle(selectedGhostB)
        hsc.unitExitVehicle(selectedGhostC)
        dropshipCountdownStart = false
        dropshipCountdownCounter = 0
    end
end

function firefightManager.GameAssists()
    hsc.aiSpawn(1, "Human_Team/ODSTs")
    randomWarthog = math.random (1, 3)
    selectedWarthog = warthogTemplate:format(randomWarthog)
    hsc.objectCreateANew(selectedWarthog)
    hsc.objectCreateANewContaining("assist_")
    hsc.aiVehicleEncounter(selectedWarthog, "Human Team")
    hsc.objectTeleport(selectedWarthog, "Selected_Warthog")
end

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
        console_out("Here come Sentinels!")
        randomSentinelSquad = math.random(1, 6)
        selectedSentinelSquad = sentinelSquadTemplate:format(randomSentinelSquad)
        hsc.aiSpawn(1, selectedSentinelSquad)
        sentinelCooldown = 0
        sentinelChance = 0
        sentinelRandomMath = 0
    end
end

-- Esta función es llamada cada tick si gameIsOn = true. Revisa y gestiona los actores en tiempo real.
function firefightManager.AiCheck()
    waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")
    hsc.aiAction(1, "Covenant_Wave")
    hsc.aiMagicallySee(1, "Flood_Wave", "")
    hsc.aiAction(1, "Flood_Wave")
    hsc.aiMagicallySee(1, "Human_Team", "")
    hsc.aiAction(1, "Human_Team")
    hsc.aiMagicallySee(1, "Sentinel_Team", "")
    hsc.aiAction(1, "Sentinel_Team")
    hsc.aiMagicallySee(1, "Emergent_Dangers", "")
    hsc.aiAction(1, "Emergent_Dangers")
    hsc.aiVehicleEntrableDistance(selectedGhostA, 20.0)
    hsc.aiVehicleEntrableDistance(selectedGhostB, 20.0)
    hsc.aiVehicleEntrableDistance(selectedGhostC, 20.0)
    hsc.aiVehicleEntrableDistance(selectedWarthog, 20.0)
end

return firefightManager