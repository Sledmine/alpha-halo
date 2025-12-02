local balltze = Balltze
local engine = Engine
local script = require "script"
inspect = require "inspect"
math.randomseed(os.time())
local luaAssert = assert
function assert(...)
    local args = {...}
    local condition = args[1]
    local message = args[2]
    if not condition then
        if message then
            local err = debug.traceback(message, 2)
            luaAssert(condition, err)
        else
            local err = debug.traceback("Assertion failed", 2)
            luaAssert(condition, err)
        end
    end
end

-- Project modules
local firefightManager = require "alpha_halo.systems.firefightManager"
local eventsManager = require "alpha_halo.systems.firefight.eventsManager"
local healthManager = require "alpha_halo.systems.combat.healthManager"
local skullsManager = require "alpha_halo.systems.gameplay.skullsManager"
local vehiclePosition = require "alpha_halo.systems.core.vehiclePosition"
local extendedHud = require "alpha_halo.systems.interface.extendedHud"
-- local extendedWeapon = require "alpha_halo.systems.weapons.extendedWeapon"

-- Encapsular Funcion
function OnMapLoad()
    firefightManager.stopMusic()
    if not DebugMode then
        script.startup(firefightManager.whenMapLoads)
        script.continuous(eventsManager.randomEventTimerThread)
    end
end

local isLoaded = false
function OnTick()
    firefightManager.eachTick()
    healthManager.eachTick()
    skullsManager.eachTick()
    vehiclePosition.positionUpdater()
    extendedHud.hideMetersOnZoom()
    -- extendedWeapon.noZoomWhenOverheating()
    script.poll()
    if not DebugMode then
        if firefightManager.gameProgression.isGameOn then
            eventsManager.eachTick()
        end
    end
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

Balltze.event.frame.subscribe(function(event)
    if event.time == "before" then
        if console_is_open() then
            return
        end

        local rootWidget = engine.userInterface.getRootWidget()
        local isPlayerOnMenu = rootWidget ~= nil
        if isPlayerOnMenu then
            return
        end
        local player = get_dynamic_player()
        if not player then
            return
        end
        firefightManager.onEachFrame()
    end
end)

return {
    unload = function()
        logger:debug("Unloading main")
        onTickEvent:remove()
    end
}
