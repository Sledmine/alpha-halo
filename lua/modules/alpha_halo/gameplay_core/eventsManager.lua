local eventsManager = {}
local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block

local bansheeLivingCount
local snipersLivingCount
--local mortarLivingCount

-- Esta función es llamada cada tick, desde el firefightManager. Se encarga de llamar otras funciones.
function eventsManager.eachTick()
    eventsManager.randomEventTimer()
    eventsManager.aiCheck()
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
        logger:debug("Banshee event!")
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
        logger:debug("Sniper event!")
        hsc.aiSpawn(1, "Covenant_Snipers")
    else
        eventsManager.randomEventGenerator()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covenant Mortar.
-- Por ahora, esto no se está llamando, dado que el Mortero no dispara en lo absoluto.
--function eventsManager.mortarEvent()
--    if mortarLivingCount == 0 then
--        logger:debug("Mortar event!")
--        hsc.aiSpawn(1, "Covenant_Mortars")
--        hsc.vehicleLoadMagic("mortar_1", "W-gunner", "Covenant_Mortars/mortar_a")
--        hsc.vehicleLoadMagic("mortar_2", "W-gunner", "Covenant_Mortars/mortar_b")
--    else
--        eventsManager.randomEventGenerator()
--    end
--end

-- Esta función es llamada cada tick, desde el eachTick. Se encarga de revisar el estado de los squads.
local magicalSightCounter = 300
local magicalSightTimer = 0
function eventsManager.aiCheck()
    bansheeLivingCount = hsc.aiLivingCount("Covenant_Banshees", "banshees_living_count")
    snipersLivingCount = hsc.aiLivingCount("Covenant_Snipers", "snipers_living_count")
    hsc.aiAction(1, "Covenant_Snipers")
    hsc.aiMagicallySee("encounter", "Human_Team", "Covenant_Banshees")
    hsc.aiMagicallySee("encounter", "Human_Team", "Covenant_Snipers")
    hsc.aiMagicallySeePlayers("Covenant_Snipers")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        eventsManager.AiSight()
    end
end

-- Each 10 seconds, AI will try to magically see each player if they're not invisible.
local player
---@param playerIndex? number
function eventsManager.AiSight(playerIndex)
    if playerIndex then
        player = blam.biped(get_dynamic_player(playerIndex))
    else
        player = blam.biped(get_dynamic_player())
    end
    if player then
        if player.isCamoActive == false then  -- attempt to concatenate a table value (local 'targetObj')
            --hsc.aiMagicallySee("unit", "Covenant_Banshees", player)
            --hsc.aiMagicallySee("unit", "Covenant_Snipers", player)
        end
    end
end

return eventsManager