local engine = Engine
local balltze = Balltze
local const = require "alpha_halo.systems.core.constants"
local utils = require "alpha_halo.utils"
local hsc = require "hsc"
local blam2 = require "blam2"
--local playSound = engine.userInterface.playSound
local playSound = function (soundTagHandle)
    local tag = blam2.tag.getTag(soundTagHandle, blam2.tag.groups.sound)
    assert(tag)
    hsc.sound_impulse_start(tag.path, "none", 1)
end
local script = require "script"
local sleep = script.sleep

local announcer = {}

function announcer.setStart()
    playSound(const.sounds.setStart.handle.value)
end

function announcer.roundStart()
    playSound(const.sounds.roundStart.handle.value)
end

function announcer.reinforcements()
    playSound(const.sounds.reinforcements.handle.value)
end

function announcer.roundCompleted()
    sleep(1)
    playSound(const.sounds.roundCompleted.handle.value)
end

function announcer.fiveLivesLeft()
    sleep(1)
    playSound(const.sounds.fiveLivesLeft.handle.value)
end

function announcer.oneLiveLeft()
    sleep(1)
    playSound(const.sounds.oneLiveLeft.handle.value)
end

function announcer.noLivesLeft()
    sleep(1)
    playSound(const.sounds.noLivesLeft.handle.value)
end

function announcer.livesAdded()
    sleep(1)
    playSound(const.sounds.livesAdded.handle.value)
end

function announcer.skullOn()
    sleep(1)
    playSound(const.sounds.skullOn.handle.value)
end

function announcer.skullOnDelay()
    sleep(70) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.skullOn.handle.value)
end

-- This function is called when multiple skulls are activated
function announcer.skullsOn()
    sleep(1)
    playSound(const.sounds.skullsOn.handle.value)
end

-- This function is called when multiple skulls are activated after a delay
function announcer.skullsOnDelay()
    sleep(70) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.skullsOn.handle.value)
end

function announcer.skullsReset(delay)
    script.startup(function ()
        sleep(utils.secondsToTicks(delay or 1))
        playSound(const.sounds.skullsReset.handle.value)
    end)
end

function announcer.skullsResetDelay()
    sleep(150) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.skullsReset.handle.value)
end

function announcer.goldenSkullOn()
    sleep(1)
    playSound(const.sounds.goldenSkullOn.handle.value)
end

function announcer.goldenSkullOnDelay()
    sleep(70) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.goldenSkullOn.handle.value)
end

function announcer.enemySniper()
    sleep(1)
    playSound(const.sounds.enemySniper.handle.value)
end

-- This function is called when a surprise enemy is incoming (banshee or wraith/mortar)
function announcer.enemyIncoming()
    sleep(1)
    playSound(const.sounds.enemyIncoming.handle.value)
end

return announcer