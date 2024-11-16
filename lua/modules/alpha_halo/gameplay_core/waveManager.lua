local waveManager = {}
local blam = require "blam"
local hsc = require "hsc"

-- Aquí manejamos las Waves, Rounds y Sets. 5 waves son una round, 3 rounds son un set.
local currentWave = 1
local currentRound = 1
local currentSet = 0
-- Aqui manejamos los Platoons. Nos sirve para loopear las dropships.
local platoonsAsigned = 1
local dropshipsAsigned = 3
-- Aquí manejamos los despliegues. Esto lleva la cuenta desbordar las dropships.
local deploymentTime = 650
local dropshipsSent = false
local deploymentCounter = deploymentTime
-- Estas son las variables que determinan el randomizador de los squads.
local squadTemplate = "Enemy_Team_%s/Tier_%s_Squad_%s"
local randomTeam = 1
local currentTier = 1
local randomSquad = 1
local selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
-- Estas son las variables que determinan el randomizador de los platoons.
local platoonTemplate = "Enemy_Team_%s/Selected_Platoon"
local platoonSelected = platoonTemplate:format(randomTeam)
-- Estas variables determinan el randomizador de las dropships.
local dropshipTemplate = "dropship_%s_%s" -- Las units en Sapien no llevan mayusculas.
local randomDropship = 1
local selectedDropship = dropshipTemplate:format(dropshipsAsigned, randomDropship)
local dropshipAnimation = dropshipTemplate:format(dropshipsAsigned, randomDropship)

-- Esta es la función que se llama al iniciar cada wave, y es la que randomiza, spawnea e inicia el despliegue.
function waveManager.WaveDeployer()
    --[[A partir del Set 3 cada oleada tendrá un equipo diferente. Antes de eso, sólo se randomiza cada inicio de ronda.
    if currentSet >= 3 then
        randomTeam = math.random (1, 2)
    else
        if currentWave == 1 then
            randomTeam = math.random (1, 2)
        end
    end
    -- Aquí se loopea crear el squad, el dropship y subirlos.
    local dropshipsLeft = dropshipsAsigned
    if dropshipsLeft > 0 then
        -- Aquí se define el nombre del squad randomizado.
        local randomSquad = math.random (1, 6)
        local selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
        -- Aquí se define el nombre de la dropship randomiazda.
        local randomDropship = math.random (1, 2)
        local selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
        -- Aquí se spawnean los squads y se transportan a sus dropships.
        console_out(selectedSquad)
        hsc.aiSpawn(1, selectedSquad)
        hsc.objectCreate(selectedDropship)
        hsc.vehicleLoadNoSeat(selectedSquad, selectedDropship)
        hsc.customAnimation(selectedDropship, "[shm]\\halo_1\\maps\\installation_04_ic14_test\\installation_04_ic14_test", selectedDropship, 2)
        dropshipsLeft = dropshipsLeft - 1
    end]]
    -- Randomizamos el squad cada que esta función es llamada.
    randomSquad = math.random (1, 6)
    selectedSquad = squadTemplate:format(randomTeam, currentTier, randomSquad)
    -- Randomizamos la dropship cada que esta función es llamada.
    randomDropship = 1
    selectedDropship = dropshipTemplate:format(dropshipsAsigned, randomDropship)
    dropshipAnimation = dropshipTemplate:format(dropshipsAsigned, randomDropship)
    -- Comenzamos el despliegue de los squads en las dropships.
    hsc.objectCreate(selectedDropship)
    hsc.aiSpawn(1, selectedSquad)
    hsc.vehicleLoadMagic(selectedDropship, "passenger", selectedSquad)
    hsc.customAnimation(selectedDropship, "[shm]\\halo_1\\maps\\installation_04_ic14_test\\installation_04_ic14_test", dropshipAnimation, 2)
    if randomTeam == 1 then
        hsc.aiMigrate(selectedSquad, "Covenant_Wave")
    elseif randomTeam == 2 then
        hsc.aiMigrate(selectedSquad, "Flood_Wave")
    end
    dropshipsSent = true
    deploymentCounter = deploymentTime
    dropshipsAsigned = dropshipsAsigned - 1
end

function waveManager.WaveManager()
    -- Aquí revisamos el living count. Esto se conecta a un bool en hsc.
    local waveLivingCount = hsc.aiLivingCount("Covenant_Wave", "covenant_living_count") + hsc.aiLivingCount("Flood_Wave", "flood_living_count")
    local marineLivingCount = hsc.aiLivingCount("Human_Team", "marine_living_count")
    -- Aquí gestionamos el despliegue de tropas y el inicio de las oleadas.
    if dropshipsAsigned > 0 then
        waveManager.WaveDeployer()
    elseif waveLivingCount <= 8 then
        dropshipsAsigned = 3
        randomTeam = 1 --math.random (1, 2)
        console_out("Next Wave Incoming!")
    end
    -- Aquí cronometramos el despliegue de las tropas en las dropships desplegadas.
    if dropshipsSent == true and deploymentCounter > 0 then
        deploymentCounter = deploymentCounter - 1
    elseif deploymentCounter <= 0 then
        hsc.aiExitVehicle("Covenant_Wave")
        hsc.aiExitVehicle("Flood_Wave")
        dropshipsSent = false
        deploymentCounter = deploymentTime
    end
    -- Aquí spawneamos refuerzos. En el futuro, llegarán en un Pelican en las Boss Waves.
    if marineLivingCount <= 2 then
        hsc.aiSpawn(1, "Human_Team/ODSTs")
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
    --[[local platoonRemaining = platoonsAsigned
    if (currentSet >= 1) then
        -- El juego revisa cuántas units quedan vivas y aún quedan platoons por desplegar.
        -- Se debería dormir la función unos segundos para dar tiempo a spawnear a las IAs. De lo contrario, la condición se puede cumplir durante varios ticks y terminaríamos con varios despliegues.
        if (waveLivingCount <= 8) and (platoonRemaining > 0) then
            waveManager.WaveDeployer()
            platoonRemaining = platoonRemaining - 1
        -- Si ya no quedan platoons asignados, la oleada termina.
        elseif (waveLivingCount <= 8) and (platoonRemaining == 0) then
            -- Si la oleada es menor que 5, se suma 1. Si es 5, se reinicia a 1.
            if (currentWave < 5) then
                currentWave = currentWave + 1
            else
                currentWave = 1
                -- Si la round es menor que 3, se suma 1. Si es 3, se reinicia a 1 y se suma 1 a set.
                if (currentRound < 3) then
                currentRound = currentRound + 1
                else
                currentRound = 1
                currentSet = currentSet + 1
                end
            end
            -- A partir del Set 4, los platoons asignados iran incrementando de a uno, volviendo el post-game progresivamente más largo.
            if (currentSet >= 4) then
                platoonsAsigned = platoonsAsigned + 1
            end
            -- === AQUÍ SE DEBE LOOPEAR EL INICIO DE LA SIGUIENTE OLEADA. ESTO NO FUNCIONA BIEN. ===
            console_out("Butts have been kicked!")
            waveManager.WaveDeployer()
        end
    end]]
end

return waveManager