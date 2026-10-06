-- Lua libraries
local engine = Engine
local utils = require "alpha_halo.utils"

local constants = {}

-- Balltze v2's Engine.tag.lookupTag only accepts a full tag path. For name-based lookups,
-- use Engine.tag.filterTags(group, pathFilter) instead; it searches tag paths by substring.
local function lookupTag(path, group)
    return engine.tag.filterTags(group, path)[1]
end

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
constants.maximumObjectsCount = 4096

constants.hsc = {playSound = [[(begin (sound_impulse_start "%s" (list_get (players) %s) %s))]]}

function constants.get()
    constants.sounds = {
        livesAdded = lookupTag("survival_awarded_lives2", "sound"),
        setStart = lookupTag("survival_new_set", "sound"),
        roundStart = lookupTag("survival_new_round", "sound"),
        reinforcements = lookupTag("survival_reinforcements", "sound"),
        roundCompleted = lookupTag("survival_end_round", "sound"),
        fiveLivesLeft = lookupTag("survival_5_lives_left", "sound"),
        oneLiveLeft = lookupTag("survival_1_life_left", "sound"),
        noLivesLeft = lookupTag("survival_0_lives_left", "sound"),
        skullOn = lookupTag("skull_on", "sound"),
        skullsOn = lookupTag("skulls_on", "sound"),
        skullsReset = lookupTag("skulls_reset", "sound"),
        goldenSkullOn = lookupTag("skull_golden_on", "sound"),
        enemySniper = lookupTag("survival_enemy_sniper_incoming", "sound"),
        enemyIncoming = lookupTag("survival_enemy_incoming", "sound"),
        hillMove = lookupTag("hill_move", "sound"),
    }

    constants.music = {
        drumrun = lookupTag("drumrun", "sound_looping"),
        -- TODO Add proper stop sound into sound loops
        covenantDance = lookupTag("covenant_dance", "sound_looping"),
        onAPaleHorse = lookupTag("on_a_pale_horse", "sound_looping"),
        theLongRun = lookupTag("the_long_run", "sound_looping"),
        aWalkInTheWoods = lookupTag("a_walk_in_the_woods", "sound_looping"),
    }

    constants.bipeds = {
        odstAllyTag = lookupTag("mrchromed\\halo_2\\characters\\marine\\odst\\odst_h2",
                                "biped")
    }

    constants.fonts = {
        geogrotesqueRegular = {
            title = lookupTag("geogrotesque-regular-title", "font"),
            subtitle = lookupTag("geogrotesque-regular-subtitle", "font"),
            text = lookupTag("geogrotesque-regular-text", "font"),
            smaller = lookupTag("geogrotesque-regular-smaller", "font")
        }
    }

    constants.hud = {
        skullsIcons = lookupTag([[alpha_firefight\ui\chud\skulls_icons]], "weapon_hud_interface"),
        skullsInfo = lookupTag([[alpha_firefight\ui\chud\skulls_info]], "weapon_hud_interface"),
        extBeamRifle = lookupTag([[alpha_firefight\weapons\beam_rifle\beam_rifle_ext_meters]], "weapon_hud_interface"),
        extSniperRifle = lookupTag([[alpha_firefight\weapons\sniper_rifle\sniper_rifle_ext_meters]], "weapon_hud_interface"),
        extAssaultRifle = lookupTag([[alpha_firefight\weapons\assault_rifle\assault_rifle]], "weapon_hud_interface"),
    }

    constants.weapons = {
        beamRifle = lookupTag([[alpha_firefight\weapons\beam_rifle\beam_rifle]], "weapon"),
        sniperRifle = lookupTag([[weapons\sniper_rifle\sniper_rifle]], "weapon")
    }

    constants.shaders = {
        transparentChicago = {
            brCounter = lookupTag([[gdd\weapons\battle_rifle\shaders\br_numbers]], "shader_transparent_chicago"),
            glCounter = lookupTag([[alpha_firefight\weapons\assault_rifle_gl\shaders\gl_numers]], "shader_transparent_chicago")
        }
    }
end

return constants
