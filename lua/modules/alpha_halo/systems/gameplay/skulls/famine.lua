local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local famine = {}

local allUnits = dependencies.names.units

-- Famine: Makes the AI drop half the ammo.
---@param isActive boolean
function famine.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local famineTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    local famineMultiplier = 0.5 / finalSkullPower
    for _, tagEntry in ipairs(famineTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            local dropWeaponLoadedLower = actorVariant.dropWeaponLoaded[1]
            local dropWeaponLoadedUpper = actorVariant.dropWeaponLoaded[2]
            ---@diagnostic disable-next-line: assign-type-mismatch
            actorVariant.dropWeaponLoaded = {
                dropWeaponLoadedLower * famineMultiplier,
                dropWeaponLoadedUpper * famineMultiplier
            }
            local dropWeaponAmmoLower = actorVariant.dropWeaponAmmo[1]
            local dropWeaponAmmoUpper = actorVariant.dropWeaponAmmo[2]
            ---@diagnostic disable-next-line: assign-type-mismatch
            actorVariant.dropWeaponAmmo = {
                dropWeaponAmmoLower * famineMultiplier,
                dropWeaponAmmoUpper * famineMultiplier
            }
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

return famine
