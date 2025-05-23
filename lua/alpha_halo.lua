local balltze = Balltze
local engine = Engine
DebugMode = true
package.preload["luna"] = nil
package.loaded["luna"] = nil
require "luna"

local skullsManager = require "alpha_halo.gameplay_core.skullsManager"
-- local firefightManager = require "alpha_halo.firefightManager"

-- local main
local loadWhenIn = {"alpha_halo"}

loadWhenIn = table.extend(loadWhenIn, table.map(loadWhenIn, function(map)
    return map .. "_dev"
end))

function PluginMetadata()
    return {
        name = "Alpha Halo Firefight",
        author = "El Dream Team",
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
    balltze.event.tick.subscribe(function(event)
        if event.time == "before" then
            if not main then
                main = require "alpha_halo.main"
            end
        end
    end)
end

function PluginLoad()
    logger = balltze.logger.createLogger("Alpha Halo") -- this means Alpha Firefight
    logger:muteDebug(not DebugMode)
    logger:muteIngame(not DebugMode)
    loadChimeraCompatibility()

    -- Commands for Alpha Firefight
    balltze.command.registerCommand("silverSkulls", "debug", "description", nil, false, 0, 0, true,
                                    false, function(args)
        skullsManager.silverSkulls()
        return true
    end)

    balltze.command.registerCommand("goldenSkulls", "debug", "description", nil, false, 0, 0, true,
                                    false, function(args)
        skullsManager.goldenSkulls()
        return true
    end)

    balltze.command.registerCommand("resetSilverSkulls", "debug", "description", nil, false, 0, 0,
                                    true, false, function(args)
        skullsManager.resetSilverSkulls()
        return true
    end)

    balltze.command.registerCommand("covenant_team", "debug", "description", nil, false, 0, 0, true,
                                    false, function(args)
        -- firefightManager.debugCovenantTeam()
        return true
    end)

    balltze.command.registerCommand("flood_team", "debug", "description", nil, false, 0, 0, true,
                                    false, function(args)
        -- firefightManager.debugFloodTeam()
        return true
    end)
    return true
end

function PluginUnload()
end