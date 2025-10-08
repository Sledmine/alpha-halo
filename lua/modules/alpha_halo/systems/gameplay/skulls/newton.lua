local tagEntries = require "alpha_halo.systems.core.tagEntries"

local newton = {}

---Newton: Augments instant acceleration for melee damages.
---@param isActive boolean
function newton.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local accelerationMultiplier = 5 * finalSkullPower
    for _, tagEntry in ipairs(tagEntries.meleeDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.damageInstantaneousAcceleration.i =
                damageEffect.damageInstantaneousAcceleration.i + accelerationMultiplier
            if tagEntry.path:includes("response") then
                damageEffect.damageFlags:skipsShields(true)
                damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 0.001 -- This should not increase by any means.
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.newton.active = isActive
    -- logger:debug("Newton {}", isActive and "On" or "Off")
end

return newton