local balltze = Balltze
local engine = Engine
local script = require "script"
local sleep = script.sleep
inspect = require "inspect"
math.randomseed(os.time())
local luaAssert = assert
function assert(...)
    local args = {...}
    local condition = args[1]
    local message = args[2]
    if not condition then
        if message then
            logger:error(message)
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
    logger:debug("Map Loaded")
    firefightManager.stopMusic()
    if not DebugFirefight then
        script.startup(firefightManager.whenMapLoads)
        script.continuous(eventsManager.randomEventTimerThread)
    end

    script.continuous(function ()
        firefightManager.scriptVehicleDestroyer()
        extendedHud.hideMetersOnZoom()

        -- Sleep to reduce CPU usage
        sleep(1)
    end)

    script.continuous(function()
        firefightManager.eachTick()
        healthManager.eachTick()
        skullsManager.eachTick()
        vehiclePosition.positionUpdater()
        -- extendedWeapon.noZoomWhenOverheating()
        if not DebugFirefight then
            if firefightManager.gameProgression.isGameOn then
                eventsManager.eachTick()
            end
        end

        -- Add a small sleep to reduce CPU usage
        sleep(3)
    end)
end

local isLoaded = false
function OnTick()
    -- Execute the function one time
    if not isLoaded then
        isLoaded = true
        OnMapLoad()
        return
    end

    script.poll()
end

local onTickEvent = balltze.event.tick.subscribe(function(event)
    if event.time == "before" then
        local startTime
        if DebugPerformance then
            startTime = os.clock()
        end
        OnTick()
        if DebugPerformance then
            local endTime = os.clock()
            local elapsedTime = endTime - startTime
            DebugTimes.tickTime = elapsedTime
        end
    end
end)

local align = "left"
local bounds = {left = 15, top = 300, right = 640, bottom = 480}
local whiteTextColor = {1.0, 1.0, 1.0, 1.0}

Balltze.event.frame.subscribe(function(event)
    if event.time == "before" then
        local drawText = balltze.chimera.draw_text
        local startTime
        if DebugPerformance then
            startTime = os.clock()
        end
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
        if DebugPerformance then
            local endTime = os.clock()
            local elapsedTime = endTime - startTime
            DebugTimes.frameTime = elapsedTime

            drawText(string.format("Tick Time: %.6f s\nFrame Time: %.6f s",
                                   DebugTimes.tickTime or 0, DebugTimes.frameTime or 0),
                     bounds.left, bounds.top, bounds.right, bounds.bottom, "smaller", align,
                     table.unpack(whiteTextColor))
        end

    end
end)

return {
    unload = function()
        logger:debug("Unloading main")
        onTickEvent:remove()
    end
}
