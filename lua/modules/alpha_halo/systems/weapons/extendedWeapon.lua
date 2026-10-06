local balltze = Balltze
local engine = Engine
local getObject = Engine.object.getObject
local getPlayer = Engine.player.getPlayer
local const = require "alpha_halo.systems.core.constants"

local extendedWeapon = {}

function extendedWeapon.noZoomWhenOverheating()
    local beamRifleWeapon = const.weapons.beamRifle and (const.weapons.beamRifle.data or const.weapons.beamRifle)
    if not beamRifleWeapon then
        logger.warninging("Extended Beam Rifle not found, skipping no zoom when overheating")
        return
    end

    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.unitHandle, "biped")
    if not biped then
        return
    end

    local weaponObjectHandle = biped.weapons[biped.currentWeaponId + 1]
    if not weaponObjectHandle or (weaponObjectHandle and weaponObjectHandle:isNull()) then
        return
    end
    local weaponObject = getObject(weaponObjectHandle, "weapon")
    if not weaponObject then
        return
    end
    local weaponTag = table.find(const.weapons, function(tag)
        return tag.handle.value == weaponObject.tagHandle.value
    end)
    if not weaponTag then
        logger.error("Weapon tag constant must exist")
        return
    end

    if weaponObject.tagHandle.value == const.weapons.beamRifle.handle.value then
        local overheatLevel = weaponObject.heat
        if overheatLevel >= 1 and biped.desiredZoomLevel ~= 255 then
            local bipedHealth = biped.vitals.health
            biped.vitals.health = bipedHealth - 0.0001
        end
    end
end

return extendedWeapon