local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    mythic = false,
    assasin = false,
    hunger = false,
    catch = false
}

-- These keywords help separate the tags needed.
local keywords = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "sentinel",
    "odst"
}

-- This get tags on the map. Currently only looking for .actor_variant's.
local actorVariants = blam.findTagsList("", blam.tagClasses.actorVariant)

-- Mythic: Duplicates all AI body & shields vitality. || These and all further skulls are waiting for senior suppervision asap.
function skullsManager.skullMythic()
    local actorVariantTagHandle = engine.tag.getTag(0, engine.tag.classes.actorVariant)
    assert(actorVariantTagHandle, "skullsManager: Failed to get actor_variant tag handle.")
    local isSkullActor = table.find(keywords, function (keyword) return actorVariantTagHandle.path:includes(keyword) end)
    assert(isSkullActor, "skullsManager: Failed to get is skull biped.")
    local actorVariantBodyVitality = actorVariantTagHandle.data.bodyVitality
    local actorVariantShieldVitality = actorVariantTagHandle.data.shieldVitality
    if isSkullActor then
        if skullsManager.skulls.mythic then
            actorVariantBodyVitality = actorVariantBodyVitality * 2
            actorVariantShieldVitality = actorVariantShieldVitality * 2
        else
            actorVariantBodyVitality = actorVariantBodyVitality * 1
            actorVariantShieldVitality = actorVariantShieldVitality * 1
        end
    end
end

-- Assasin: Makes the AT invisible.
function skullsManager.skullAssasin()
    local actorVariantTagHandle = engine.tag.getTag(0, engine.tag.classes.actorVariant)
    assert(actorVariantTagHandle, "skullsManager: Failed to get actor_variant tag handle.")
    local isSkullActor = table.find(keywords, function (keyword) return actorVariantTagHandle.path:includes(keyword) end)
    assert(isSkullActor, "skullsManager: Failed to get is skull biped.")
    local actorVariantIsInvisible = actorVariantTagHandle.data.flags.activeCamouflage
    if isSkullActor then
        if actorVariantIsInvisible == false then -- This should exclude all actor_variants that are invisible by default.
            if skullsManager.skulls.assasin then
            actorVariantIsInvisible = true
            else
                actorVariantIsInvisible = false
            end
        end
    end
end

-- Hunger: Makes the AT drop half the ammo.
function skullsManager.skullHunger()
    local actorVariantTagHandle = engine.tag.getTag(0, engine.tag.classes.actorVariant)
    assert(actorVariantTagHandle, "skullsManager: Failed to get actor_variant tag handle.")
    local isSkullActor = table.find(keywords, function (keyword) return actorVariantTagHandle.path:includes(keyword) end)
    assert(isSkullActor, "skullsManager: Failed to get is skull biped.")
    local actorVariantAmmoLeft = actorVariantTagHandle.data.dropWeaponAmmo
    local actorVariantAmmoLoaded = actorVariantTagHandle.data.dropWeaponLoaded
    if isSkullActor then
        if skullsManager.skulls.hunger then
            actorVariantAmmoLeft = actorVariantAmmoLeft * 0.5
            actorVariantAmmoLoaded = actorVariantAmmoLoaded * 0.5
        else
            actorVariantAmmoLeft = actorVariantAmmoLeft * 1
            actorVariantAmmoLoaded = actorVariantAmmoLoaded * 1
        end
    end
end

-- Catch: Makes the AI launch grenades a fuck lot.
function skullsManager.skullCatch()
    local actorVariantTagHandle = engine.tag.getTag(0, engine.tag.classes.actorVariant)
    assert(actorVariantTagHandle, "skullsManager: Failed to get actor_variant tag handle.")
    local isSkullActor = table.find(keywords, function (keyword) return actorVariantTagHandle.path:includes(keyword) end)
    assert(isSkullActor, "skullsManager: Failed to get is skull biped.")
    local grenadeStimulus = actorVariantTagHandle.data.grenadeStimulus.usVisibleTarget -- EngineTagDataActorVariantGrenadeStimulus?
    local grenadeEnemyRadious = actorVariantTagHandle.data.enemyRadius
    local grenadeVelocity = actorVariantTagHandle.data.grenadeVelocity
    local grenadeRanges = actorVariantTagHandle.data.grenadeRanges
    local collateralDamageRadius = actorVariantTagHandle.data.collateralDamageRadius
    local grenadeChance = actorVariantTagHandle.data.grenadeChance
    local grenadeCheckTime = actorVariantTagHandle.data.grenadeCheckTime
    local encounterGrenadeTimeout = actorVariantTagHandle.data.encounterGrenadeTimeout
    if isSkullActor then
        --if skullsManager.skulls.catch then
        --    grenadeVelocity = grenadeVelocity + 3
        --    grenadeChance = grenadeChance + 1
        --else
        --    grenadeVelocity = grenadeVelocity
        --    grenadeChance = grenadeChance
        --end
    end
end

---- This is the old Mythic skull made by Sled using blam.
--function skullsManager.blamMythic()
--    for _, tagEntry in pairs(actorVariants) do
--        local actorVariantTag = blam.actorVariant(tagEntry.id)
--        local isSkullActor = table.find(keywords, function (keyword) return actorVariantTag.path:includes(keyword) end)
--        if isSkullActor then
--            if skullsManager.skulls.mytic then
--                actorVariantTag.health = actorVariantTag.health * 2
--            else
--                actorVariantTag.health = actorVariantTag.health * 0
--            end
--        end
--    end
--end

---- This is the old Assasin skull made by Sled using blam.
--function skullsManager.assasin()
--    -- Get all current spawned objects in the game
--    local gameObjects = blam.getObjects()
--    for objectId, objectIndex in pairs(gameObjects) do
--        local object = blam.getObject(objectIndex)
--        assert(object)
--        if object.class == blam.objectClasses.biped then
--            local biped = blam.biped(get_object(objectIndex))
--            assert(biped)
--            local tagFromList = table.find(bipeds, function (tag)
--                return biped.tagId == tag.id
--            end)
--            if tagFromList then
--                for _, keyword in pairs(keywords) do
--                    if tagFromList.path:includes(keyword) then
--                        if skullsManager.skulls.assasin and biped.health >= 0 then
--                            biped.invisible = true
--                        else
--                            biped.invisible = false
--                        end
--                    end
--                end
--            end
--        end
--    end
--end

return skullsManager