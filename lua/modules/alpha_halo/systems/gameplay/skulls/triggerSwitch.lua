local tagEntries = require "alpha_halo.systems.core.tagEntries"

local triggerSwitch = {}

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param isActive boolean
function triggerSwitch.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                if trigger.maximumRateOfFire[2] <= 6 then
                    for e = 1, tagEntry.data.magazines.count do
                        local magazine = tagEntry.data.magazines.elements[e]
                        magazine.flags.everyRoundMustBeChambered = false
                    end
                    trigger.flags.doesNotRepeatAutomatically = false
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    trigger.maximumRateOfFire = {
                        trigger.maximumRateOfFire[1],
                        trigger.maximumRateOfFire[2] * 5
                    }
                else
                    trigger.flags.doesNotRepeatAutomatically = true
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    trigger.maximumRateOfFire = {
                        trigger.maximumRateOfFire[1],
                        trigger.maximumRateOfFire[2] * 0.2
                    }
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