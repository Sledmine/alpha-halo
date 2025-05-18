local balltze = Balltze
local engine = Engine
local dispatchScripts = require "script".dispatch
math.randomseed(os.time())

-- logger = balltze.logger.createLogger("Alpha Halo")

--Project modules
local firefightManager = require "alpha_halo.firefightManager"
local healthManager = require "alpha_halo.gameplay_core.healthManager"
local eventsManager = require "alpha_halo.gameplay_core.eventsManager"
local vehiclePositionLoader = require "alpha_halo.core"
local skullsManager = require "alpha_halo.gameplay_core.skullsManager"
--local pigPen = require "alpha_halo.pigPen" -- This module contains the functions to spawn named vehicles dynamically

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
    skullsManager.whenMapLoads()
    -- TESTING
    logger:muteDebug(not DebugMode) -- Mutes debug messages when DebugMode variable is false.
    -- local nestedTable = {
    --     1,
    --     "asd",
    --     {
    --         3.1,
    --         "tres",
    --         {
    --             "triples",
    --             4.21
    --         }
    --     },
    --     5,
    --     "dsa"
    -- }
    -- pigPen.recursivePrintTable(nestedTable)
    --local testerHog = pigPen.compactSpawnNamedVehicle("tester") -- Spawn tester hog
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