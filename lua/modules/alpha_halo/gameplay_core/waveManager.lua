local waveManager = {}
local hsc = require "hsc"

-- Preguntarle a Sled domo manejar las funciones locales.
-- Aquí manejamos las Waves, Rounds y Sets. 5 waves son una round, 3 rounds son un set.
local currentWave = 1
local currentRound = 1
local currentSet = 0
local platoonsAsigned = 1
local dropshipsAsigned = 3
-- Estas son las variables que determinan el randomizador del spawn de unidades.
local randomTeam = math.random (1, 2)
local currentTier = 1
local squadTemplate = "Team_%s/Tier_%s_Squad_%s"
local platoonTemplate = "Team_%s/Selected_Platoon"
-- Estas variables determinan el randomizador de las dropships.
local dropshipTemplate = "dropship_%s_%s" -- Las units en Sapien no llevan mayusculas, al parecer.

-- Esta es la función que se llama al iniciar cada wave, y es la que randomiza, spawnea y transporta a los enemigos.
function waveManager.WaveDeployer()
    -- A partir del Set 3 cada oleada tendrá un equipo diferente. Antes de eso, sólo se randomiza cada inicio de ronda.
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
        local platoonSelected = platoonTemplate:format(randomTeam)
        -- Aquí se define el nombre de la dropship randomiazda.
        local randomDropship = math.random (1, 2)
        local selectedDropship = dropshipTemplate:format(dropshipsLeft, randomDropship)
        -- Aquí se spawnean los squads y se transportan a sus dropships.
        console_out(selectedSquad)
        hsc.aiPlace(selectedSquad)
        hsc.objectCreate(selectedDropship)
        hsc.vehicleLoadNoSeat(selectedSquad, selectedDropship)
        hsc.customAnimation(selectedDropship, "[shm]\\halo_1\\maps\\installation_04_ic14_test\\installation_04_ic14_test", selectedDropship, 2)
        dropshipsLeft = dropshipsLeft - 1
    end
    -- luego de esto se bajan los cacos
    hsc.aiMigrate(platoonSelected, "Current_Wave")
end

function waveManager.WaveManager()
    -- Para proppositos de test, sumamos +1 a Set con esto. Esto debería iniciar automáticamente el juego.
    local player = blam.biped(get_dynamic_player())
    if player.actionKey and player.crouchHold then
        currentSet = currentSet + 1
        console_out(currentSet)
    end
    -- Estas dos variables nos van a determinar cuántas tropas se despliegan en una oleada.
    local waveLivingCount = hsc.aiLivingCount("Current_Wave", "wave_living_count")
    local platoonRemaining = platoonsAsigned
    if (currentSet >= 1) then
        -- Estos comandos son para que los enemigos siempre sepan dónde estás y te sigan.
        -- Están acá porque quieres que esto ocurra onTick mientras la partida esté corriendo.
        hsc.aiMagicallySeePlayers("Current_Wave")
        hsc.aiAction(1, "Current_Wave")
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
    end
end

return waveManager