local blam = require "blam"
local test = require "alpha_halo.test"
local waveManager = require "alpha_halo.gameplay_core.waveManager"
--local healthRegen = require "alpha_halo.gameplay_core.healthRegen"
local healthRegenSP = require "alpha_halo.gameplay_core.healthRegenSP"
local healthRegenAlly = require "alpha_halo.gameplay_core.healthRegenAlly"
require "luna"

local isLoaded = false
clua_version = 2.056

function OnMapLoad()
    waveManager.GameStart()
end

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

function OnTick()
    if not isLoaded then
        OnMapLoad()
        isLoaded = true
        return
    end

    --waveManager.WaveManager()
    healthRegenAlly.regenerateHealth()
    healthRegenSP.regenerateHealth()

    for objectHandle in pairs(blam.getObjects()) do
        local object = blam.getObject(objectHandle)
        if object and object.class == blam.objectClasses.vehicle then
            local objectTag = blam.getTag(object.tagId)
            if objectTag then
                --if objectTag.path:includes("ghost") then
                if objectTag.path:includes("covenant_spirit") then
                    local vehicle = blam.vehicle(get_object(objectHandle))
                    if vehicle then
                        local mainNode = getNodePosition(get_object(objectHandle) + 0x5B8)
                        local absoluteNodeX = mainNode.x + (vehicle.x - mainNode.x)
                        local absoluteNodeY = mainNode.y + (vehicle.y - mainNode.y)
                        local absoluteNodeZ = mainNode.z + (vehicle.z - mainNode.z)
                        vehicle.x = mainNode.x
                        vehicle.y = mainNode.y
                        vehicle.z = mainNode.z
                        vehicle.isActive = true
                        vehicle.isHovering = true
                        --vehicle.isCurrentlyControllable = true
                        --vehicle.isControllable = true
                        --vehicle.isSuspended = true
                        vehicle.hover = 1
                        --vehicle.clusterId = blam.object(get_dynamic_player()).clusterId
                    end
                end
            end
        end
    end
end

--OnMapLoad()
--set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")