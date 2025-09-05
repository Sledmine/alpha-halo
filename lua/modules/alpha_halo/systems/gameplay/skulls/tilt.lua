local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local tilt = {}

local weapons = dependencies.names.weapons

---Tilt: Doubles strenghts and weakenesses.
---@param isActive boolean
function tilt.skullEffect(isActive)
    local energyDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(weapons.energy) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    local kineticDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(weapons.kinetic) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end) -- This is a kinda nuttered version of Tilt, in hopes to reduce the load on the game.
    for _, tagEntry in ipairs(energyDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * 0.5
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * 0.5
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * 0.5
                damageEffectModifier.grunt = damageEffectModifier.grunt * 0.5
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * 0.5
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 0.5
                damageEffectModifier.elite = damageEffectModifier.elite * 0.5
                damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 2
                damageEffectModifier.jackal = damageEffectModifier.jackal * 0.5
                damageEffectModifier.jackalEnergyShield =
                    damageEffectModifier.jackalEnergyShield * 2
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 0.5
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 0.5
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    for _, tagEntry in ipairs(kineticDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * 2
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * 2
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * 2
                damageEffectModifier.grunt = damageEffectModifier.grunt * 2
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * 2
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 2
                damageEffectModifier.elite = damageEffectModifier.elite * 2
                damageEffectModifier.eliteEnergyShield =
                    damageEffectModifier.eliteEnergyShield * 0.5
                damageEffectModifier.jackal = damageEffectModifier.jackal * 2
                damageEffectModifier.jackalEnergyShield =
                    damageEffectModifier.jackalEnergyShield * 0.5
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 2
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 2
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    -- skullsManager.skulls.tilt.active = isActive
    -- logger:debug("Tilt {}", isActive and "On" or "Off")
end

return tilt
