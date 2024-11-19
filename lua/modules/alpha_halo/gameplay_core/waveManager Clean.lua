local firefightManager = {}
local hsc = require "hsc"
-- VARIABLES DE LA FUNCIÓN firefightManager.OnMapLoad
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.OnTick
local waveIsOn = false
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveProgression
local currentWave = 0
local currentRound = 0
local currentSet = 0
local waveTemplate = "Wave %s, Round %s, Set %s."
local actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
-- VARIABLES DE LA FUNCIÓN firefightManager.WaveCooldown
local waveCooldownTimer = 270
local waveCooldownStart = false
local waveCooldownCounter = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipDeployer relacionadas al Squad.
local randomTeam = 1
local currentTier = 1
local randomSquad = 1
local squadTemplate = "Enemy_Team_%s/Tier_%s_Squad_%s"
local selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipDeployer relacionadas al Vehicle.
local dropshipsAsigned = 3
local dropshipsLeft = 0
local randomDropship = 1
local dropshipTemplate = "dropship_%s_%s"
local selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
-- VARIABLES DE LA FUNCIÓN firefightManager.DropshipCountdown
local dropshipCountdownTimer = 630
local dropshipCountdownStart = false
local dropshipCountdownCounter = 0
-- VARIABLES DE LA FUNCIÓN firefightManager.AiCheck
local waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")

-- Esta función ocurre al iniciar el mapa. Causa cambios a la función onTick.
function firefightManager.OnMapLoad()
    console_out("Welcome to Alpha Firefight")
    gameIsOn = true
    currentRound = 1
    currentSet = 1
end

-- Esta función ocurre cada tick. Ejecuta al resto de funciones cuando se dan las condiciones.
function firefightManager.OnTick()
    if gameIsOn == true then
        -- Actualizamos constantemente el estado de la IA.
        firefightManager.AiCheck()
        -- Si waveIsOn = true, se inician los procesos de la oliada. Si no, se inicia el cooldown.
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                firefightManager.DropshipDeployer()
            elseif waveLivingCount <= 8 then
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                waveIsOn = false
                firefightManager.WaveProgression()
            end
        else
            firefightManager.WaveCooldown()
        end
        -- Si dropshipCountown = true, ejecutamos la función que contiene el cronometro.
        if dropshipCountdownStart == true then
            firefightManager.DropshipCountdown()
        end
    end
end

-- Esta función se llama cuando sólo quedan 8 enemigos. Progresa las oleadas, y realiza cambios en base a esto.
function firefightManager.WaveProgression()
    if (currentWave < 5) then
        currentWave = currentWave + 1
        if currentSet >= 4 then
            randomTeam = math.random (1, 2)
        end
        -- Si la Wave es igual a 5, se reinicia y se randomiza el team.
    elseif currentWave >= 5 then
        currentWave = 1
        randomTeam = math.random (1, 2)
        hsc.aiSpawn(1, "Human_Team/ODSTs")
        if currentTier < 3 then
            currentTier = currentTier + 1
        end
        -- Si la Round es menor que 3, avanaz una. Si es 3, se reinicia y Set avanza una.
        if (currentRound < 3) then
            currentRound = currentRound + 1
        elseif currentRound >= 3 then
            currentRound = 1
            currentSet = currentSet + 1
        end
    end
end

-- Esta función se llama cuando waveIsOn = false. Maneja el cooldown de las waves a la espera de iniciar otra.
function firefightManager.WaveCooldown()
    if waveCooldownStart == true and waveCooldownCounter > 0 then
        waveCooldownCounter = waveCooldownCounter - 1
        console_out(waveCooldownCounter)
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
    -- Randomizamos el squad cada que esta función es llamada, sólo dos veces.
    if dropshipsLeft > 1 then
        randomSquad = math.random (1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
    -- Cargamos a los squads en sus respectivas dropships y los migramos a sus encounters.
    hsc.objectCreateANew(selectedDropship)
    hsc.aiSpawn(1, selectedSquad)
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, "false")
    -- Dependiendo del team, lo migramos a su respectivo encounter.
    if randomTeam == 1 then
        hsc.aiMigrate(selectedSquad, "Covenant_Wave")
    elseif randomTeam == 2 then
        hsc.aiMigrate(selectedSquad, "Flood_Wave")
    end
    -- Iniciamos los contadores y vamos extinguiendo el script.
    dropshipsLeft = dropshipsLeft - 1
    dropshipCountdownStart = true
    dropshipCountdownCounter = dropshipCountdownTimer
end

-- Esta función es llamada por tick cuando sus condiciones son activadas por el DropshipDeployer.
function firefightManager.DropshipCountdown()
    if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
        dropshipCountdownCounter = dropshipCountdownCounter - 1
    elseif dropshipCountdownStart == true and dropshipCountdownCounter <= 0 then
        hsc.aiExitVehicle("Covenant_Wave")
        hsc.aiExitVehicle("Flood_Wave")
        dropshipCountdownStart = false
        dropshipCountdownCounter = 0
    end
end

-- Esta función es llamada cada tick si gameIsOn = true. Revisa y gestiona los actores en tiempo real.
function firefightManager.AiCheck()
    waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")
    hsc.aiMagicallySee(1, "Covenant_Wave", "")
    hsc.aiAction(1, "Covenant_Wave")
    hsc.aiMagicallySee(1, "Flood_Wave", "")
    hsc.aiAction(1, "Flood_Wave")
    hsc.aiMagicallySee(1, "Human_Team", "")
    hsc.aiAction(1, "Human_Team")
    hsc.aiMagicallySee(1, "Sentinel_Team", "")
    hsc.aiAction(1, "Sentinel_Team")
    hsc.aiMagicallySee(1, "Emergent_Dangers", "")
    hsc.aiAction(1, "Emergent_Dangers")
end

return firefightManager