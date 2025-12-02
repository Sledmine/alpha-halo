local eventsManager = {}
local hsc = require "hsc"
local utils = require "alpha_halo.utils"
local engine = Engine
local balltze = Balltze
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local objectTypes = Engine.tag.objectType
local script = require "script"
local sleep = script.sleep

local announcer = require "alpha_halo.systems.combat.announcer"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"

function eventsManager.eachTick()
    eventsManager.aiCheck()
end

eventsManager.deployerSettings = {randomEventFrequency = 4200}
local settings = eventsManager.deployerSettings

local bansheeLivingCount
local snipersLivingCount
local sentinelsLivingCount
-- local mortarLivingCount
local randomEventTimer = settings.randomEventFrequency
local randomEventCountdown = randomEventTimer

function eventsManager.randomEventTimerThread()
    -- TODO Use sleep until to wait for all ai to be dead before starting the event timer
    sleep(utils.minutesToTicks(2.5))
    local difficulty = hsc.game_difficulty_get()
    -- An event can not spawn if there are enemies alive from previous events
    local isEventReadyToSpawn = bansheeLivingCount == 0 and snipersLivingCount == 0 and
    sentinelsLivingCount == 0
    -- Decide if event should spawn based on enemy living counts and difficulty
    if difficulty == "impossible" then
        -- On higher difficulties, events can spawn at the same time as others
        isEventReadyToSpawn = bansheeLivingCount == 0 or snipersLivingCount == 0 or
                                  sentinelsLivingCount == 0
    end
    if isEventReadyToSpawn then
        eventsManager.spawnEncounterEvent()
    end
end

function eventsManager.spawnEncounterEvent()
    local encounterEvents = {
        eventsManager.bansheeEvent,
        eventsManager.sniperEvent,
        eventsManager.sentinelEvent
    }
    local selectedEvent = math.random(1, #encounterEvents)
    encounterEvents[selectedEvent]()
end

function eventsManager.bansheeEvent()
    if bansheeLivingCount == 0 then
        script.startup(announcer.enemyIncoming)
        logger:debug("Banshee event!")
        hsc.ai_place("Covenant_Banshees")
        hsc.object_create_anew("banshee_1")
        hsc.object_create_anew("banshee_2")
        hsc.vehicle_load_magic("banshee_1", "B-driver", hsc.ai_actors("Covenant_Banshees/banshee_a"))
        hsc.vehicle_load_magic("banshee_2", "B-driver", hsc.ai_actors("Covenant_Banshees/banshee_b"))
        hsc.object_teleport("banshee_1", "Banshee_1")
        hsc.object_teleport("banshee_2", "Banshee_2")
        -- They get to see the players one tick after being created.
        hsc.ai_magically_see_players("Covenant_Banshees")
    end
end

function eventsManager.sniperEvent()
    if snipersLivingCount == 0 then
        script.startup(announcer.enemySniper)
        logger:debug("Sniper event!")
        hsc.ai_place("Covenant_Snipers")
        -- They get to see the players one tick after being created.
        hsc.ai_magically_see_players("Covenant_Snipers")
    end
end

function eventsManager.sentinelEvent()
    if sentinelsLivingCount == 0 then
        script.startup(announcer.enemyIncoming)
        logger:debug("Sentinel event!")
        hsc.ai_place("Sentinel_Team/Sentinels_1")
        -- They get to see the players one tick after being created
        hsc.ai_magically_see_players("Sentinel_Team/Sentinels_1")
        for _, badGuy in pairs(unitDeployer.badGuys) do
            hsc.ai_magically_see_encounter("Sentinel_Team/Sentinels_1", badGuy)
            hsc.ai_try_to_fight("Sentinel_Team/Sentinels_1", badGuy)
        end
    end
end

-- function eventsManager.mortarEvent()
--    if mortarLivingCount == 0 then
--        logger:debug("Mortar event!")
--        hsc.ai_place(1, "Covenant_Mortars")
--        hsc.vehicle_load_magic("mortar_1", "W-gunner", "(ai_actors Covenant_Mortars/mortar_b)")
--        hsc.vehicle_load_magic("mortar_2", "W-gunner", "(ai_actors Covenant_Mortars/mortar_b)")
--    end
-- end

function eventsManager.aiCheck()
    bansheeLivingCount = hsc.ai_living_count("Covenant_Banshees")
    snipersLivingCount = hsc.ai_living_count("Covenant_Snipers")
    sentinelsLivingCount = hsc.ai_living_count("Sentinel_Team")
end

return eventsManager
