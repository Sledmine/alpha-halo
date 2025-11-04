local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local gruntBirthday = {}

local effects = dependencies.paths.effects

---Grunt Birthday: Makes Grunts explode into confetti with a headshot.
---@param isActive boolean
function gruntBirthday.skullEffect(isActive)
    local confettiExplosion = findTags(effects.confetti, tagClasses.effect)[1]
    if not confettiExplosion then
        logger:error("Confetti effect not found.")
        return
    end

    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("grunt") then
            local collisionGeometry = tagEntry.data
            local regions = collisionGeometry and collisionGeometry.regions
            if not regions or not regions.count or not regions.elements then
                goto continue
            end

            for i = 1, regions.count do
                local headRegion = regions.elements[i]
                if headRegion.name == "01+mask" or headRegion.name:includes("head") then
                    local headRegionEffect = headRegion.destroyedEffect
                    if isActive then
                        headRegion.damageThreshold = 0.01
                        headRegionEffect.tagHandle.value = confettiExplosion.handle.value
                    else
                        Balltze.features.reloadTagData(tagEntry.handle)
                    end
                    break
                end
            end
        end
        ::continue::
    end
end

return gruntBirthday

