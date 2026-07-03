package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"
require "balltzeCompat"
local blam = require "blam"
local script = require "script"
local balltze = Balltze
local engine = Engine

-- Pre require structures for blam2
-- This helps the bundler to include modules properly
require "structures.tag.actorVariant"
require "structures.tag.projectile"
require "structures.tag.weapon"

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

local function loadChimeraCompatibility()
    -- Load Chimera compatibility
    for k, v in pairs(balltze.chimera) do
        if not k:includes "timer" and not k:includes "execute_script" and
            not k:includes "set_callback" then
            _G[k] = v
        end
    end
    server_type = engine.netgame.getServerType()

    -- Replace Chimera functions with Balltze functions
    write_bit = balltze.memory.writeBit
    write_byte = balltze.memory.writeInt8
    write_word = balltze.memory.writeInt16
    write_dword = balltze.memory.writeInt32
    write_int = balltze.memory.writeInt32
    write_float = balltze.memory.writeFloat
    write_string = function(address, value)
        for i = 1, #value do
            write_byte(address + i - 1, string.byte(value, i))
        end
        if #value == 0 then
            write_byte(address, 0)
        end
    end
    execute_script = engine.hsc.executeScript
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
        loadChimeraCompatibility()
    end

    Balltze.event.frame.subscribe(function(event)
        if event.time == "before" then
            local font = "smaller"
            local align = "center"
            if DebugMode and DebugLuaMemory then
                local bounds = {left = 0, top = 400, right = 640, bottom = 480}
                local textColor = {1.0, 0.45, 0.72, 1.0}
                local memory = collectgarbage("count")
                local sizeInMb = memory / 1024
                local text = string.format("Alpha Halo Lua %.4f MB", sizeInMb)
                Balltze.chimera.draw_text(text, bounds.left, bounds.top, bounds.right,
                                          bounds.bottom, font, align, table.unpack(textColor))
            end
        end
    end)

    local onTickEvent = balltze.event.tick.subscribe(function(event)
        if event.time == "before" then
            local startTime
            if DebugPerformance then
                startTime = os.clock()
            end
            script.poll()
            if DebugPerformance then
                local endTime = os.clock()
                local elapsedTime = endTime - startTime
                DebugTimes.tickTime = elapsedTime
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
