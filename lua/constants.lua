local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

constants.tags = {}

constants.tags.vehicles = {
    armor_lock = findTag("armor_lock", tagClasses.vehicle)
}

return constants