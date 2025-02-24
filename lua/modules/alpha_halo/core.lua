local blam = require "blam"


local core = {}

function core.vehiclePositionLoader()
    for objectHandle in pairs(blam.getObjects()) do
        local object = blam.getObject(objectHandle)
        if object and object.class == blam.objectClasses.vehicle then
            local objectTag = blam.getTag(object.tagId)
            if objectTag then
                --if objectTag.path:includes("ghost") then
                if objectTag.path:includes("covenant_spirit") then
                    local vehicle = blam.vehicle(get_object(objectHandle))
                    if vehicle then
                        --execute_script("cls")
                        local mainNode = getNodePosition(get_object(objectHandle) + 0x5B8)
                        local absoluteNodeX = mainNode.x + (vehicle.x - mainNode.x)
                        local absoluteNodeY = mainNode.y + (vehicle.y - mainNode.y)
                        local absoluteNodeZ = mainNode.z + (vehicle.z - mainNode.z)
                        --[[console_out(mainNode.x)
                        console_out(mainNode.y)
                        console_out(mainNode.z)
                        console_out("-----------")
                        console_out(absoluteNodeX)
                        console_out(absoluteNodeY)
                        console_out(absoluteNodeZ)]]
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
                        --[[console_out("locationId " .. tostring(vehicle.locationId))
                        console_out("hover " .. tostring(vehicle.hover))
                        console_out("thrust " .. tostring(vehicle.thrust))
                        console_out("isActive " .. tostring(vehicle.isActive))
                        console_out("isNotMoving " .. tostring(vehicle.isNotMoving))
                        console_out("isGhost " .. tostring(vehicle.isGhost))
                        console_out("isControllable " .. tostring(vehicle.isControllable))
                        console_out("isCurrentlyControllable " .. tostring(vehicle.isCurrentlyControllable))
                        console_out("isHovering " .. tostring(vehicle.isHovering))
                        console_out("isFrozen " .. tostring(vehicle.isFrozen))
                        console_out("isStationary " .. tostring(vehicle.isStationary))
                        console_out("isSuspended " .. tostring(vehicle.isSuspended))
                        console_out(("x: {x}, y: {y}, z: {z}"):template({x = vehicle.x, y = vehicle.y, z = vehicle.z}))]]
                    end
                end
            end
        end
    end
end

return core