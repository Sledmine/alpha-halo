-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local engine = Engine
local balltze = Balltze

local constants = {}

-- Constant core values
constants.localPlayerAddress = 0x815918

-- Constant gameplay values
constants.healthRegenerationAmount = 0.005
-- health recharged on 90 ticks or 3 seconds
constants.healthRegenAiAmount = 0.02
constants.raycastOffset = 0.3
constants.raycastVelocity = 80

constants.hsc = {
    playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]
}

constants.sounds = { 
    setStart = engine.tag.findTags("survival_new_set", engine.tag.classes.sound)[1]
}

constants.bipeds = {
    odstAllyTag = blam.findTag("odst", tagClasses.biped).path,
    covSpiritTurret = blam.findTag("cd_gun", tagClasses.biped).path
}

constants.vehicles = {
    ghostNormal = blam.findTag("gdd_ghost", tagClasses.vehicle).path,
    ghostFuelRod = blam.findTag("gdd_ghost_fuel_rod", tagClasses.vehicle).path,
    ghostNeedler = blam.findTag("gdd_ghost_needler", tagClasses.vehicle).path
}

return constants