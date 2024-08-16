local blam = require "blam"
local constants = require "constants"
local balltze = require "mods.balltze"
local isNull = blam.isNull
local luna = require "luna"

local hsc = require "hsc"
local test = require "alpha_halo.test"

clua_version = 2.056

local armorLockVehicleHandle
local lastPosition
local maximumShield = 1
local currentAbility = "sprint"
---@type table<string, animationClass>
local armorLockAnimations = {
    
    ["armor_lock enter"] = false,
    ["armor_lock exit"] = false,
    ["armor_lock unarmed aim-still"] = false,
    ["armor_lock unarmed idle"] = false
}

function OnMapLoad()
    console_out("Loading alpha_halo.lua...")
    hsc.AllegianceSet(team1, team2)
end

local function findArmorLock()
    for objectId in pairs(blam.getObjects()) do
        local object = blam.object(get_object(objectId))
        if object and object.tagId == constants.tags.vehicles.armor_lock.id then
            return objectId
        end
    end
end

local function ruleOfThree(source, sourceMax, targetMax, invert)
    local result = (source * targetMax) / sourceMax
    if invert then
        return targetMax - result
    end
    return result
end

-- Function to calculate the angle in degrees from a normalized 2D vector
function calculateAngle(x, y)
    -- Calculate the angle in radians using atan2
    local radians = math.atan2(y, x)

    -- Convert radians to degrees
    local degrees = math.deg(radians)

    -- Ensure the angle is positive
    if degrees < 0 then
        degrees = degrees + 360
    end

    return degrees
end

local function findAnimationFromBiped(biped, animationName)
    local animations = blam.modelAnimations(blam.bipedTag(biped.tagId).animationGraph).animationList
    for i = 1, #animations do
        if animations[i].name == animationName then
            print("Animation found: " .. animationName)
            return table.merge({index = i - 1}, animations[i])
        end
    end
end

local function loadAnimations(biped)
    for animationName in pairs(armorLockAnimations) do
        armorLockAnimations[animationName] = findAnimationFromBiped(biped, animationName)
    end
end

