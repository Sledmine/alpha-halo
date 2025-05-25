local blam = require "blam"
local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local inspect = require "inspect"

local tagEntries = {}

function tagEntries.actor()
    local actorTagEntries = findTags("", tagClasses.actor)
    assert(actorTagEntries)
    return actorTagEntries
end

function tagEntries.actorVariant()
    local actorVariantTagEntries = findTags("", tagClasses.actorVariant)
    assert(actorVariantTagEntries)
    return actorVariantTagEntries
end

function tagEntries.biped()
    local bipedTagEntries = findTags("", tagClasses.biped)
    assert(bipedTagEntries)
    return bipedTagEntries
end

function tagEntries.damageEffect()
    local damageEffectTagEntries = findTags("", tagClasses.damageEffect)
    assert(damageEffectTagEntries)
    return damageEffectTagEntries
end

function tagEntries.impactDamageEffect()
    local impactDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, impactValue in ipairs(tagEntries.projectile()) do
            --engine.tag.getTag(impactValue.data.impactDamage.tagHandle.value, engine.tag.classes.damageEffect)
            if tagEntry.handle.value == impactValue.data.impactDamage.tagHandle.value then
                return true
            end
        end
        return false
    end)
    assert(impactDamageEffect)
    return impactDamageEffect
end

function tagEntries.meleeDamageEffect()
    local meleeDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        if tagEntry.path:includes("melee") then
            return true
        end
        return false
    end)
    assert(meleeDamageEffect)
    return meleeDamageEffect
end

function tagEntries.explosionDamageEffect()
    local explosionDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        if tagEntry.data.radius[2] > 0 then
            return true
        end
        return false
    end)
    assert(explosionDamageEffect)
    return explosionDamageEffect
end

function tagEntries.effect()
    local effectTagEntries = findTags("", tagClasses.effect)
    assert(effectTagEntries)
    return effectTagEntries
end

function tagEntries.modelCollisionGeometry()
    local modelCollisionTagEntries = findTags("", tagClasses.modelCollisionGeometry)
    assert(modelCollisionTagEntries)
    return modelCollisionTagEntries
end

function tagEntries.projectile()
    local projectileTagEntries = findTags("", tagClasses.projectile)
    assert(projectileTagEntries)
    return projectileTagEntries
end

function tagEntries.vehicle()
    local vehicleTagEntries = findTags("", tagClasses.vehicle)
    assert(vehicleTagEntries)
    return vehicleTagEntries
end

function tagEntries.weapon()
    local weaponTagEntries = findTags("", tagClasses.weapon)
    assert(weaponTagEntries)
    return weaponTagEntries
end

return tagEntries