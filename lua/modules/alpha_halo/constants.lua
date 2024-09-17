local blam = require "blam"
local tagClasses = blam.tagClasses
local findTag = blam.findTag

local constants = {}

-- Constant core values
constants.localPlayerAddress = 0x815918

-- Constant gameplay values
constants.healthRegenerationAmount = 0.0037
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
    odstAllyTag = blam.findTag("odst", tagClasses.biped)
}

return constants