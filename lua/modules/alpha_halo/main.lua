local balltze = Balltze
local engine = Engine
local script = require "script"
math.randomseed(os.time())

--Project modules
local firefightManager = require "alpha_halo.systems.firefightManager"
local eventsManager = require "alpha_halo.systems.firefight.eventsManager"
local healthManager = require "alpha_halo.systems.combat.healthManager"
local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local vehiclePosition = require "alpha_halo.systems.core.vehiclePosition"

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

-- Encapsular Funcion
function OnMapLoad()
    firefightManager.whenMapLoads()
    logger:debug("Firefight Manager Loaded")
end

local isLoaded = false
function OnTick()
    firefightManager.eachTick()
    healthManager.eachTick()
    eventsManager.eachTick()
    skullsManager.eachTick()
    vehiclePosition.positionUpdater()
    script.poll()
    -- Execute the function one time
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