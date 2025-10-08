local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local tilt = {}

local weapons = dependencies.names.weapons

---Tilt: Doubles strenghts and weakenesses.
---@param isActive boolean
function tilt.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
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
    local tiltMultiplierBuff = 2 * finalSkullPower
    local tiltMultiplierNerf = 0.5 / finalSkullPower
    for _, tagEntry in ipairs(energyDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * tiltMultiplierNerf
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * tiltMultiplierNerf
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * tiltMultiplierNerf
                damageEffectModifier.grunt = damageEffectModifier.grunt * tiltMultiplierNerf
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * tiltMultiplierNerf
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * tiltMultiplierNerf
                damageEffectModifier.elite = damageEffectModifier.elite * tiltMultiplierNerf
                damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * tiltMultiplierBuff
                damageEffectModifier.jackal = damageEffectModifier.jackal * tiltMultiplierNerf
                damageEffectModifier.jackalEnergyShield = damageEffectModifier.jackalEnergyShield * tiltMultiplierBuff
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * tiltMultiplierNerf
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * tiltMultiplierNerf
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    for _, tagEntry in ipairs(kineticDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * tiltMultiplierBuff
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * tiltMultiplierBuff
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * tiltMultiplierBuff
                damageEffectModifier.grunt = damageEffectModifier.grunt * tiltMultiplierBuff
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * tiltMultiplierBuff
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * tiltMultiplierBuff
                damageEffectModifier.elite = damageEffectModifier.elite * tiltMultiplierBuff
                damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * tiltMultiplierNerf
                damageEffectModifier.jackal = damageEffectModifier.jackal * tiltMultiplierBuff
                damageEffectModifier.jackalEnergyShield = damageEffectModifier.jackalEnergyShield * tiltMultiplierNerf
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * tiltMultiplierBuff
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * tiltMultiplierBuff
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    -- skullsManager.skulls.tilt.active = isActive
    -- logger:debug("Tilt {}", isActive and "On" or "Off")
end

return tilt
