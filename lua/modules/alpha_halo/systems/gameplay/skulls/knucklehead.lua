local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local knucklehead = {}

local allUnits = dependencies.names.units

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param isActive boolean
function knucklehead.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local knuckleheadTagsFiltered = table.filter(tagEntries.modelCollisionGeometry(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    local bipedColissionMultiplier = (24 * finalSkullPower)
    for _, tagEntry in ipairs(knuckleheadTagsFiltered) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if isActive then
                if material.flags:head() then
                    shield = shield * bipedColissionMultiplier
                    body = body * bipedColissionMultiplier
                end
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    local materialResponseMultiplier = (0.2 * finalSkullPower)
    for _, tagEntry in ipairs(tagEntries.impactDamageEffect()) do
        local damageEffectModifier = tagEntry.data
        if isActive then
            damageEffectModifier.grunt = damageEffectModifier.grunt * materialResponseMultiplier
            damageEffectModifier.jackal = damageEffectModifier.jackal * materialResponseMultiplier
            damageEffectModifier.elite = damageEffectModifier.elite * materialResponseMultiplier
            damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * materialResponseMultiplier
            damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * materialResponseMultiplier
            damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * materialResponseMultiplier
            damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * (2 * finalSkullPower)
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.knucklehead.active = isActive
    -- logger:debug("Knucklehead {}", isActive and "On" or "Off")
end

return knucklehead