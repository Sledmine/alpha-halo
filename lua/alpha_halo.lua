package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"
require "balltzeCompat"
local blam = require "blam"
local script = require "script"
local hscDoc = require "hscDoc"
local hsc = require "hsc"
local balltze = Balltze
local engine = Engine
local concat = table.concat
local tagClasses = blam.tagClasses
local objectClasses = blam.objectClasses
local performance

if DebugMode then
    performance = require "performance"
end

-- Pre require structures for blam2
-- This helps the bundler to include modules properly
assert(require "structures.tag.actorVariant")
assert(require "structures.tag.projectile")
assert(require "structures.tag.weapon")
assert(require "structures.tag.scenario")

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
            logger:error(message)
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

-- local main
local loadWhenIn = {"alpha_halo"}

loadWhenIn = table.extend(loadWhenIn, table.map(loadWhenIn, function(map)
    return map .. "_dev"
end))

function PluginMetadata()
    return {
        name = "Alpha Halo",
        author = "Insurrection Team",
        version = "1.0.0",
        targetApi = "1.0.0",
        reloadable = true,
        maps = loadWhenIn
    }
end

function PluginFirstTick()
    constants.get()
    require "alpha_halo.main"
end

function PluginLoad()
    logger = balltze.logger.createLogger("Alpha Halo")
    logger:muteDebug(not DebugMode)
    -- logger:muteIngame(not DebugMode)
    ---@diagnostic disable-next-line: inject-field
    logger.warn = logger.warning -- alias warning to warn
    local isSapp = engine.netgame.getServerType() == "sapp"

    if not isSapp then
        require "chimeraCompat"()
    end

    balltze.event.tick.subscribe(function(event)
        if event.time == "before" then
            local tickStart
            if DebugPerformance then
                tickStart = os.clock()
            end
            script.poll()
            if DebugPerformance then
                performance.tick(os.clock() - tickStart)
            end
        end
    end)

    if not isSapp then
        -- Commands for Alpha Firefight
        for command, data in pairs(commands) do
            -- local command = command:replace("debug_", "")
            balltze.command.registerCommand(command, command, data.description, data.help,
                                            data.save or false, data.minArgs or 0,
                                            data.maxArgs or 0, false, true, function(args)
                -- logger:debug("{}", inspect(args))
                if (args and data.minArgs and data.maxArgs) and (#args < data.minArgs) or
                    (#args > data.maxArgs) then
                    logger:error("Invalid number of arguments. Usage: {}, Example: {}", data.help,
                                 data.example)
                    return true
                end
                -- data.func(table.unpack(args or {}))
                local ok, message = pcall(data.func, table.unpack(args or {}))
                if not ok then
                    logger:error("Error executing command \"{}\": {}", command, message)
                end
                return true
            end)
        end
        balltze.command.loadSettings()
    end

    if isSapp then
        -- Register all SAPP callbacks now that all subscribers are in place
        balltze.event.registerSappCallbacks()

        blam.rcon.patch()
    end

    return true
end

function PluginUnload()
    if engine.netgame.getServerType() == "sapp" then
        blam.rcon.unpatch()
    end
end

function OnError(message)
    print(message)
    print(debug.traceback())
end
