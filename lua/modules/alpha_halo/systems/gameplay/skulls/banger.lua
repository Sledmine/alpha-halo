local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local banger = {}

local effects = dependencies.paths.effects

---Banger: Makes Grunts and Human Floods explode after dying.
---@param isActive boolean
function banger.skullEffect(isActive)
    local plasmaExplosion = findTags(effects.plasma, tagClasses.effect)[1]
    local floodExplosion = findTags(effects.flood, tagClasses.effect)[1]
    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("grunt") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        elseif tagEntry.path:includes("floodcombat_marine") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    -- skullsManager.skulls.banger.active = isActive
    -- logger:debug("Banger {}", isActive and "On" or "Off")
end

return banger