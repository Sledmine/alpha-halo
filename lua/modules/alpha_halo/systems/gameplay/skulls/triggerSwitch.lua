local tagEntries = require "alpha_halo.systems.core.tagEntries"

local triggerSwitch = {}

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param isActive boolean
function triggerSwitch.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                if not trigger.flags.doesNotRepeatAutomatically then
                    trigger.flags.doesNotRepeatAutomatically = true
                else
                    trigger.flags.doesNotRepeatAutomatically = false
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.triggerswitch.active = isActive
    -- logger:debug("Trigger Switch {}", isActive and "On" or "Off")
end

return triggerSwitch