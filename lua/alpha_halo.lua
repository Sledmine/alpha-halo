local balltze = Balltze
local engine = Engine
require "luna"

local main
local loadWhenIn = {"alpha_halo"}

local function isMultiplayerMap(mapName)
    for _, map in pairs(loadWhenIn) do
        if mapName == map or mapName == map .. "_dev" then
            return true
        end
    end
    return false
end

function PluginMetadata()
    return {
        name = "Alpha Halo Firefight",
        author = "El Dream Team",
        version = "1.0.0",
        targetApi = "1.0.0-rc.1",
        reloadable = true
    }
end

function PluginInit()
    logger = balltze.logger.createLogger("Alpha Halo")
    logger:muteIngame(false)

    -- Replace Chimera functions with Balltze functions
    execute_script = engine.hsc.executeScript
    write_bit = function(address, bit, value)
        local byte = read_byte(address)
        if value then
            byte = byte | (1 << bit)
        else
            byte = byte & ~(1 << bit)
        end
        write_byte(address, byte)
    end
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

    -- Imitate map lifecycle for scripts as in Chimera
    -- TODO Replace this when Balltze allows per map plugin load
    balltze.event.mapLoad.subscribe(function(event)
        if event.time == "after" then
            local currentMap = event.context:mapName()
            if isMultiplayerMap(currentMap) then
                logger:debug("Map loaded: {}", currentMap)
                if not main then
                    logger:info("loading main")
                    main = require "alpha_halo.main"
                end
            else
                if main then
                    main.unload()
                    package.loaded["alpha_halo.main"] = nil
                    for k, v in pairs(package.loaded) do
                        if k:startswith "alpha_halo" then
                            package.loaded[k] = nil
                        end
                    end
                    main = nil
                end
            end
        end
    end)
end

function PluginLoad()
    -- Load Chimera compatibility
    for k, v in pairs(balltze.chimera) do
        if not k:includes "timer" and not k:includes "execute_script"  and not k:includes "set_callback" then
            _G[k] = v
        end
    end

    if isMultiplayerMap(engine.map.getCurrentMapHeader().name) then
        if not main then
            main = require "alpha_halo.main"
        end
    end
end

function PluginUnload()
end
