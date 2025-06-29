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

-- Encapsular Funcion
function OnMapLoad()
    --script.startup(ffManager.whenMapLoads)
    script.startup(firefightManager.whenMapLoads)
    --logger:debug("Firefight Manager Loaded")
end

local isLoaded = false
function OnTick()
    firefightManager.eachTick()
    --healthManager.eachTick()
    --eventsManager.eachTick()
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