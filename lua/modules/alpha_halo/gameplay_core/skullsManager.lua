local blam = require "blam"

local skulls = {}

-- Get all biped tags in the map
local bipeds = blam.findTagsList("", blam.tagClasses.biped)
local actorVariants = blam.findTagsList("", blam.tagClasses.actorVariant)
local keywords = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "sentinel",
    "odst"
}

skulls.flags = {
    assasin = false,
    mythic = false
}

function skulls.mythic()
    for _, tagEntry in pairs(actorVariants) do
        local actorVariantTag = blam.actorVariant(tagEntry.id)
        local isSkullBiped = table.find(keywords, function (keyword) return actorVariantTag.path:includes(keyword) end)
        if isSkullBiped then
            if skulls.flags.mytic then
                actorVariantTag.health = actorVariantTag.health * 2
            else
                actorVariantTag.health = actorVariantTag.health / 2
            end
        end
    end
end

function skulls.assasin()
    -- Get all current spawned objects in the game
    local gameObjects = blam.getObjects()
    for objectId, objectIndex in pairs(gameObjects) do
        local object = blam.getObject(objectIndex)
        assert(object)
        if object.class == blam.objectClasses.biped then
            local biped = blam.biped(get_object(objectIndex))
            assert(biped)
            local tagFromList = table.find(bipeds, function (tag)
                return biped.tagId == tag.id
            end)
            if tagFromList then
                for _, keyword in pairs(keywords) do
                    if tagFromList.path:includes(keyword) then
                        if skulls.flags.assasin and biped.health >= 0 then
                            biped.invisible = true
                        else
                            biped.invisible = false
                        end
                    end
                end
            end
        end
    end
end

return skulls