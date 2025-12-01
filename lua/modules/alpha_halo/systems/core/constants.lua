-- Lua libraries
local blam = require "blam"
local tagClasses = blam.tagClasses
local engine = Engine
local balltze = Balltze
local findTags = engine.tag.findTags
local utils = require "alpha_halo.utils"

local constants = {}

-- Constant gameplay values
constants.healthRegenerationAmount = 0.005
-- health recharged on 90 ticks or 3 seconds
constants.healthRegenAiAmount = 0.02
constants.raycastOffset = 0.3
constants.raycastVelocity = 80
constants.pelicanDeploymentDelay = utils.secondsToTicks(0)
constants.dropshipDeploymentDelay = utils.secondsToTicks(5)
constants.dropshipDeploymentDropTick = 950 -- Tick when the units will drop from the dropship
constants.dropshipDelayTicks = utils.secondsToTicks(20) -- Delay between each dropship deployment
constants.maximumMusicTime = utils.minutesToTicks(3) -- Maximum time a music track can play

constants.hsc = {playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]}

function constants.get()
    constants.sounds = {
        livesAdded = findTags("survival_awarded_lives2", engine.tag.classes.sound)[1],
        setStart = findTags("survival_new_set", engine.tag.classes.sound)[1],
        roundStart = findTags("survival_new_round", engine.tag.classes.sound)[1],
        reinforcements = findTags("survival_reinforcements", engine.tag.classes.sound)[1],
        roundCompleted = findTags("survival_end_round", engine.tag.classes.sound)[1],
        fiveLivesLeft = findTags("survival_5_lives_left", engine.tag.classes.sound)[1],
        oneLiveLeft = findTags("survival_1_life_left", engine.tag.classes.sound)[1],
        noLivesLeft = findTags("survival_0_lives_left", engine.tag.classes.sound)[1],
        skullOn = findTags("skull_on", engine.tag.classes.sound)[1],
        skullsOn = findTags("skulls_on", engine.tag.classes.sound)[1],
        skullsReset = findTags("skulls_reset", engine.tag.classes.sound)[1],
        goldenSkullOn = findTags("skull_golden_on", engine.tag.classes.sound)[1],
        enemySniper = findTags("survival_enemy_sniper_incoming", engine.tag.classes.sound)[1],
        enemyIncoming = findTags("survival_enemy_incoming", engine.tag.classes.sound)[1],
        hillMove = findTags("hill_move", engine.tag.classes.sound)[1],
    }

    constants.music = {
        drumrun = findTags("drumrun", engine.tag.classes.soundLooping)[1],
        covenantDance = findTags("covenant_dance", engine.tag.classes.soundLooping)[1],
        onAPaleHorse = findTags("on_a_pale_horse", engine.tag.classes.soundLooping)[1],
        theLongRun = findTags("the_long_run", engine.tag.classes.soundLooping)[1]
    }

    constants.bipeds = {
        odstAllyTag = findTags("mrchromed\\halo_2\\characters\\marine\\odst\\odst_h2",
                               engine.tag.classes.biped)[1]
    }

    constants.fonts = {
        geogrotesqueRegular = {
            title = findTags("geogrotesque-regular-title", engine.tag.classes.font)[1],
            subtitle = findTags("geogrotesque-regular-subtitle", engine.tag.classes.font)[1],
            text = findTags("geogrotesque-regular-text", engine.tag.classes.font)[1],
            smaller = findTags("geogrotesque-regular-smaller", engine.tag.classes.font)[1]
        }
    }

    constants.hud = {
        skullsIcons = findTags([[alpha_firefight\ui\chud\skulls_icons]], engine.tag.classes.weaponHudInterface)[1],
        skullsInfo = findTags([[alpha_firefight\ui\chud\skulls_info]], engine.tag.classes.weaponHudInterface)[1],
        extBeamRifle = findTags([[alpha_firefight\weapons\beam_rifle\beam_rifle_ext_meters]], engine.tag.classes.weaponHudInterface)[1],
        extSniperRifle = findTags([[alpha_firefight\weapons\sniper_rifle\sniper_rifle_ext_meters]], engine.tag.classes.weaponHudInterface)[1]
    }

    constants.weapons = {
        beamRifle = findTags([[alpha_firefight\weapons\beam_rifle\beam_rifle]], engine.tag.classes.weapon)[1],
        sniperRifle = findTags([[weapons\sniper_rifle\sniper_rifle]], engine.tag.classes.weapon)[1]
    }
end

return constants
