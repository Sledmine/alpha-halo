local tagEntries = require "alpha_halo.systems.core.tagEntries"

local havok = {}

---Havok: Doubles all damage_effect's damage radius, and it scales properly.
---@param isActive boolean
function havok.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local radiusMultiplier = 1.5 * finalSkullPower
    local damageMultiplier = 0.75 * finalSkullPower
    for _, tagEntry in ipairs(tagEntries.explosionDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.radius[2] = damageEffect.radius[2] * radiusMultiplier
            damageEffect.damageLowerBound = damageEffect.damageLowerBound * damageMultiplier
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.havok.active = isActive
    -- logger:debug("Havok {}", isActive and "On" or "Off")
end

return havok