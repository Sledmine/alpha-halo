local tagEntries = require "alpha_halo.systems.core.tagEntries"

local tarkov = {}

---Tarkov: Wastes all rounds in magazines when reloading, but doubles their cappacity.
---@param isActive boolean
function tarkov.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            local weapon = tagEntry.data
            weapon.heatRecoveryThreshold = 0.001
            weapon.heatLossRate = weapon.heatLossRate * 0.5
            for i = 1, weapon.magazines.count do
                local magazine = weapon.magazines.elements[i]
                magazine.flags.everyRoundMustBeChambered = true
                magazine.flags.wastesRoundsWhenReloaded = true
                magazine.roundsLoadedMaximum = magazine.roundsLoadedMaximum * 2
                magazine.roundsReloaded = magazine.roundsReloaded * 2
            end
            for i = 1, weapon.triggers.count do
                local trigger = weapon.triggers.elements[i]
                if (trigger.magazine == 0) and (trigger.heatGeneratedPerRound < 1) then
                    trigger.heatGeneratedPerRound = trigger.heatGeneratedPerRound * 0.4
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.tarkov.active = isActive
    -- logger:debug("Tarkov {}", isActive and "On" or "Off")
end

return tarkov