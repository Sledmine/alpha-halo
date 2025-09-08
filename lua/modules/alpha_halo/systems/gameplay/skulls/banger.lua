local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local banger = {}

local effects = dependencies.paths.effects
local bipeds = dependencies.paths.bipeds

---Banger: Makes Grunts and Human Floods explode after dying.
---@param isActive boolean
function banger.skullEffect(isActive)
    local plasmaExplosion = findTags(effects.plasma, tagClasses.effect)[1]
    local floodExplosion = findTags(effects.flood, tagClasses.effect)[1]
    local fragExplosion = findTags(effects.frag, tagClasses.effect)[1]
    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("covenant") then -- Covenant launch plasmas at dead.
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        elseif tagEntry.path:includes("flood") then -- Flood launch spores at dead.
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        elseif tagEntry.path:includes("human") then -- Humans launch frags grenades at dead.
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = fragExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    local playerCollisionTagEntry = findTags(bipeds.player, tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry)
    for _, tagEntry in ipairs(playerCollisionTagEntry) do -- Players also launch frags at dead.
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.bodyDamagedThreshold =
                collisionGeometry.bodyDamagedThreshold + 0.1
            collisionGeometry.bodyDepletedEffect.tagHandle.value = fragExplosion.handle.value
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.banger.active = isActive
    -- logger:debug("Banger {}", isActive and "On" or "Off")
end

return banger