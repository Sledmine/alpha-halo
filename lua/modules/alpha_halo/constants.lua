local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

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
    --humanRifleZoomIn = blam.findTag("007_human_rifle_zoom_in", tagClasses.sound).path,
    --humanRifleZoomOut = blam.findTag("007_human_rifle_zoom_out", tagClasses.sound).path
}

constants.bipeds = {
    odstAllyTag = blam.findTag("alpha_firefight\\characters\\human\\marine\\marine_odst\\odst", tagClasses.biped),
    covSpiritTurret = blam.findTag("vehicles\\c_dropship\\cd_gun\\cd_gun", tagClasses.biped)
}

constants.vehicles = {
    ghostNormal = blam.findTag("gdd\\vehicles\\ghost\\gdd_ghost", tagClasses.vehicle),
    ghostFuelRod = blam.findTag("gdd\\vehicles\\ghost fuel rod\\gdd_ghost_fuel_rod", tagClasses.vehicle),
    ghostNeedler = blam.findTag("gdd\\vehicles\\ghost needler\\gdd_ghost_needler", tagClasses.vehicle)
}

return constants