-- This is the pig pen. A module that contains some -real dirty- code, hence the name. Not anymore, thankfully.

-- Module imports
local engine = Engine
local balltze = Balltze
DebugMode = false

local pigPen = {}

---@return table<MetaEngineTagDataScenarioVehicle> @ A table containing all -named- scenario vehicles in the map
function pigPen.getNamedScenarioVehicles()
    local namedScenarioVehicles = {}
    local scenarioTagHandle = engine.tag.getTag(0, engine.tag.classes.scenario) -- Gets the first (and only) .scenario tag from the map
    assert(scenarioTagHandle, "pigPen: Failed to get scenario tag handle.") -- Assert handle is not nil (or false)
    local scenarioVehicles = scenarioTagHandle.data.vehicles
    -- Get count using count field, not through table length operator (#); iterate using this count provided by the engine, not the table length
    local scenarioVehiclesCount = scenarioVehicles.count
    local scenarioVehiclesElements = scenarioVehicles.elements
    --logger:debug(scenarioVehicles.count.." vehicles found in map")
    local scenarioObjectNames = scenarioTagHandle.data.objectNames
    local scenarioObjectNamesElements = scenarioObjectNames.elements
    for i = -1, scenarioVehiclesCount, 1 do
        local scenarioVehicle = scenarioVehiclesElements[i]
        if (scenarioVehicle == nil) then
            --logger:debug("Check #0 failed for vehicle #"..i..", is nil")
            goto continue -- Skip to the next iteration, but do not break the whole thing (goto statements are local to the entire block where they are defined)
        end
        -- Note: this index is collected from the game engine in base zero, but it must be adjusted to base one to fit with Lua base one indeces, otherwise things break
        local scenarioVehicleObjectNameIndex = scenarioVehicle.name + 1
        if (scenarioVehicleObjectNameIndex == nil) then -- Not-nil check
            --logger:debug("Check #1 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
            goto continue -- Skip to the next iteration, but do not break the whole thing (goto statements are local to the entire block where they are defined)
        end
        local scenarioVehicleObjectName = scenarioObjectNamesElements[scenarioVehicleObjectNameIndex]
        -- Unnamed vehicles fall into this check after doing the base zero to base one fix
        if (scenarioVehicleObjectName == nil) then -- Not-nil check
            --logger:debug("Check #2 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
            goto continue -- Skip to the next iteration, but do not break the whole thing
        end
        -- Not confirmed: Unnamed vehicles (or object without an assigned name in the map vehicle list) have a default name composed of a single [END OF TEXT] character, or decimal 3 in  ASCII
        -- if (#scenarioVehicleObjectName.name == 1 and string.byte(scenarioVehicleObjectName.name, 1, 1)) then
        --     logger:debug("Check #3 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
        --     goto continue -- Skip to the next iteration, but do not break the whole thing
        -- end
        table.insert(namedScenarioVehicles, scenarioVehicle)
        -- Print the "name" field only if the object name object is not nil
        --logger:debug("Vehicle #"..i.." is "..scenarioVehicleObjectName.name..", object name index is "..scenarioVehicleObjectNameIndex..", type is "..scenarioVehicle.type)
        -- logger:debug("Table size is: "..#namedScenarioVehicles)
        ::continue::
    end
    return namedScenarioVehicles
end

---@param vehicles table<MetaEngineTagDataScenarioVehicle> @ The table of -named- scenario vehicles collected by pigPen.getNamedScenarioVehicles()
---@param name string @ The object name of the scenario vehicle, as defined in the scenario
---@return MetaEngineTagDataScenarioVehicle|nil @ The scenario vehicle, or nil if not found
function pigPen.getNamedVehicle(vehicles, name)
    local objectNamesElements = engine.tag.getTag(0, engine.tag.classes.scenario).data.objectNames.elements
    for _, value in ipairs(vehicles) do
        ---@type MetaEngineTagDataScenarioVehicle
        local vehicle = value
        local vehicleName = objectNamesElements[vehicle.name + 1].name -- At this point it is guaranteed the vehicle has a valid name
        -- logger:debug("Evaluating named vehicle #"..index..": "..vehicleName)
        if (name == vehicleName) then
            -- logger:debug("Requested named vehicle "..name..", found at index #"..index)
            return vehicle
        end
    end
    -- logger:debug("Failed to find requested named vehicle "..name)
end

---@param scenarioVehicle MetaEngineTagDataScenarioVehicle @ The scenario vehicle
---@return EngineObjectHandle|nil @ The handle of the created vehicle object, or nil on failure
function pigPen.spawnNamedVehicle(scenarioVehicle)
    local vehiclePaletteElements = engine.tag.getTag(0, engine.tag.classes.scenario).data.vehiclePalette.elements
    local vehicleTagHandle = vehiclePaletteElements[scenarioVehicle.type + 1].name.tagHandle -- Sum 1 to vehicle palette index to convert to a Lua index and fetch the correct entry
    -- Casting scenarioVehicle.position to EnginePoint3D from MetaEnginePoint3D didn't do the job, so I had to initialize it manually like this
    ---@type EnginePoint3D
    local scenarioVehiclePosition = {
        x = scenarioVehicle.position.x,
        y = scenarioVehicle.position.y,
        z = scenarioVehicle.position.z
    }
    local vehicleObjectHandle = engine.gameState.createObject(vehicleTagHandle, nil, scenarioVehiclePosition)
    local vehicleObject = engine.gameState.getObject(vehicleObjectHandle, engine.tag.objectType.vehicle)
    -- Set rotation of created object to that of the scenario vehicle, on success only
    if vehicleObject == nil then -- Skip rotation adjustment and jump to return
        return
    end
    -- This step is necessary because objects created with createObject are created with a neutral orientation everytime
    -- The orientation field of MetaEngineBaseObject (and superclasses) stores the X and Z unit vectors of the rotated frame of reference of the object, 
    -- also represented as the first and third rows of a rotation matrix that describes the current rotation of the object:
    -- the two vectors can be used to calculate the Y unit vector by doing a cross-product, and placing it in the (missing) second row of the rotation matrix.
    -- The vehicle is created with a rotation of 0 degrees of every axis:
    -- vector at index 1 is the X axis, and vector at index 2 is the Z axis, that's why we these vectors are initialized as [1, 0, 0] and [0, 0, 1].
    -- 
    -- This thing is somewhat picky and wants everything spoon-fed
    -- To change the orientation field, the values from the vectors of the new orientation table must be copied over to the values of the orientation vectors;
    -- attempting to assign the new orientation table to the orientation field directly fails, even if the types match.
    local newOrientation = pigPen.eulerAnglesToVectors(scenarioVehicle.rotation.pitch, scenarioVehicle.rotation.yaw, scenarioVehicle.rotation.roll)
    for index, value in ipairs(newOrientation) do
        vehicleObject.orientation[index].x = value.x
        vehicleObject.orientation[index].y = value.y
        vehicleObject.orientation[index].z = value.z
    end
    return vehicleObjectHandle
end

-- Compact, self-contained alternative to pigPen.spawnNamedVehicle, though more resource intensive
---@param name string @ The object name of the scenario vehicle, as defined in the scenario
---@return EngineObjectHandle|nil @ The object handle of the created vehicle, or nil on failure
function pigPen.compactSpawnNamedVehicle(name)
    local namedScenarioVehicles = pigPen.getNamedScenarioVehicles()
    local scenarioVehicle = pigPen.getNamedVehicle(namedScenarioVehicles, name)
    if (scenarioVehicle == nil) then
        logger:error("Failed to spawn named vehicle: "..name)
        return
    end
    -- Call the vanilla spawnNamedVehicle function rather than reinvent the wheel
    local vehicleObjectHandle = pigPen.spawnNamedVehicle(scenarioVehicle)
    return vehicleObjectHandle
end

-- Just a debug function. Pass a table only, ignore the second argument.
---@param theTable table @ The table to be printed
---@param thePadding string @ Do not pass this argument! It is used by recursive calls to print nested tables adequately
function pigPen.recursivePrintTable(theTable, thePadding)
    local padding = thePadding
    if not padding or type(thePadding) ~= "string" then
        padding = ""
    else
        padding = thePadding.."- "
    end
    for key, value in pairs(theTable) do
        if type(value) == "table" then
            logger:info(padding..key.." = {")
            pigPen.recursivePrintTable(value, padding)
            logger:info(padding.."}")
        else
            logger:info(padding..key.." = "..value)
        end
    end
end

-- Inspired from lua-blam's eulerAnglesToVectors function, albeit with some changes
---@param pitchRadians number @ Pitch, in radians
---@param yawRadians number @ Yaw, in radians
---@param rollRadians number @ Roll, in radians
---@return table<integer, MetaEnginePoint3D> @ The table of X and Z unit vectors
function pigPen.eulerAnglesToVectors(pitchRadians, yawRadians, rollRadians)
    local pitch = -pitchRadians -- Negative pitch due to Sapien handling anticlockwise pitch
    local yaw = yawRadians
    local roll = rollRadians
    local matrix = {
        {1, 0, 0},
        {0, 1, 0},
        {0, 0, 1}
    }
    -- TODO: rename these to match the Euler angle greek literals, for consistency
    local cosPitch = math.cos(pitch)
    local sinPitch = math.sin(pitch)
    local cosYaw = math.cos(yaw)
    local sinYaw = math.sin(yaw)
    local cosRoll = math.cos(roll)
    local sinRoll = math.sin(roll)
    matrix[1][1] = cosPitch * cosYaw
    matrix[1][2] = -cosPitch * sinYaw
    matrix[1][3] = sinPitch
    matrix[2][1] = cosRoll * sinYaw + sinRoll * sinPitch * cosYaw
    matrix[2][2] = cosRoll * cosYaw - sinRoll * sinPitch * sinYaw
    matrix[2][3] = -sinRoll * cosPitch
    matrix[3][1] = sinRoll * sinYaw - cosRoll * sinPitch * cosYaw
    matrix[3][2] = sinRoll * cosYaw + cosRoll * sinPitch * sinYaw
    matrix[3][3] = cosRoll * cosPitch
    -- Cast types to match the types of MetaEngineBaseObject (and superclasses) "orientation" field
    ---@type MetaEnginePoint3D
    local v1 = {x = matrix[1][1], y = matrix[2][1], z = matrix[3][1]}
    ---@type MetaEnginePoint3D
    local v2 = {x = matrix[1][3], y = matrix[2][3], z = matrix[3][3]}
    return {v1, v2}
end

return pigPen