local tagEntries = require "alpha_halo.systems.core.tagEntries"

local slayer = {}

-- Slayer: Weapons shoot doble rounds and waste double ammo.
---@param isActive boolean
function slayer.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local slayerMultiplier = 2 * finalSkullPower
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            -- for i = 1, tagEntry.data.magazines.count do
            --    local magazine = tagEntry.data.magazines.elements[i]
            --    magazine.roundsLoadedMaximum = magazine.roundsLoadedMaximum * 2
            -- end -- This whole mechanic might be turn into a new skull all together.
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                -- trigger.roundsPerShot = trigger.roundsPerShot * 2
                trigger.projectilesPerShot = trigger.projectilesPerShot * slayerMultiplier
                local upperErrorAngle = trigger.errorAngle[1]
                local lowerErrorAngle = trigger.errorAngle[2]
                trigger.errorAngle = {
                    upperErrorAngle,
                    lowerErrorAngle * slayerMultiplier
                }
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.slayer.active = isActive
    -- logger:debug("Slayer {}", isActive and "On" or "Off")
end

return slayer