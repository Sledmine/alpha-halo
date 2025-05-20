-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local engine = Engine
local balltze = Balltze
local findTags = engine.tag.findTags

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
    livesAdded = findTags("survival_awarded_lives2", engine.tag.classes.sound)[1],
    setStart = findTags("survival_new_set", engine.tag.classes.sound)[1],
    roundStart = findTags("survival_new_round", engine.tag.classes.sound)[1],
    reinforcements = findTags("survival_reinforcements", engine.tag.classes.sound)[1],
    roundCompleted = findTags("survival_end_round", engine.tag.classes.sound)[1],
    fiveLivesLeft = findTags("survival_5_lives_left", engine.tag.classes.sound)[1],
    oneLiveLeft = findTags("survival_1_life_left", engine.tag.classes.sound)[1],
    noLivesLeft = findTags("survival_0_lives_left", engine.tag.classes.sound)[1]
}

constants.bipeds = {
    odstAllyTag = findTags("mrchromed\\halo_2\\characters\\marine\\odst\\odst_h2", engine.tag.classes.biped)[1]
}

constants.vehicles = {
    ghostNormal = blam.findTag("gdd_ghost", tagClasses.vehicle).path,
    ghostFuelRod = blam.findTag("gdd_ghost_fuel_rod", tagClasses.vehicle).path,
    ghostNeedler = blam.findTag("gdd_ghost_needler", tagClasses.vehicle).path
}

constants.effect = {
    plasmaExplosion = findTags("weapons\\plasma grenade\\effects\\explosion", engine.tag.classes.effect)[1]
}

return constants