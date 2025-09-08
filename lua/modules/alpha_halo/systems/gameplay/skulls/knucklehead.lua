local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local knucklehead = {}

local allUnits = dependencies.names.units
local bipeds = dependencies.paths.bipeds

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param isActive boolean
function knucklehead.skullEffect(isActive)
    local knuckleheadTagsFiltered = table.filter(tagEntries.modelCollisionGeometry(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(knuckleheadTagsFiltered) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if isActive then
                if material.flags:head() then
                    shield = shield * 25
                    body = body * 25
                end
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    for _, tagEntry in ipairs(tagEntries.impactDamageEffect()) do
        local damageEffectModifier = tagEntry.data
        if isActive then
            damageEffectModifier.grunt = damageEffectModifier.grunt * 0.2
            damageEffectModifier.jackal = damageEffectModifier.jackal * 0.2
            damageEffectModifier.elite = damageEffectModifier.elite * 0.2
            damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 0.2
            damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 0.2
            damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 0.2
            damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.knucklehead.active = isActive
    -- logger:debug("Knucklehead {}", isActive and "On" or "Off")
end

-- PvP Knucklehead: Multiplies damage to the head x4. Reduces weapon's impact damage to 1/2
---@param isActive boolean
function knucklehead.pvpSkullEffect(isActive)
    local playerCollisionTagEntry = findTags(bipeds.player, tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry)
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if isActive then
                if material.flags:head() then
                    shield = shield * 4
                    body = body * 4
                end
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    for _, tagEntry in ipairs(tagEntries.impactDamageEffect()) do
        local damageEffectModifier = tagEntry.data
        if isActive then
            damageEffectModifier.cyborgArmor = damageEffectModifier.cyborgArmor * 0.5
            damageEffectModifier.cyborgEnergyShield = damageEffectModifier.cyborgEnergyShield * 0.5
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.knucklehead.active = isActive
    -- logger:debug("Knucklehead {}", isActive and "On" or "Off")
end

return knucklehead