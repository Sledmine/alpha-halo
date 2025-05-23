local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags

local actorVariant = {}

function actorVariant.get()

    actorVariant.actorVariantTagEntries = {
        actorVariantElite = findTags("elite", tagClasses.actorVariant)[1],
        actorVariantGrunt = findTags("grunt", tagClasses.actorVariant)[1],
        actorVariantJackal = findTags("jackal", tagClasses.actorVariant)[1],
        actorVariantHunter = findTags("hunter", tagClasses.actorVariant)[1],
        actorVariantFlood = findTags("flood", tagClasses.actorVariant)[1],
        actorVariantSentinel = findTags("sentinel", tagClasses.actorVariant)[1],
        actorVariantOdst = findTags("odst", tagClasses.actorVariant)[1],
    }

end

return actorVariant