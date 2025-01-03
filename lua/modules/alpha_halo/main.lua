local balltze = Balltze
local engine = Engine
DebugMode = false
local dispatchScripts = require "script".dispatch
math.randomseed(os.time())

-- logger = balltze.logger.createLogger("Alpha Halo")

--Project modules
local firefightManager = require "alpha_halo.firefightManager"
local healthManager = require "alpha_halo.gameplay_core.healthManager"
local eventsManager = require "alpha_halo.gameplay_core.eventsManager"
local vehiclePositionLoader = require "alpha_halo.core"
--local skullsManager = require "alpha_halo.gameplay_core.skullsManager"
local pigPen = require "alpha_halo.pigPen" -- This module contains the functions to spawn named vehicles dynamically

-- THIS IS PROBABLY NOT ACCURATE, BUT WORKS
-- TRUST ME, I'M SLED DA FOKIN GOAT
function getNodePosition(address)
    --x = read_float(address + 0x28)
    --y = read_float(address + 0x2C)
    x = read_float(address + 0x30)
    y = read_float(address + 0x34)
    z = read_float(address + 0x38)
    return {x = x, y = y, z = z}
end

function OnMapLoad()
    firefightManager.whenMapLoads()
    healthManager.whenMapLoads()
    eventsManager.whenMapLoads()
    -- TESTING
    logger:muteDebug(true) -- Mutes debug messages
    pigPen.test()
    local namedScenarioVehicles = pigPen.getNamedScenarioVehicles()
    local testerHog = pigPen.getNamedVehicle(namedScenarioVehicles, "tester")
    if (testerHog ~= nil) then
        local testerHogObject = pigPen.spawnNamedVehicle(testerHog)
        logger:debug("SPAWNED THE TESTER HOG!")
    end
    local testerHog2 = pigPen.compactSpawnNamedVehicle("tester")
    logger:debug("SPAWNED THE TESTER HOG! AGAIN! USING COMPACT FUNCTION!")
    -- END OF TESTING
end

local isLoaded = false

function OnTick()
    firefightManager.eachTick()
    healthManager.eachTick()
    eventsManager.eachTick()
    vehiclePositionLoader.vehiclePositionLoader()
    math.randomseed(engine.core.getTickCount())
    dispatchScripts()
    if not isLoaded then
        isLoaded = true
        OnMapLoad()
        return
    end
end

local onTickEvent = balltze.event.tick.subscribe(function(event)
    if event.time == "before" then
        OnTick()
    end
end)

return {
    unload = function()
        logger:debug("Unloading main")
        onTickEvent:remove()
    end
}