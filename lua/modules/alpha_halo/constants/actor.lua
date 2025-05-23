local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags

local actor = {}

function actor.get()

    actor.actorTag = {
        actorElite = findTags("elite", tagClasses.actor)[1],
        actorGrunt = findTags("grunt", tagClasses.actor)[1],
        actorJackal = findTags("jackal", tagClasses.actor)[1],
        actorHunter = findTags("hunter", tagClasses.actor)[1],
        actorFlood = findTags("flood", tagClasses.actor)[1],
        actorSentinel = findTags("sentinel", tagClasses.actor)[1],
        actorOdst = findTags("odst", tagClasses.actor)[1],
    }

end

return actor