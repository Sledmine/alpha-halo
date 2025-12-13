local balltze = Balltze
local engine = Engine
DebugMode = false
DebugLuaMemory = false
DebugPerformance = false
DebugFirefight = false
DebugTimes = {}
package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"

-- Pre require structures for blam2
-- This helps the bundler to include modules properly
require "structures.actorVariant"
require "structures.projectile"
require "structures.weapon"

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

local main

function PluginFirstTick()
    local onTick
    onTick = balltze.event.tick.subscribe(function(event)
        if event.time == "before" then
            logger:debug("First Tick Event")
            if not main then
                constants.get()
                main = require "alpha_halo.main"
                onTick:remove()
            end
        end
    end)
end

function PluginLoad()
    logger = balltze.logger.createLogger("Alpha Halo")
    logger:muteDebug(not DebugMode)
    -- logger:muteIngame(not DebugMode)
    ---@diagnostic disable-next-line: inject-field
    logger.warn = logger.warning -- alias warning to warn
    loadChimeraCompatibility()
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

    -- Commands for Alpha Firefight
    for command, data in pairs(commands) do
        -- local command = command:replace("debug_", "")
        balltze.command.registerCommand(command, command, data.description, data.help,
                                        data.save or false, data.minArgs or 0, data.maxArgs or 0,
                                        false, true, function(args)
            -- logger:debug("{}", inspect(args))
            if (args and data.minArgs and data.maxArgs) and (#args < data.minArgs) or
                (#args > data.maxArgs) then
                logger:error("Invalid number of arguments. Usage: {}, Example: {}", data.help,
                             data.example)
                return true
            end
            data.func(table.unpack(args or {}))
            return true
        end)
    end
    balltze.command.loadSettings()

    return true
end

function PluginUnload()
end
