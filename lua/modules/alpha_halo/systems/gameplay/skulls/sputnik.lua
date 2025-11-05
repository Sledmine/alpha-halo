local tagEntries = require "alpha_halo.systems.core.tagEntries"

local sputnik = {}

---Sputnik: Halves gravity and adds acceleration to firing responses.
---@param isActive boolean
function sputnik.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    for _, tagEntry in ipairs(tagEntries.triggerDamageEffect()) do
        local damageEffect = tagEntry.data
        local impulsePushback = (damageEffect.temporaryCameraImpulsePushback * 10)
        local accelerationMultiplier = impulsePushback * finalSkullPower
        if isActive then
            damageEffect.damageInstantaneousAcceleration.i = damageEffect.damageInstantaneousAcceleration.i + accelerationMultiplier
            damageEffect.damageFlags:skipsShields(true)
            damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 0.001 -- This should not increase by any means.
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.sputnik.active = isActive
    -- logger:debug("Sputnik {}", isActive and "On" or "Off")
end

return sputnik