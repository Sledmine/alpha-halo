local waveManager = {}
local blam = require "blam"
local hsc = require "hsc"
-- Aquí manejamos las Waves, Rounds y Sets. 5 waves son una round, 3 rounds son un set.
local currentWave = 0
local currentRound = 0
local currentSet = 0
local gameIsOn = false
local waveIsOn = false
local waveTemplate = "Wave %s, Round %s, Set %s."
local actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
-- Aqui manejamos los Platoons. Nos sirve para loopear las dropships.
local dropshipsAsigned = 3
local dropshipsLeft = 0
-- Aquí manejamos el wave cooldown. Esto lleva la cuenta desbordar las dropships.
local waveCooldownTimer = 300
local waveCooldownStart = false
local waveCooldownCounter = 0
-- Aquí manejamos los despliegues. Esto lleva la cuenta desbordar las dropships.
local dropshipCountdownTimer = 650
local dropshipCountdownStart = false
local dropshipCountdownCounter = 0
-- Estas son las variables que determinan el randomizador de los squads.
local squadTemplate = "Enemy_Team_%s/Tier_%s_Squad_%s"
local randomTeam = 1
local currentTier = 1
local randomSquad = 1
local selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
-- Estas variables determinan el randomizador de las dropships.
local dropshipTemplate = "dropship_%s_%s" -- Las units en Sapien no llevan mayusculas.
local randomDropship = 1
local selectedDropship = dropshipTemplate:format(dropshipsAsigned, randomDropship)
-- Variables para animaciones pregrabadas
--local recordedAnimationsAsigned = 2
--local randomRecordedAnimation = 1
--local recordedAnimationTemplate = "drop_%s" -- Nombres de las Animaciones
--local selectedRecordedAnimation = recordedAnimationTemplate:format(recordedAnimationsAsigned, randomRecordedAnimation)

-- Esta es la función que inicia el juego.
function waveManager.GameStart()
    console_out("Welcome to Alpha Firefight")
    gameIsOn = true
    waveIsOn = true
    currentRound = 1
    currentSet = 1
    hsc.aiSpawn(1, "Human_Team/ODSTs")
end

-- Esta es la función que corre onTick y controla los eventos del juego.
function waveManager.WaveManager()
    if gameIsOn == true then
        -- Aquí revisamos el living count. Esto se conecta a un bool en hsc.
        local waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")
        actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
        -- Aquí gestionamos el despliegue de tropas y el inicio de las oleadas.
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                waveManager.WaveDeployer()
            elseif waveLivingCount <= 8 then
                waveIsOn = false
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                -- Si la Wave es menor a 5, avanza una. Si pasaste el Set 4, se randomiza el team.
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
        elseif waveIsOn == false then
            if waveCooldownStart == true and waveCooldownCounter > 0 then
                waveCooldownCounter = waveCooldownCounter - 1
            elseif waveCooldownCounter <= 0 then
                waveIsOn = true
                dropshipsLeft = dropshipsAsigned
                console_out(actualWave)
                waveCooldownStart = false
                waveCooldownCounter = 0
            end
        end
        -- Aquí cronometramos el despliegue de las tropas en las dropships desplegadas.
        if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
            dropshipCountdownCounter = dropshipCountdownCounter - 1
        elseif dropshipCountdownCounter <= 0 then
            hsc.aiExitVehicle("Covenant_Wave")
            hsc.aiExitVehicle("Flood_Wave")
            dropshipCountdownStart = false
            dropshipCountdownCounter = 0
        end
        -- Debe haber una mejor forma de hacer esto, lmao.
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
end

-- Esta es la función que se llama al iniciar cada wave, y es la que randomiza, spawnea e inicia el despliegue.
function waveManager.WaveDeployer()
    -- Randomizamos el squad cada que esta función es llamada.
    if dropshipsLeft > 1 then
        randomSquad = math.random (1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
    -- Randomizamos la dropship cada que esta función es llamada.
    randomDropship = math.random (1)
    selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
    -- Randomizamos las animaciones pre grabadas
    randomRecordedAnimation = math.random (1)
    selectedRecordedAnimation = recordedAnimationTemplate:format(dropshipsLeft, randomRecordedAnimation)
    -- Comenzamos el despliegue de los squads en las dropships.
    hsc.objectCreate(selectedDropship)
    hsc.aiSpawn(1, selectedSquad)
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "[shm]\\halo_1\\maps\\installation_04_ic14_test\\installation_04_ic14_test", selectedDropship, 2)
    --hsc.recordingAnimationHover(selectedDropship, selectedRecordedAnimation)
    if randomTeam == 1 then
        hsc.aiMigrate(selectedSquad, "Covenant_Wave")
    elseif randomTeam == 2 then
        hsc.aiMigrate(selectedSquad, "Flood_Wave")
    end
    dropshipsLeft = dropshipsLeft - 1
    dropshipCountdownStart = true
    dropshipCountdownCounter = dropshipCountdownTimer
end

return waveManager