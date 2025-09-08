local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local mythic = {}

local allUnits = dependencies.names.units
local bipeds = dependencies.paths.bipeds

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param isActive boolean
function mythic.skullEffect(isActive)
    local mythicTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(mythicTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.bodyVitality = actorVariant.bodyVitality * 2
            actorVariant.shieldVitality = actorVariant.shieldVitality * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    local playerCollisionTagEntry = findTags(bipeds.player, tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There was a better way to do this! :D ^^^
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * 1.5
            collisionGeometry.maximumBodyVitality = collisionGeometry.maximumBodyVitality * 1.5
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.mythic.active = isActive
    -- logger:debug("Mythic {}", isActive and "On" or "Off")
end

return mythic