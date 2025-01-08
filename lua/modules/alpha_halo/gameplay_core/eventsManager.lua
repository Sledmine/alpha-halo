local eventsManager = {}
local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block

local bansheeLivingCount
local snipersLivingCount
--local mortarLivingCount

-- Esta función es llamada cada que el mapa se carga, desde el firefightManager. Se encarga de iniciar el juego.
local gameIsOn = false
function eventsManager.whenMapLoads()
    gameIsOn = true
end

-- Esta función es llamada cada tick, desde el firefightManager. Se encarga de llamar otras funciones.
function eventsManager.eachTick()
    if gameIsOn == true then
        eventsManager.randomEventTimer()
        eventsManager.aiCheck()
    end
end

-- Esta función es llamada cada tick, desde el eachTick. Se encarga del timer.
local randomEventTimer = 3600
local randomEventCountdown = randomEventTimer
function eventsManager.randomEventTimer()
    if bansheeLivingCount == 0 or snipersLivingCount == 0 then -- or mortarLivingCount == 0 (Mortar is not working)
        if randomEventCountdown > 0 then
            randomEventCountdown = randomEventCountdown - 1
        else
            eventsManager.randomEventGenerator()
            randomEventCountdown = randomEventTimer
        end
    end
end

-- Esta función es llamada por randomEventTimer. Se encarga de randomizar el evento.
function eventsManager.randomEventGenerator()
    local selectedEvent = math.random(1, 2) -- 1, 3 (Mortar is not working)
    if selectedEvent == 1 then
        eventsManager.bansheeEvent()
    elseif selectedEvent == 2 then
        eventsManager.sniperEvent()
    --elseif selectedEvent == 3 then
    --    eventsManager.mortarEvent()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covennat Banshee.
function eventsManager.bansheeEvent()
    if bansheeLivingCount == 0 then
        console_out("Banshee event!")
        hsc.aiSpawn(1, "Covenant_Banshees")
        hsc.objectCreateANew("banshee_1")
        hsc.objectCreateANew("banshee_2")
        hsc.vehicleLoadMagic("banshee_1", "B-driver", "Covenant_Banshees/banshee_a")
        hsc.vehicleLoadMagic("banshee_2", "B-driver", "Covenant_Banshees/banshee_b")
        hsc.objectTeleport("banshee_1", "Banshee_1")
        hsc.objectTeleport("banshee_2", "Banshee_2")
    else
        eventsManager.randomEventGenerator()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covenant Sniper.
function eventsManager.sniperEvent()
    if snipersLivingCount == 0 then
        console_out("Sniper event!")
        hsc.aiSpawn(1, "Covenant_Snipers")
    else
        eventsManager.randomEventGenerator()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covenant Mortar.
-- Por ahora, esto no se está llamando, dado que el Mortero no dispara en lo absoluto.
--function eventsManager.mortarEvent()
--    if mortarLivingCount == 0 then
--        console_out("Mortar event!")
--        hsc.aiSpawn(1, "Covenant_Mortars")
--        hsc.vehicleLoadMagic("mortar_1", "W-gunner", "Covenant_Mortars/mortar_a")
--        hsc.vehicleLoadMagic("mortar_2", "W-gunner", "Covenant_Mortars/mortar_b")
--    else
--        eventsManager.randomEventGenerator()
--    end
--end

-- Esta función es llamada cada tick, desde el eachTick. Se encarga de revisar el estado de los squads.
function eventsManager.aiCheck()
    bansheeLivingCount = hsc.aiLivingCount("Covenant_Banshees", "banshees_living_count")
    snipersLivingCount = hsc.aiLivingCount("Covenant_Snipers", "snipers_living_count")
    --mortarLivingCount = hsc.aiLivingCount("Covenant_Mortars", "mortars_living_count")
    hsc.aiMagicallySeePlayers("Covenant_Banshees")
    hsc.aiMagicallySeePlayers("Covenant_Snipers")
    hsc.aiAction(1, "Covenant_Snipers")
    --hsc.aiMagicallySeePlayers("Covenant_Mortars")
    --hsc.aiAction(1, "Covenant_Mortars")
end

return eventsManager