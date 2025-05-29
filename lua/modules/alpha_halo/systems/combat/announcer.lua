local engine = Engine
local balltze = Balltze
local script = require "script"
local const = require "alpha_halo.systems.core.constants"
local playSound = engine.userInterface.playSound

local announcer = {}

function announcer.setStart(call, sleep)
    sleep(1)
    playSound(const.sounds.setStart.handle)
end

function announcer.roundStart(call, sleep)
    sleep(1)
    playSound(const.sounds.roundStart.handle)
end

function announcer.reinforcements(call, sleep)
    sleep(1)
    playSound(const.sounds.reinforcements.handle)
end

function announcer.roundCompleted(call, sleep)
    sleep(1)
    playSound(const.sounds.roundCompleted.handle)
end

function announcer.fiveLivesLeft(call, sleep)
    sleep(1)
    playSound(const.sounds.fiveLivesLeft.handle)
end

function announcer.oneLiveLeft(call, sleep)
    sleep(1)
    playSound(const.sounds.oneLiveLeft.handle)
end

function announcer.noLivesLeft(call, sleep)
    sleep(1)
    playSound(const.sounds.noLivesLeft.handle)
end

function announcer.skullOn(call, sleep)
    sleep(1)
    playSound(const.sounds.skullOn.handle)
end

function announcer.skullOnDelay(call, sleep)
    sleep(70) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.skullOn.handle)
end

function announcer.skullsReset(call, sleep)
    sleep(1)
    playSound(const.sounds.skullsReset.handle)
end

function announcer.skullsResetDelay(call, sleep)
    sleep(150) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.skullsReset.handle)
end

function announcer.goldenSkullOn(call, sleep)
    sleep(1)
    playSound(const.sounds.goldenSkullOn.handle)
end

function announcer.goldenSkullOnDelay(call, sleep)
    sleep(70) -- Wait for 120 ticks before playing the sound
    playSound(const.sounds.goldenSkullOn.handle)
end

function announcer.enemySniper(call, sleep)
    sleep(1)
    playSound(const.sounds.enemySniper.handle)
end

-- This function is called when a surprise enemy is incoming (banshee or wraith/mortar)
function announcer.enemyIncoming(call, sleep)
    sleep(1)
    playSound(const.sounds.enemyIncoming.handle)
end

return announcer