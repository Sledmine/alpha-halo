local tagEntries = require "alpha_halo.systems.core.tagEntries"

local newton = {}

---Newton: Augments instant acceleration for melee damages.
---@param isActive boolean
function newton.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.meleeDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.damageInstantaneousAcceleration.i =
                damageEffect.damageInstantaneousAcceleration.i + 5
            if tagEntry.path:includes("response") then
                damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 1
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.newton.active = isActive
    -- logger:debug("Newton {}", isActive and "On" or "Off")
end

return newton