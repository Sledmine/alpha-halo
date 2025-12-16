local tagEntries = require "alpha_halo.systems.core.tagEntries"

local eyePatch = {}

-- Eye Patch: Eliminates weapons assistances & initial error.
---@param isActive boolean
function eyePatch.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        -- if not tagEntry.data.weaponType == engine.tag.weaponType.needler then -- We spare the Needler of this skull.
        local weapon = tagEntry.data
        if isActive then
            weapon.autoaimAngle = 0
            weapon.magnetismAngle = 0
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.minimumError = 0
                local lowerErrorAngle = trigger.errorAngle[1]
                local upperErrorAngle = trigger.errorAngle[2]
                trigger.errorAngle = {
                    lowerErrorAngle * 0,
                    upperErrorAngle
                }
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
        -- end -- Comment this if you want to apply the skull to the Needler as well (It will not track targets).
    end
    -- skullsManager.skulls.eyepatch.active = isActive
    -- logger:debug("Eye Patch {}", isActive and "On" or "Off")
end

return eyePatch