local tagEntries = require "alpha_halo.systems.core.tagEntries"

local bloodlust = {}

---Bloodlust: Players lose shields each tick but regain it upon killing an enemy.
---This is not even closed to be implemented, we need new tech.
---@param isActive boolean
function bloodlust.skullEffect(isActive, totalSkullPower)
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
    -- skullsManager.skulls.bloodlust.active = isActive
    -- logger:debug("Bloodlust {}", isActive and "On" or "Off")
end

return bloodlust