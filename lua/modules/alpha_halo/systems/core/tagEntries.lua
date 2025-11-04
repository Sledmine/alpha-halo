local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local blam = require "blam2"

local actorTagEntries
local actorVariantTagEntries
local bipedTagEntries
local damageEffectTagEntries
local effectTagEntries
local modelCollisionTagEntries
local projectileTagEntries
local vehicleTagEntries
local weaponTagEntries
local impactDamageEffect
local meleeDamageEffect
local explosionDamageEffect

local tagEntries = {}

function tagEntries.actor()
    if actorTagEntries then
        return actorTagEntries
    end
    actorTagEntries = findTags("", tagClasses.actor)
    assert(actorTagEntries)
    return actorTagEntries
end

function tagEntries.actorVariant()
    if actorVariantTagEntries then
        return actorVariantTagEntries
    end
    --actorVariantTagEntries = findTags("", tagClasses.actorVariant)
    actorVariantTagEntries = blam.tag.findTags("", blam.tag.groups.actorVariant)
    assert(actorVariantTagEntries)
    return actorVariantTagEntries --[[@as MetaEngineActorVariantTag[] ]]
end

function tagEntries.biped()
    if bipedTagEntries then
        return bipedTagEntries
    end
    bipedTagEntries = findTags("", tagClasses.biped)
    assert(bipedTagEntries)
    return bipedTagEntries
end

function tagEntries.damageEffect()
    if damageEffectTagEntries then
        return damageEffectTagEntries
    end
    damageEffectTagEntries = findTags("", tagClasses.damageEffect)
    assert(damageEffectTagEntries)
    return damageEffectTagEntries
end

function tagEntries.impactDamageEffect()
    if impactDamageEffect then
        return impactDamageEffect
    end
    impactDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, impactValue in ipairs(tagEntries.projectile()) do
            -- engine.tag.getTag(impactValue.data.impactDamage.tagHandle.value, engine.tag.classes.damageEffect)
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
    if meleeDamageEffect then
        return meleeDamageEffect
    end
    meleeDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        if tagEntry.path:includes("melee") then
            return true
        end
        return false
    end)
    assert(meleeDamageEffect)
    return meleeDamageEffect
end

function tagEntries.explosionDamageEffect()
    if explosionDamageEffect then
        return explosionDamageEffect
    end
    explosionDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        if tagEntry.data.radius[2] > 0 then
            return true
        end
        return false
    end)
    assert(explosionDamageEffect)
    return explosionDamageEffect
end

function tagEntries.effect()
    if effectTagEntries then
        return effectTagEntries
    end
    effectTagEntries = findTags("", tagClasses.effect)
    assert(effectTagEntries)
    return effectTagEntries
end

function tagEntries.modelCollisionGeometry()
    if modelCollisionTagEntries then
        return modelCollisionTagEntries
    end
    modelCollisionTagEntries = findTags("", tagClasses.modelCollisionGeometry)
    assert(modelCollisionTagEntries)
    return modelCollisionTagEntries
end

function tagEntries.projectile()
    if projectileTagEntries then
        return projectileTagEntries
    end
    --projectileTagEntries = findTags("", tagClasses.projectile)
    projectileTagEntries = blam.tag.findTags("", blam.tag.groups.projectile)
    assert(projectileTagEntries)
    return projectileTagEntries --[[@as MetaEngineProjectileTag[] ]]
end

function tagEntries.vehicle()
    if vehicleTagEntries then
        return vehicleTagEntries
    end
    vehicleTagEntries = findTags("", tagClasses.vehicle)
    assert(vehicleTagEntries)
    return vehicleTagEntries
end

function tagEntries.weapon()
    if weaponTagEntries then
        return weaponTagEntries
    end
    -- local weaponTagEntries = findTags("", tagClasses.weapon)
    weaponTagEntries = blam.tag.findTags("", blam.tag.groups.weapon)
    assert(weaponTagEntries)
    return weaponTagEntries --[[@as MetaEngineWeaponTag[] ]]
end

return tagEntries
