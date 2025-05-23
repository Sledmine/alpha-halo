local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags

local weapon = {}

function weapon.get()

    local weaponTagEntries = findTags("", tagClasses.weapon)
    assert(weaponTagEntries)
    do return weaponTagEntries end

end

return weapon