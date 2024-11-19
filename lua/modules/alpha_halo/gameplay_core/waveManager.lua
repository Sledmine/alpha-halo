local waveManager = {}
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
local waveCooldownTimer = 270
local waveCooldownStart = false
local waveCooldownCounter = 0
-- Aquí manejamos los despliegues. Esto lleva la cuenta desbordar las dropships.
local dropshipCountdownTimer = 630
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
-- Estas variables registran cada una de las dropships.
local dropshipThird = selectedDropship
local dropshipSecond = selectedDropship
local dropshipFirst = selectedDropship

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
        -- Aquí gestionamos el despliegue de tropas y el inicio de las oleadas.
        actualWave = waveTemplate:format(currentWave, currentRound, currentSet)
        if waveIsOn == true then
            if dropshipsLeft > 0 then
                waveManager.WaveDeployer()
            elseif waveLivingCount <= 8 then
                waveCooldownStart = true
                waveCooldownCounter = waveCooldownTimer
                waveIsOn = false
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
        end
        -- Aquí cronometramos el cooldown de las oleadas y el despliegue de las anims.
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
        -- Aquí cronometramos el despliegue de las tropas en las dropships desplegadas.
        if dropshipCountdownStart == true and dropshipCountdownCounter > 0 then
            dropshipCountdownCounter = dropshipCountdownCounter - 1
        elseif dropshipCountdownStart == true and dropshipCountdownCounter <= 0 then
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
    -- Randomizamos el squad cada que esta función es llamada, sólo dos veces.
    if dropshipsLeft > 1 then
        randomSquad = math.random (1, 6)
    end
    selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
    -- Randomizamos la dropship cada que esta función es llamada.
    randomDropship = math.random (1)
    selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
    -- Guardamos el nombre de las dropships para las animaciones.
    if dropshipsLeft == 3 then
        dropshipThird = selectedDropship
    elseif dropshipsLeft == 2 then
        dropshipSecond = selectedDropship
    elseif dropshipsLeft == 1 then
        dropshipFirst = selectedDropship
    end
    -- Cargamos a los squads en sus respectivas dropships y los migramos a sus encounters.
    hsc.objectCreate(selectedDropship)
    hsc.aiSpawn(1, selectedSquad)
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, "false")
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

return waveManager