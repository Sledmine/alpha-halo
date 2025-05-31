local balltze = Balltze
local engine = Engine
local getObject = Engine.gameState.getObject
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local blam = require "blam"

local vehiclePosition = {}

-- THIS IS PROBABLY NOT ACCURATE, BUT WORKS
-- TRUST ME, I'M SLED DA FOKIN GOAT
local function getNodePosition(address)
    local read_float = balltze.memory.readFloat
    local x = read_float(address + 0x30)
    local y = read_float(address + 0x34)
    local z = read_float(address + 0x38)
    return {x = x, y = y, z = z}
end

function vehiclePosition.positionUpdater()
    for vehicleIndex = 0, 4095 do
        local vehicleObject = getObject(vehicleIndex)
        if vehicleObject then
            if vehicleObject.type == objectTypes.vehicle then
                local vehicle = getObject(vehicleIndex, objectTypes.vehicle)
                assert(vehicle, "Failed to get vehicle object")
                local vehicleTag = engine.tag.getTag(vehicleObject.tagHandle.value, tagClasses.vehicle)
                assert(vehicleTag, "Failed to get scenery tag")
                if vehicleTag.path:includes("covenant_spirit") then
                    -- Logger:debug("Vehicle tag found: " .. vehicleTag.path)
                    local mainNode = getNodePosition(get_object(vehicleIndex) + 0x5B8)
                    local absoluteNodeX = mainNode.x + (vehicleObject.position.x - mainNode.x)
                    local absoluteNodeY = mainNode.y + (vehicleObject.position.y - mainNode.y)
                    local absoluteNodeZ = mainNode.z + (vehicleObject.position.z - mainNode.z)
                    -- Update the vehicle position
                    vehicleObject.position.x = mainNode.x
                    vehicleObject.position.y = mainNode.y
                    vehicleObject.position.z = mainNode.z
                    -- console_out(("x: {x}, y: {y}, z: {z}"):template({
                    --     x = vehicleObject.position.x,
                    --     y = vehicleObject.position.y,
                    --     z = vehicleObject.position.z
                    -- })) -- Logger:debug("Vehicle tag found: " .. vehicleTag.path)
                end
            end
        end
    end
end

return vehiclePosition