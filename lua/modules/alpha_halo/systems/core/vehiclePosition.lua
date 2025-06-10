local balltze = Balltze
local engine = Engine
local getObject = Engine.gameState.getObject
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local blam = require "blam"
local read_float = balltze.memory.readFloat
local hsc = require "hsc"

local vehiclePosition = {}

-- THIS IS PROBABLY NOT ACCURATE, BUT WORKS
-- TRUST ME, I'M SLED DA FOKIN GOAT
local function getNodePosition(address)
    local x = read_float(address + 0x30)
    local y = read_float(address + 0x34)
    local z = read_float(address + 0x38)
    return {x = x, y = y, z = z}
end

local scenario = engine.tag.getTag(0, engine.tag.classes.scenario)

---@param object MetaEngineBaseObject
---@param x number
---@param y number
---@param z number
local function setObjectPosition(object, x, y, z)
    assert(scenario, "Failed to get vehicle tag")
    local objectName
    for index = 1, scenario.data.objectNames.count do
        local objectNameData = scenario.data.objectNames.elements[index]
        if index == object.nameListIndex + 1 then
            objectName = objectNameData.name
            break
        end
    end
    assert(objectName, "Failed to get object name to set position")
    --logger:debug("{}", objectName)
    for index = 1, scenario.data.cutsceneFlags.count do
        local cutsceneFlag = scenario.data.cutsceneFlags.elements[index]
        if cutsceneFlag.name == "generic_flag" then
            cutsceneFlag.position.x = x
            cutsceneFlag.position.y = y
            cutsceneFlag.position.z = z
            execute_script("object_teleport " .. objectName .. " generic_flag")
            break
        end
    end
end

function vehiclePosition.positionUpdater()
    for vehicleIndex = 0, 4095 do
        local vehicleObject = getObject(vehicleIndex)
        if vehicleObject then
            if vehicleObject.type == objectTypes.vehicle then
                local vehicle = getObject(vehicleIndex, objectTypes.vehicle)
                assert(vehicle, "Failed to get vehicle object")
                local vehicleTag = engine.tag.getTag(vehicleObject.tagHandle.value,
                                                     tagClasses.vehicle)
                assert(vehicleTag, "Failed to get scenery tag")
                if vehicleTag.path:includes("covenant_spirit") then
                    -- Logger:debug("Vehicle tag found: " .. vehicleTag.path)
                    local mainNode = getNodePosition(get_object(vehicleIndex) + 0x5B8)
                    local absoluteNodeX = mainNode.x + (vehicleObject.position.x - mainNode.x)
                    local absoluteNodeY = mainNode.y + (vehicleObject.position.y - mainNode.y)
                    local absoluteNodeZ = mainNode.z + (vehicleObject.position.z - mainNode.z)
                    -- Update the vehicle position
                    setObjectPosition(vehicleObject, mainNode.x, mainNode.y, mainNode.z)
                    vehicleObject.position.x = mainNode.x
                    vehicleObject.position.y = mainNode.y
                    vehicleObject.position.z = mainNode.z
                    vehicle.hover = 1
                    --vehicleTag.data.vehicleFlags:aiDoesNotRequireDriver(true)
                    --vehicleTag.data.vehicleFlags:gunnerPowerWakesPhysics(true)
                    vehicle.vehicleFlags:hovering(true)
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
