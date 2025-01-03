-- This is the pig pen. A module that contains some -real dirty- code, hence the name. (Not anymore, thankfully).
-- TODO: add annotations to all of this, where missing

-- Module imports
local engine = Engine
local balltze = Balltze

local pigPen = {}

function pigPen.test()
    console_out("Pig pen test. Oiiiiiink, wheeeeeek, wheeeeeek.")
end

function pigPen.getNamedScenarioVehicles()
    local namedScenarioVehicles = {}
    local scenarioTagHandle = engine.tag.getTag(0, engine.tag.classes.scenario) -- Gets the first (and only) .scenario tag from the map
    assert(scenarioTagHandle, "pigPen: Failed to get scenario tag handle.") -- Assert handle is not nil (or false)
    local scenarioVehicles = scenarioTagHandle.data.vehicles
    -- Get count using count field, not through table length operator (#); iterate using this count provided by the engine, not the table length
    local scenarioVehiclesCount = scenarioVehicles.count
    local scenarioVehiclesElements = scenarioVehicles.elements
    logger:debug(scenarioVehicles.count.." vehicles found in map")
    local scenarioObjectNames = scenarioTagHandle.data.objectNames
    local scenarioObjectNamesElements = scenarioObjectNames.elements
    for i = -1, scenarioVehiclesCount, 1 do
        local scenarioVehicle = scenarioVehiclesElements[i]
        if (scenarioVehicle == nil) then
            logger:debug("Check #0 failed for vehicle #"..i..", is nil")
            goto continue -- Skip to the next iteration, but do not break the whole thing (goto statements are local to the entire block where they are defined)
        end
        -- Note: this index is collected from the game engine in base zero, but it must be adjusted to base one to fit with Lua base one indeces, otherwise things break
        local scenarioVehicleObjectNameIndex = scenarioVehicle.name + 1
        if (scenarioVehicleObjectNameIndex == nil) then -- Not-nil check
            logger:debug("Check #1 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
            goto continue -- Skip to the next iteration, but do not break the whole thing (goto statements are local to the entire block where they are defined)
        end
        local scenarioVehicleObjectName = scenarioObjectNamesElements[scenarioVehicleObjectNameIndex]
        -- Unnamed vehicles fall into this check after doing the base zero to base one fix
        if (scenarioVehicleObjectName == nil) then -- Not-nil check
            logger:debug("Check #2 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
            goto continue -- Skip to the next iteration, but do not break the whole thing
        end
        -- Not confirmed: Unnamed vehicles (or object without an assigned name in the map vehicle list) have a default name composed of a single [END OF TEXT] character, or decimal 3 in  ASCII
        -- if (#scenarioVehicleObjectName.name == 1 and string.byte(scenarioVehicleObjectName.name, 1, 1)) then
        --     logger:debug("Check #3 failed for vehicle #"..i.." of type "..scenarioVehicle.type)
        --     goto continue -- Skip to the next iteration, but do not break the whole thing
        -- end
        table.insert(namedScenarioVehicles, scenarioVehicle)
        -- Print the "name" field only if the object name object is not nil
        logger:debug("Vehicle #"..i.." is "..scenarioVehicleObjectName.name..", object name index is "..scenarioVehicleObjectNameIndex..", type is "..scenarioVehicle.type)
        -- logger:debug("Table size is: "..#namedScenarioVehicles)
        ::continue::
    end
    return namedScenarioVehicles
end

---@param vehicles table<MetaEngineTagDataScenarioVehicle> @ The table of scenario vehicles collected by pigPen.getNamedScenarioVehicles()
---@param name string @ The object name of the scenario vehicle, as defined in the scenario
---@return MetaEngineTagDataScenarioVehicle | nil @ The scenario vehicle, or nil if not found
function pigPen.getNamedVehicle(vehicles, name)
    local objectNamesElements = engine.tag.getTag(0, engine.tag.classes.scenario).data.objectNames.elements
    for index, value in ipairs(vehicles) do
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

-- TODO: this should set the rotation of the vehicle, manually, after spawning it
---@param scenarioVehicle MetaEngineTagDataScenarioVehicle @ The scenario vehicle
---@return EngineObjectHandle @ The handle of the created vehicle object
function pigPen.spawnNamedVehicle(scenarioVehicle)
    local vehiclePaletteElements = engine.tag.getTag(0, engine.tag.classes.scenario).data.vehiclePalette.elements
    local vehicleTagHandle = vehiclePaletteElements[scenarioVehicle.type + 1].name.tagHandle -- Sum 1 to vehicle palette index to convert to a Lua index and fetch the correct entry
    -- Casting vehiclePosition to EnginePoint3D from MetaEnginePoint3D didn't do the job, so I had to initialize it manually
    -- local vehiclePosition = scenarioVehicle.position
    -- logger:debug("x = "..scenarioVehicle.position.x)
    -- logger:debug("y = "..scenarioVehicle.position.y)
    -- logger:debug("z = "..scenarioVehicle.position.z)
    ---@type EnginePoint3D
    local patchedVehiclePosition = {
        x = scenarioVehicle.position.x,
        y = scenarioVehicle.position.y,
        z = scenarioVehicle.position.z
    }
    local vehicle = engine.gameState.createObject(vehicleTagHandle, nil, patchedVehiclePosition)
    return vehicle
end

-- Compact, self-contained alternative to pigPen.spawnNamedVehicle, though more resource intensive
---@param name string @ The object name of the scenario vehicle, as defined in the scenario
---@return EngineObjectHandle | nil @ The object handle of the created vehicle, or nil on failure
function pigPen.compactSpawnNamedVehicle(name)
    local namedScenarioVehicles = pigPen.getNamedScenarioVehicles()
    local scenarioVehicle = pigPen.getNamedVehicle(namedScenarioVehicles, name)
    if (scenarioVehicle == nil) then
        logger:error("Failed to spawn named vehicle: "..name)
        return
    end
    -- Call the vanilla spawnNamedVehicle rather than reinvent the wheel
    local vehicle = pigPen.spawnNamedVehicle(scenarioVehicle)
    return vehicle
end

return pigPen