local function armorLock()
    local player = blam.player(get_player())
    armorLockVehicleHandle = armorLockVehicleHandle or findArmorLock()
    local biped = blam.biped(get_dynamic_player())
    if not player then
        return
    end
    if biped then
        --biped.ignoreCollision = false
        if not isNull(biped.vehicleObjectId) and biped.vehicleObjectId == armorLockVehicleHandle then
            if biped.flashlightKey then
                biped.flashlightKey = false
                biped.flashlight = false
                balltze.unit_exit_vehicle(player.objectId)
                return
            end
        end
        local armorLock
        if armorLockVehicleHandle then
            armorLock = blam.vehicle(get_object(armorLockVehicleHandle))
        end
        if armorLock then
            --console_out("Biped animation: " .. biped.animation .. " Frame: " .. biped.animationFrame)
            --console_out("Vehicle animation: " .. armorLock.animation .. " Frame: " .. armorLock.animationFrame)
        end
        if biped.animation == armorLockAnimations["armor_lock enter"].index then
            local animation = armorLockAnimations["armor_lock enter"]
            biped.animationReplacementIndex = animation.index
            if armorLock then
                armorLock.animation = 0
                armorLock.animationFrame = biped.animationFrame

                local scaledValue = ruleOfThree(biped.animationFrame, animation.frameCount, 1)
                armorLock.health = scaledValue
            end
        elseif biped.animation == armorLockAnimations["armor_lock exit"].index then
            local animation = armorLockAnimations["armor_lock exit"]
            if armorLock then
                if armorLock.animationFrame == 0 then
                    armorLock.z = armorLock.z + 0.07
                    --local isInsideMapDetectorHandle = spawn_object(constants.tags.vehicles.armor_lock.id, biped.x, biped.y, biped.z)
                    --local isInsideMapDetector = blam.vehicle(get_object(isInsideMapDetectorHandle))
                    --if isInsideMapDetector then
                    --    if isInsideMapDetector.isOutSideMap then
                    --        --armorLock.z = armorLock.z + 0.07
                    --        console_out("Armor lock is outside the map!")
                    --    end
                    --    delete_object(isInsideMapDetectorHandle)
                    --end
                end
                armorLock.animation = 2
                armorLock.animationFrame = biped.animationFrame
                biped.animationReplacementIndex = 0

                local scaledValue = ruleOfThree(biped.animationFrame, 9, 1, true)
                armorLock.health = scaledValue
            end
        elseif biped.animation == armorLockAnimations["armor_lock unarmed idle"].index then
            local animation = armorLockAnimations["armor_lock unarmed idle"]
            if armorLock then
                armorLock.animation = 1
                armorLock.animationFrame = biped.animationFrame
            end
        end
    end
    if armorLockVehicleHandle then
        if biped and isNull(biped.vehicleObjectId) then
            if lastPosition then
                biped.x = lastPosition.x
                biped.y = lastPosition.y
                biped.z = lastPosition.z
                biped.animationFrame = 0
                lastPosition = nil
            end
            if not isNull(armorLockVehicleHandle) then
                console_debug("Deleting armor lock vehicle...")
                delete_object(armorLockVehicleHandle)
                armorLockVehicleHandle = nil
            end
        end
    end

    if biped and biped.isOnGround and isNull(biped.vehicleObjectId) then
    --if biped and isNull(biped.vehicleObjectId) then
        --local bipedWeapon = blam.weapon(get_object(biped.firstWeaponObjectId))
        --if bipedWeapon and bipedWeapon.pressedReloadKey then
        --    return
        --end

        local x, y, z = biped.x, biped.y, biped.z
        if biped.flashlightKey and not armorLockVehicleHandle then
            biped.flashlightKey = false
            biped.flashlight = false
            console_debug("Armor Locking...")
            biped.zVel = 0
            biped.xVel = 0
            biped.yVel = 0
            --console_out("Creating armor lock vehicle...")
            armorLockVehicleHandle = spawn_object(constants.tags.vehicles.armor_lock.id, x, y, z)

            local vehicle = blam.vehicle(get_object(armorLockVehicleHandle))
            if vehicle then
                if vehicle.isOutSideMap then
                    delete_object(armorLockVehicleHandle)
                    armorLockVehicleHandle = nil
                    return
                end
                vehicle.isPlayerNotAllowedToEntry = true
                local yaw, pitch, roll = blam.getObjectRotation(biped)
                yaw = calculateAngle(biped.cameraX, biped.cameraY)
                blam.rotateObject(vehicle, yaw, pitch, roll)
                lastPosition = { x = x, y = y, z = z}
                balltze.unit_enter_vehicle(player.objectId, armorLockVehicleHandle, 0)
            end
        end
    end
end

local backupAnimation

local function sprint()
    local player = blam.player(get_player())
    if not player then
        return
    end
    local biped = blam.biped(get_dynamic_player())
    if biped then

        if biped.flashlightKey then
            --if player.speed > 1 then
            --    player.speed = 1
            --else
            --    player.speed = 1.5
            --end
        end
        --console_out(biped.motionState)
        if biped.flashlight and biped.motionState == 1 then
        --if biped.motionState == 1 then
            player.speed = 1.5
            --biped.flashlight = false
            if not backupAnimation then
                backupAnimation = biped.animation
            end
            biped.animation = 282
            --biped.animationReplacementIndex = 282
        else
            player.speed = 1
            if backupAnimation then
                --console_out("Restoring animation " .. backupAnimation)
                biped.animation = backupAnimation
                backupAnimation = nil
            end
        end
    end
end

function OnTick()
    test.AllegianceSet()

    if not armorLockAnimations["armor_lock enter"] then
        local biped = blam.biped(get_dynamic_player())
        if biped then
            loadAnimations(biped)
        end
    end
    local biped = blam.biped(get_dynamic_player())
        if biped then
            if biped.actionKey then
                if currentAbility == "sprint" then
                    currentAbility = "armorLock"
                else
                    currentAbility = "sprint"
                end
            end
        end
    if currentAbility then
        if currentAbility == "armorLock" then
            armorLock()
        elseif currentAbility == "sprint" then
            sprint()
        end
    end
end

OnMapLoad()

set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")
