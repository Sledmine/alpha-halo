local tagEntries = require "alpha_halo.systems.core.tagEntries"

local cowbell = {}

---Cowbell: Doubles bipeds & vehicles accelerationScale.
---@param isActive boolean
function cowbell.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local cowbellMultiplier = 2 * finalSkullPower
    for _, tagEntry in ipairs(tagEntries.biped()) do
        local bipedTag = tagEntry.data
        if isActive then
            bipedTag.accelerationScale = bipedTag.accelerationScale * cowbellMultiplier
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    for _, tagEntry in ipairs(tagEntries.vehicle()) do
        local vehicle = tagEntry.data
        if isActive then
            vehicle.accelerationScale = vehicle.accelerationScale * cowbellMultiplier
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.cowbell.active = isActive
    -- logger:debug("Cowbell {}", isActive and "On" or "Off")
end

return cowbell