local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local mythic = {}

local bipeds = dependencies.paths.bipeds
local allUnits = dependencies.names.units

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param isActive boolean
function mythic.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local mythicTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    local actorVariantVitals = 2 * finalSkullPower
    for _, tagEntry in ipairs(mythicTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.unitProperties.bodyVitality = actorVariant.unitProperties.bodyVitality * actorVariantVitals
            actorVariant.unitProperties.shieldVitality = actorVariant.unitProperties.shieldVitality * actorVariantVitals
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    local playerCollisionTagEntry = findTags(bipeds.player, tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry)
    local playerVitals = 1.5 * finalSkullPower
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * playerVitals
            collisionGeometry.maximumBodyVitality = collisionGeometry.maximumBodyVitality * playerVitals
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.mythic.active = isActive
    -- logger:debug("Mythic {}", isActive and "On" or "Off")
end

return mythic