local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    assasin = false,
    mythic = false
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

-- This get bipeds & actorVariants on the map. Likely will be discarted.
--local bipeds = blam.findTagsList("", blam.tagClasses.biped)
local actorVariants = blam.findTagsList("", blam.tagClasses.actorVariant)

-- This is the old function made by Sled using blam.
function skullsManager.blamMythic()
    for _, tagEntry in pairs(actorVariants) do
        local actorVariantTag = blam.actorVariant(tagEntry.id)
        local isSkullBiped = table.find(keywords, function (keyword) return actorVariantTag.path:includes(keyword) end)
        if isSkullBiped then
            if skullsManager.skulls.mytic then
                actorVariantTag.health = actorVariantTag.health * 2
            else
                actorVariantTag.health = actorVariantTag.health * 0
            end
        end
    end
end

-- This is an attempt of recreating the skull with Balltze.
function skullsManager.balltzeMythic()
    local actorVariantTagHandle = engine.tag.getTag(0, engine.tag.classes.actorVariant)
    assert(actorVariantTagHandle, "skullsManager: Failed to get actor_variant tag handle.")
    local isSkullBiped = table.find(keywords, function (keyword) return actorVariantTagHandle.path:includes(keyword) end)
    assert(isSkullBiped, "skullsManager: Failed to get is skull biped.")
    local actorVariantBodyVitality = actorVariantTagHandle.data.bodyVitality
    if isSkullBiped then
        if skullsManager.skulls.mythic then
            actorVariantBodyVitality = actorVariantBodyVitality * 2
        else
            actorVariantBodyVitality = actorVariantBodyVitality * 1
        end
    end
end

---- This is the skull Assasin.
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