local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local catch = {}

local allUnits = dependencies.names.units
local bipeds = dependencies.paths.bipeds

-- Catch: Makes the AI launch grenades a fuck lot.
---@param isActive boolean
function catch.skullEffect(isActive)
    local catchTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(catchTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            -- actorVariant.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.visibleTarget
            actorVariant.flags:hasUnlimitedGrenades(true)
            actorVariant.grenadeChance = actorVariant.grenadeChance + 1
            actorVariant.grenadeCheckTime = actorVariant.grenadeCheckTime * 0.1
            actorVariant.encounterGrenadeTimeout = actorVariant.encounterGrenadeTimeout * 0
            actorVariant.grenadeCount[1] = actorVariant.grenadeCount[1] + 1
            actorVariant.grenadeCount[2] = actorVariant.grenadeCount[2] + 1
            --if not tagEntry.path:includes("odst") then
                actorVariant.grenadeVelocity = actorVariant.grenadeVelocity * 2
            --end  -- Why did i wanted to omit odsts? Guess we'll find out...
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    local playerBipedTagEntry = findTags(bipeds.player, tagClasses.biped)
    assert(playerBipedTagEntry)
    for _, tagEntry in ipairs(playerBipedTagEntry) do
        local biped = tagEntry.data
        if isActive then
            biped.grenadeVelocity = biped.grenadeVelocity * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.catch.active = isActive
    -- logger:debug("Catch {}", isActive and "On" or "Off")
end

return catch