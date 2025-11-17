local balltze = Balltze
local engine = Engine
local objectTypes = Engine.tag.objectType
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local const = require "alpha_halo.systems.core.constants"
local blam = require "blam2"

local extendedWeapon = {}

function extendedWeapon.noZoomWhenOverheating()
    local beamRifleWeapon = const.weapons.beamRifle.data
    if not beamRifleWeapon then
        logger:warning("Extended Beam Rifle not found, skipping no zoom when overheating")
        return
    end

    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end

    --if biped.desiredZoomLevel == 255 then
    --    logger:debug("Weapon heat: {}", beamRifleWeapon.heatRecoveryThreshold)
    --end

    local weaponObjectHandle = biped.weapons[biped.currentWeaponId + 1]
    if not weaponObjectHandle or (weaponObjectHandle and weaponObjectHandle:isNull()) then
        return
    end
    local weaponObject = getObject(weaponObjectHandle, objectTypes.weapon)
    if not weaponObject then
        return
    end
    local weaponTag = table.find(const.weapons, function(tag)
        return tag.handle.value == weaponObject.tagHandle.value
    end)
    if not weaponTag then
        logger:error("Weapon tag constant must exist")
        return
    end

    if weaponObject.tagHandle.value == const.weapons.beamRifle.handle.value then
        local overheatLevel = weaponObject.heat
        if overheatLevel >= 1 and biped.desiredZoomLevel ~= 255 then
            -- Force no zoom (doesn't work)
            --biped.desiredZoomLevel = 255
            -- Workaround: reduce a tiny amount of health to force exit zoom
            local bipedHealth = biped.vitals.health
            biped.vitals.health = bipedHealth - 0.0001
        end
    end
    --for weaponIndex = 1,4 do
    --    Weapon = getObject(biped.weapons[weaponIndex], objectTypes.weapon)
    --    if Weapon then
    --        if Weapon.tagHandle.value == const.weapons.beamRifle.handle.value then
    --            --logger:debug("Beam Rifle Heat: {}", Weapon.heat)
    --            --logger:debug("biped desiredZoomLevel: {}", biped.desiredZoomLevel)
    --            --logger:debug("Biped Health: {}", biped.vitals.health)
    --            local overheatLevel = Weapon.heat
    --            if overheatLevel >= 1 and biped.desiredZoomLevel ~= 255 then
    --                -- Force no zoom (doesn't work)
    --                --biped.desiredZoomLevel = 255
    --                -- Workaround: reduce a tiny amount of health to force exit zoom
    --                local bipedHealth = biped.vitals.health
    --                biped.vitals.health = bipedHealth - 0.0001
    --            end
    --            break
    --        end
    --    end
    --end
end



return extendedWeapon