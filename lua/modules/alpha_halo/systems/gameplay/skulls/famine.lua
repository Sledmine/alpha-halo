local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local famine = {}

local allUnits = dependencies.names.units

-- Famine: Makes the AI drop half the ammo.
---@param isActive boolean
function famine.skullEffect(isActive)
    local famineTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(famineTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.dropWeaponLoaded[1] = actorVariant.dropWeaponLoaded[1] * 0.5
            actorVariant.dropWeaponLoaded[2] = actorVariant.dropWeaponLoaded[2] * 0.5
            actorVariant.dropWeaponAmmo[1] = actorVariant.dropWeaponAmmo[1] * 0.5
            actorVariant.dropWeaponAmmo[2] = actorVariant.dropWeaponAmmo[2] * 0.5
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.famine.active = isActive
    -- logger:debug("Famine {}", isActive and "On" or "Off")
end

-- PvP Famine: Halves weapon's max reserved ammo.
---@param isActive boolean
function famine.pvpSkullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        local weapon = tagEntry.data
        if isActive then
            for i = 1, weapon.magazines.count do
                local magazine = weapon.magazines.elements[i]
                magazine.roundsTotalInitial = magazine.roundsTotalInitial * 0.5
                magazine.roundsReservedMaximum = magazine.roundsReservedMaximum * 0.5
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.pvpFamine.active = isActive
    -- logger:debug("Famine {}", isActive and "On" or "Off")
end

return famine
