local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local catch = {}

local allUnits = dependencies.names.units

-- Catch: Makes the AI launch grenades a fuck lot.
---@param isActive boolean
function catch.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local catchTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    local catchMultiplier = 1.5 * finalSkullPower
    for _, tagEntry in ipairs(catchTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            local grenades = actorVariant.grenades --[[@as MetaEngineTagDataActorVariant]]
            ---@diagnostic disable-next-line: assign-type-mismatch
            grenades.grenadeStimulus = 1 -- 1 = visible target
            grenades.grenadeChance = grenades.grenadeChance + 0.2
            grenades.grenadeCheckTime = grenades.grenadeCheckTime * 0.1
            grenades.encounterGrenadeTimeout = grenades.encounterGrenadeTimeout * 0.7
            actorVariant.flags.hasUnlimitedGrenades = true
            ---@diagnostic disable-next-line: assign-type-mismatch
            actorVariant.items.grenadeCount = {
                actorVariant.items.grenadeCount[1] + 1,
                actorVariant.items.grenadeCount[2] + 1
            }
            if not tagEntry.path:includes("odst") then
                grenades.grenadeVelocity = grenades.grenadeVelocity * catchMultiplier
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

return catch
