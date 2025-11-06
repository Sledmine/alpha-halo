local tagEntries = require "alpha_halo.systems.core.tagEntries"
local blam = require "blam2"

local sputnik = {}

--local defaultGravity = blam.globalGravity()
local defaultGravity = 0.00356518

---Sputnik: Halves gravity and adds acceleration to firing responses.
---@param isActive boolean
function sputnik.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    for _, tagEntry in ipairs(tagEntries.triggerDamageEffect()) do
        local damageEffect = tagEntry.data
        local impulsePushback = (damageEffect.temporaryCameraImpulsePushback * 3)
        local accelerationMultiplier = impulsePushback * finalSkullPower
        if isActive then
            damageEffect.damageInstantaneousAcceleration.i = damageEffect.damageInstantaneousAcceleration.i + accelerationMultiplier
            damageEffect.damageFlags:skipsShields(true)
            damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 0.001 -- This should not increase by any means.
            blam.globalGravity(defaultGravity / (2 * finalSkullPower))
        else
            Balltze.features.reloadTagData(tagEntry.handle)
            blam.globalGravity(defaultGravity)
        end
    end
end

return sputnik