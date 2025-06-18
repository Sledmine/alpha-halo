local engine = Engine
local balltze = Balltze
local tagClasses = Engine.tag.classes
local getTag = Engine.tag.getTag
local findTags = Engine.tag.findTags
local blam = require "blam"
local inspect = require "inspect"

local actorVariants = {}

actorVariants.covenant = {
    elite = {
        minorPR = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_minor\\elite_minor_plasma_rifle", tagClasses.actorVariant),
        minorNdlr = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_minor\\elite_minor_needler", tagClasses.actorVariant),
        majorPR = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_major\\elite_major_plasma_rifle", tagClasses.actorVariant),
        majorNdlr = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_major\\elite_major_needler", tagClasses.actorVariant),
        specOpsPR = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_specops\\elite_specops_plasma_rifle", tagClasses.actorVariant),
        specOpsNdlr = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_specops\\elite_specops_needler", tagClasses.actorVariant),
        stealthPR = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_stealth\\stealth_elite_plasma_rifle", tagClasses.actorVariant),
        stealthES = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_stealth\\stealth_elite_energy_sword", tagClasses.actorVariant),
        zealotES = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_zealot\\zealot_elite_energy_sword", tagClasses.actorVariant),
        zealotPC = getTag("alpha_firefight\\characters\\covenant\\elite\\elite_zealot\\zealot_elite_plasma_cannon", tagClasses.actorVariant),
    },
    grunt = {
        minorPP = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_minor\\grunt_minor_plasma_pistol", tagClasses.actorVariant),
        minorNdlr = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_minor\\grunt_minor_needler", tagClasses.actorVariant),
        majorPP = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_major\\grunt_major_plasma_pistol", tagClasses.actorVariant),
        majorNdlr = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_major\\grunt_major_needler", tagClasses.actorVariant),
        specOpsNdlr = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_specops\\grunt_specops_needler", tagClasses.actorVariant),
        specOpsFR = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_specops\\grunt_specops_fuel_rod", tagClasses.actorVariant),
        heavyFR = getTag("alpha_firefight\\characters\\covenant\\grunt\\grunt_heavy\\grunt_heavy_fuel_rod", tagClasses.actorVariant),
    },
    jackal = {
        minorPP = getTag("alpha_firefight\\characters\\covenant\\jackal\\jackal_minor\\jackal_minor_plasma_pistol", tagClasses.actorVariant),
        majorPP = getTag("alpha_firefight\\characters\\covenant\\jackal\\jackal_major\\jackal_major_plasma_pistol", tagClasses.actorVariant),
        scoutCarbine = getTag("alpha_firefight\\characters\\covenant\\jackal\\jackal_scout\\jackal_scout_carbine", tagClasses.actorVariant),
    },
    hunter = {
        hunter = getTag("alpha_firefight\\characters\\covenant\\hunter\\hunter", tagClasses.actorVariant),
    },
}

actorVariants.flood = {
    floodElite = {
        minorAR = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_minor\\flood_minor_assault_rifle", tagClasses.actorVariant),
        minorSG = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_minor\\flood_minor_shotgun", tagClasses.actorVariant),
        majorAR = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_major\\flood_major_assault_rifle", tagClasses.actorVariant),
        majorSG = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_major\\flood_major_shotgun", tagClasses.actorVariant),
        specOpsNdlr = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_specops\\flood_specops_needler", tagClasses.actorVariant),
        specOpsPR = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_specops\\flood_specops_plasma_rifle", tagClasses.actorVariant),
        stealthES = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_stealth\\flood_stealth_energy_sword", tagClasses.actorVariant),
        stealthUnarm = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_stealth\\flood_stealth_unarmed", tagClasses.actorVariant),
        zealotES = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_zealot\\flood_zealot_energy_sword", tagClasses.actorVariant),
        zealotRL = getTag("alpha_firefight\\characters\\flood\\flood_elite\\flood_zealot\\flood_zealot_rocket_launcher", tagClasses.actorVariant),
    },
    floodHuman = {
        humanBR = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_human\\flood_human_battle_rifle", tagClasses.actorVariant),
        humanPR = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_human\\flood_human_plasma_rifle", tagClasses.actorVariant),
        humanNdlr = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_human\\flood_human_needler", tagClasses.actorVariant),
        humanSS = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_human\\flood_human_short_shotgun", tagClasses.actorVariant),
        humanUnarm = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_human\\flood_human_unarmed", tagClasses.actorVariant),
        armoredFT = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_armored\\flood_armored_flame_thrower", tagClasses.actorVariant),
        armoredRL = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_armored\\flood_armored_rocket_launcher", tagClasses.actorVariant),
        armoredSR = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_armored\\flood_armored_sniper_rifle", tagClasses.actorVariant),
        odstFT = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_odst\\flood_odst_flame_thrower", tagClasses.actorVariant),
        odstRL = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_odst\\flood_odst_rocket_launcher", tagClasses.actorVariant),
        odstSR = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_odst\\flood_odst_sniper_rifle", tagClasses.actorVariant),
        odstSG = getTag("alpha_firefight\\characters\\flood\\flood_human\\flood_odst\\flood_odst_shotgun", tagClasses.actorVariant),
    },
    carrier = {
        carrier = getTag("alpha_firefight\\characters\\flood\\flood_carrier\\flood_carrier_minor", tagClasses.actorVariant),
    },
}

actorVariants.human = {
    odst = {
        shotgun = getTag("alpha_firefight\\characters\\human\\odst\\odst_armored_shotgun", tagClasses.actorVariant),
        sniper = getTag("alpha_firefight\\characters\\human\\odst\\odst_armored_sniper_rifle", tagClasses.actorVariant),
    },
}

actorVariants.sentinel = {
    sentinel = {
        sentinel = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        shieldedMajor = getTag("alpha_firefight\\characters\\sentinel\\sentinel_shielded_major", tagClasses.actorVariant),
    },
}

return actorVariants