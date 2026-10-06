package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"
local script = require "script"
local hscDoc = require "hscDoc"
local hsc = require "hsc"
local balltze = Balltze
local engine = Engine
local performance
logger = balltze.logger

if DebugMode then
    performance = require "performance"
end

DebugMode = false
DebugLuaMemory = false
DebugPerformance = false
DebugFirefight = false
DebugTimes = {}

-- Override assert function to print traceback as well
local luaAssert = assert
function assert(...)
    local args = {...}
    local condition = args[1]
    local message = args[2]
    if not condition then
        if message then
            logger.error(message)
            local err = debug.traceback(message, 2)
            luaAssert(condition, err)
        else
            local err = debug.traceback("Assertion failed", 2)
            luaAssert(condition, err)
        end
    end
end

local commands = require "alpha_halo.systems.firefight.commands"
local constants = require "alpha_halo.systems.core.constants"

playSound = function(soundTagHandle)
    local soundTag = engine.tag.getTagEntry(soundTagHandle)
    if soundTag and soundTag.path then
        hsc.sound_impulse_start(soundTag.path, "none", 1)
    end
end

function PluginOnGameStart()
    Balltze.addEventListener("tick", function()
        local tickStart
        if DebugPerformance then
            tickStart = os.clock()
        end
        script.poll()
        if DebugPerformance then
            performance.tick(os.clock() - tickStart)
        end
    end)

    --for command, data in pairs(commands) do
    --    balltze.registerCommand(command, data.help, data.description, data.save or false,
    --                            data.minArgs or 0, data.maxArgs or 0, false, true, function(args)
    --        if (args and data.minArgs and data.maxArgs) and (#args < data.minArgs) or
    --            (#args > data.maxArgs) then
    --            logger.error("Invalid number of arguments. Usage: {}, Example: {}", data.help,
    --                         data.example)
    --            return true
    --        end
    --        local ok, message = pcall(data.func, table.unpack(args or {}))
    --        if not ok then
    --            logger.error("Error executing command \"{}\": {}", command, message)
    --        end
    --        return true
    --    end)
    --end
    --balltze.loadSettings()

    constants.get()
    require "alpha_halo.main"
    return true
end

function PluginUnload()
end

function OnError(message)
    print(message)
    print(debug.traceback())
end
