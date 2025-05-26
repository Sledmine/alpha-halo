local eventsManager = {}
local hscLegacy = require "hscLegacy"
local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local objectTypes = Engine.tag.objectType

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
        hsc.ai_place("Covenant_Banshees")
        hsc.object_create_anew("banshee_1")
        hsc.object_create_anew("banshee_2")
        hscLegacy.vehicleLoadMagic("banshee_1", "B-driver", "Covenant_Banshees/banshee_a")
        hscLegacy.vehicleLoadMagic("banshee_2", "B-driver", "Covenant_Banshees/banshee_b")
        --hsc.vehicle_load_magic("banshee_1", "B-driver", "Covenant_Banshees/banshee_b")
        --hsc.vehicle_load_magic("banshee_2", "B-driver", "Covenant_Banshees/banshee_b")
        hsc.object_teleport("banshee_1", "Banshee_1")
        hsc.object_teleport("banshee_2", "Banshee_2")
    else
        eventsManager.randomEventGenerator()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covenant Sniper.
function eventsManager.sniperEvent()
    if snipersLivingCount == 0 then
        logger:debug("Sniper event!")
        hsc.ai_place("Covenant_Snipers")
    else
        eventsManager.randomEventGenerator()
    end
end

-- Esta función es llamada desde el randomEventGenerator. Se encarga del evento Covenant Mortar.
-- Por ahora, esto no se está llamando, dado que el Mortero no dispara en lo absoluto.
--function eventsManager.mortarEvent()
--    if mortarLivingCount == 0 then
--        logger:debug("Mortar event!")
--        hsc.ai_place(1, "Covenant_Mortars")
--        hscLegacy.vehicleLoadMagic("mortar_1", "W-gunner", "Covenant_Mortars/mortar_a")
--        hscLegacy.vehicleLoadMagic("mortar_2", "W-gunner", "Covenant_Mortars/mortar_b")
--    else
--        eventsManager.randomEventGenerator()
--    end
--end

-- Esta función es llamada cada tick, desde el eachTick. Se encarga de revisar el estado de los squads.
local magicalSightCounter = 300
local magicalSightTimer = 0
function eventsManager.aiCheck()
    bansheeLivingCount = hscLegacy.aiLivingCount("Covenant_Banshees", "banshees_living_count")
    -- hsc.ai_living_count("Covenant_Banshees")
    snipersLivingCount = hscLegacy.aiLivingCount("Covenant_Snipers", "snipers_living_count")
    -- hsc.ai_living_count("Covenant_Snipers")
    --hsc.ai_follow_target_players("Covenant_Snipers")
    --hsc.ai_magically_see_encounter("Human_Team", "Covenant_Banshees")
    --hsc.ai_magically_see_encounter("Human_Team", "Covenant_Snipers")
    if magicalSightTimer > 0 then
        magicalSightTimer = magicalSightTimer - 1
    else
        magicalSightTimer = magicalSightCounter
        eventsManager.AiSight()
    end
end

local player
local biped
local blamBiped
-- Each 10 seconds, AI will magically see each player if they exist and are not invisible.
function eventsManager.AiSight()
    player = getPlayer()
    if not player then
        return
    end
    biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    blamBiped = blam.biped(get_object(player.objectHandle.value))
    assert(blamBiped, "Biped tag must exist")
    if player then
        if blamBiped.isCamoActive == false then  -- attempt to concatenate a table value (local 'targetObj')
            --hsc.ai_magically_see_players("Covenant_Banshees")
            --hsc.ai_magically_see_players("Covenant_Snipers")
        end
    end
end

return eventsManager