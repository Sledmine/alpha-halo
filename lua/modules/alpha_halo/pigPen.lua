-- This is the pig pen. A module that contains some -real dirty- code, hence the name.

-- Module imports
local engine = Engine
local balltze = Balltze

local pigPen = {}

function pigPen.test()
    console_out("Pig pen test. Oiiiiiink, wheeeeeek, wheeeeeek.")
end

function pigPen.test2()
    local scenarioTagHandle = engine.tag.getTag(0, engine.tag.classes.scenario) -- Gets the first (and only) .scenario tag from the map
    assert(scenarioTagHandle, "pigPen: Failed to get scenario tag handle.") -- Assert handle is not nil (or false)
    local scenarioVehicles = scenarioTagHandle.data.vehicles
    local scenarioVehiclesCount = scenarioVehicles.count
    local scenarioVehiclesElements = scenarioVehicles.elements
    -- Get count using count field, not through table length operator (#)
    console_out(scenarioVehicles.count)
    -- Iterate using count provided by the engine, not table length
    local scenarioObjectNames = scenarioTagHandle.data.objectNames
    local scenarioObjectNamesElements = scenarioObjectNames.elements

    -- for k, v in pairs(scenarioObjectNamesElements) do
    --     console_out("objname "..k.." = "..v.name)
    -- end
    

    for i = 1, scenarioVehiclesCount, 1 do
        local scenarioVehicle = scenarioVehiclesElements[i]

        local scenarioVehicleObjectNameIndex = scenarioVehicle.name
        if (scenarioVehicleObjectNameIndex == nil) then
            console_out("SKIPPING, THIS OBJECT IS NOT NAMED! I")
            goto continue -- Skip to the next iteration if vehicle is not named, but do not break the whole thing like assert does
        end

        local scenarioVehicleObjectName = scenarioObjectNamesElements[scenarioVehicleObjectNameIndex] -- This should never be nil... I guess? Unless the index points to an invalid object name
        if (scenarioVehicleObjectName == nil) then
            console_out("SKIPPING, THIS OBJECT IS NOT NAMED! II")
            goto continue -- Skip to the next iteration if vehicle is not named, but do not break the whole thing like assert does
        end

        -- Print the "name" field only if the object name object is not nil
        console_out("Vehicle #"..i.." = "..scenarioVehicleObjectName.name)
        -- console_out(scenarioVehicleObjectName.name)
        ::continue::
    end

end

return pigPen