-- 📁 modules/project_modules/systems/firefight/manager.lua
local engine = Engine
local balltze = Balltze
local hsc = require "hsc"
local script = require "script"
local actorVariants = require "alpha_halo.systems.core.actorVariants"
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local getTag = Engine.tag.getTag

local unitDeployer = {}

------------------------------------------------------------
------ Covenant Fireteams ------
------------------------------------------------------------
local nullHandle = 0xFFFFFFFF
local elite = actorVariants.covenant.elite
local grunt = actorVariants.covenant.grunt
local jackal = actorVariants.covenant.jackal
local hunter = actorVariants.covenant.hunter
unitDeployer.covenantFireteams = {
    startingSquad = {
        name = "Starting Squad",
        random = false,
        --unit1 = grunt.majorNdlr.handle.value,
        --unit2 = grunt.majorPP.handle.value,
        --unit3 = grunt.minorNdlr.handle.value,
        --unit4 = grunt.minorNdlr.handle.value,
        --unit5 = grunt.minorPP.handle.value,
        --unit6 = grunt.minorPP.handle.value,
        --unit7 = grunt.minorPP.handle.value,
        --unit8 = grunt.minorPP.handle.value,
    },
    eliteSquad = {
        name = "Elite Squad",
        random = true,
        --unit1 = elite.majorNdlr.handle.value,
        --unit2 = elite.majorPR.handle.value,
        --unit3 = elite.minorNdlr.handle.value,
        --unit4 = elite.minorPR.handle.value,
        --unit5 = elite.minorPR.handle.value,
        --unit6 = elite.minorPR.handle.value,
        --unit7 = elite.minorPR.handle.value,
        --unit8 = elite.minorPR.handle.value,
    },
    stealthSquad = {
        name = "Stealth Squad",
        random = true,
        --unit1 = elite.stealthES.handle.value,
        --unit2 = elite.stealthES.handle.value,
        --unit3 = elite.stealthPR.handle.value,
        --unit4 = elite.stealthPR.handle.value,
        --unit5 = elite.stealthPR.handle.value,
        --unit6 = elite.stealthPR.handle.value,
        --unit7 = elite.stealthPR.handle.value,
        --unit8 = elite.stealthPR.handle.value,
    },
    gruntSquad = {
        name = "Grunt Squad",
        random = true,
        --unit1 = grunt.heavyFR.handle.value,
        --unit2 = grunt.heavyFR.handle.value,
        --unit3 = grunt.majorNdlr.handle.value,
        --unit4 = grunt.majorPP.handle.value,
        --unit5 = grunt.minorNdlr.handle.value,
        --unit6 = grunt.minorPP.handle.value,
        --unit7 = grunt.minorPP.handle.value,
        --unit8 = grunt.minorPP.handle.value,
    },
    jackalSquad = {
        name = "Jackal Squad",
        random = true,
        --unit1 = jackal.scoutCarbine.handle.value,
        --unit2 = jackal.scoutCarbine.handle.value,
        --unit3 = jackal.majorPP.handle.value,
        --unit4 = jackal.majorPP.handle.value,
        --unit5 = jackal.minorPP.handle.value,
        --unit6 = jackal.minorPP.handle.value,
        --unit7 = jackal.minorPP.handle.value,
        --unit8 = jackal.minorPP.handle.value,
    },
    hunterSquad = {
        name = "Hunter Squad",
        random = true,
        --unit1 = hunter.hunter.handle.value,
        --unit2 = hunter.hunter.handle.value,
        --unit3 = grunt.minorNdlr.handle.value,
        --unit4 = grunt.majorPP.handle.value,
        --unit5 = grunt.minorPP.handle.value,
        --unit6 = grunt.minorPP.handle.value,
        --unit7 = nullHandle,
        --unit8 = nullHandle,
    },
    specOpsSquad = {
        name = "Spec Ops Squad",
        random = false,
        --unit1 = elite.specOpsNdlr.handle.value,
        --unit2 = elite.specOpsPR.handle.value,
        --unit3 = elite.specOpsPR.handle.value,
        --unit4 = grunt.specOpsFR.handle.value,
        --unit5 = grunt.specOpsNdlr.handle.value,
        --unit6 = grunt.specOpsNdlr.handle.value,
        --unit7 = grunt.specOpsNdlr.handle.value,
        --unit8 = grunt.specOpsNdlr.handle.value,
    },
    zealotSquad = {
        name = "Zealot Squad",
        random = false,
        --unit1 = elite.zealotES.handle.value,
        --unit2 = elite.zealotES.handle.value,
        --unit3 = elite.zealotPC.handle.value,
        --unit4 = elite.zealotPC.handle.value,
        --unit5 = nullHandle,
        --unit6 = nullHandle,
        --unit7 = nullHandle,
        --unit8 = nullHandle,
    },
}

------------------------------------------------------------
------ Flood Fireteams ------
------------------------------------------------------------
local floodHuman = actorVariants.flood.floodHuman
local floodElite = actorVariants.flood.floodElite
local carrier = actorVariants.flood.carrier
unitDeployer.floodFireteams = {
    startingSquad = {
        name = "Starting Squad",
        random = false,
        --unit1 = floodHuman.humanPR.handle.value,
        --unit2 = floodHuman.humanPR.handle.value,
        --unit3 = floodHuman.humanNdlr.handle.value,
        --unit4 = floodHuman.humanNdlr.handle.value,
        --unit5 = floodHuman.humanUnarm.handle.value,
        --unit6 = floodHuman.humanUnarm.handle.value,
        --unit7 = floodHuman.humanUnarm.handle.value,
        --unit8 = floodHuman.humanUnarm.handle.value,
    },
    humanFlame = {
        name = "Human Flame Squad",
        random = true,
        --unit1 = floodHuman.armoredFT.handle.value,
        --unit2 = floodHuman.armoredFT.handle.value,
        --unit3 = floodHuman.humanSS.handle.value,
        --unit4 = floodHuman.humanSS.handle.value,
        --unit5 = floodHuman.humanSS.handle.value,
        --unit6 = floodHuman.humanSS.handle.value,
        --unit7 = floodHuman.humanSS.handle.value,
        --unit8 = floodHuman.humanSS.handle.value,
    },
    humanSniper = {
        name = "Human Sniper Squad",
        random = true,
        --unit1 = floodHuman.armoredSR.handle.value,
        --unit2 = floodHuman.armoredSR.handle.value,
        --unit3 = floodHuman.humanBR.handle.value,
        --unit4 = floodHuman.humanBR.handle.value,
        --unit5 = floodHuman.humanBR.handle.value,
        --unit6 = floodHuman.humanBR.handle.value,
        --unit7 = floodHuman.humanBR.handle.value,
        --unit8 = floodHuman.humanBR.handle.value,
    },
    humanRocket = {
        name = "Human Rocket Squad",
        random = true,
        --unit1 = floodHuman.armoredRL.handle.value,
        --unit2 = floodHuman.armoredRL.handle.value,
        --unit3 = floodHuman.humanUnarm.handle.value,
        --unit4 = floodHuman.humanUnarm.handle.value,
        --unit5 = floodHuman.humanUnarm.handle.value,
        --unit6 = floodHuman.humanUnarm.handle.value,
        --unit7 = floodHuman.humanUnarm.handle.value,
        --unit8 = floodHuman.humanUnarm.handle.value,
    },
    eliteSquad = {
        name = "Elite Squad",
        random = true,
        --unit1 = floodElite.minorAR.handle.value,
        --unit2 = floodElite.minorAR.handle.value,
        --unit3 = floodElite.minorAR.handle.value,
        --unit4 = floodElite.minorAR.handle.value,
        --unit5 = floodElite.minorSG.handle.value,
        --unit6 = floodElite.minorSG.handle.value,
        --unit7 = floodElite.majorAR.handle.value,
        --unit8 = floodElite.majorSG.handle.value,
    },
    stealthSquad = {
        name = "Stealth Squad",
        random = true,
        --unit1 = floodElite.stealthES.handle.value,
        --unit2 = floodElite.stealthES.handle.value,
        --unit3 = floodElite.stealthUnarm.handle.value,
        --unit4 = floodElite.stealthUnarm.handle.value,
        --unit5 = floodElite.stealthUnarm.handle.value,
        --unit6 = floodElite.stealthUnarm.handle.value,
        --unit7 = floodElite.stealthUnarm.handle.value,
        --unit8 = floodElite.stealthUnarm.handle.value,
    },
    carrierSquad = {
        name = "Carrier Squad",
        random = true,
        --unit1 = floodHuman.humanPR.handle.value,
        --unit2 = floodHuman.humanPR.handle.value,
        --unit3 = floodHuman.humanNdlr.handle.value,
        --unit4 = floodHuman.humanNdlr.handle.value,
        --unit5 = carrier.carrier.handle.value,
        --unit6 = carrier.carrier.handle.value,
        --unit7 = nullHandle,
        --unit8 = nullHandle,
    },
    specOpsSquad = {
        name = "Spec Ops Squad",
        random = false,
        --unit1 = floodElite.specOpsNdlr.handle.value,
        --unit2 = floodElite.specOpsNdlr.handle.value,
        --unit3 = floodElite.specOpsPR.handle.value,
        --unit4 = floodElite.specOpsPR.handle.value,
        --unit5 = floodHuman.odstSG.handle.value,
        --unit6 = floodHuman.odstSG.handle.value,
        --unit7 = floodHuman.odstSG.handle.value,
        --unit8 = floodHuman.odstSG.handle.value,
    },
    zealotSquad = {
        name = "Zealot Squad",
        random = false,
        --unit1 = floodElite.zealotES.handle.value,
        --unit2 = floodElite.zealotES.handle.value,
        --unit3 = floodElite.zealotRL.handle.value,
        --unit4 = floodElite.zealotRL.handle.value,
        --unit5 = nullHandle,
        --unit6 = nullHandle,
        --unit7 = nullHandle,
        --unit8 = nullHandle,
    },
}

------------------------------------------------------------
------ Human Fireteams ------
------------------------------------------------------------
local odst = actorVariants.human.odst
unitDeployer.humanFireteams = {
    odstSquad = {
        name = "ODST Squad",
        random = false,
        --unit1 = odst.sniper.handle.value,
        --unit2 = odst.sniper.handle.value,
        --unit3 = odst.shotgun.handle.value,
        --unit4 = odst.shotgun.handle.value,
        --unit5 = odst.shotgun.handle.value,
        --unit6 = odst.shotgun.handle.value,
        --unit7 = odst.shotgun.handle.value,
        --unit8 = odst.shotgun.handle.value,
    },
}

------------------------------------------------------------
------ Sentinel Fireteams ------
------------------------------------------------------------
--local sentinel = actorVariants.sentinel.sentinel
unitDeployer.sentinelFireteams = {
    sentinelSquad = {
        name = "Sentinel Squad",
        random = true, -- this should be false but right now its true for debug purposes.
        unit1 = getTag("alpha_firefight\\characters\\sentinel\\sentinel_shielded_major", tagClasses.actorVariant),
        unit2 = getTag("alpha_firefight\\characters\\sentinel\\sentinel_shielded_major", tagClasses.actorVariant),
        unit3 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        unit4 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        unit5 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        unit6 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        unit7 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
        unit8 = getTag("alpha_firefight\\characters\\sentinel\\sentinel", tagClasses.actorVariant),
    },
}

local sentinelFireteamsList = {
    unitDeployer.sentinelFireteams.sentinelSquad,
}

------------------------------------------------------------
------ Squad Assembler ------
------------------------------------------------------------
Deployer = {
    squadsAsigned = 3,
    squadsLeft = 3, -- This should be equal to squadsAsigned
    squadTemplate = "Here goes stylized squad name template",
    dropshipsAsigned = 3,
    dropshipsLeft = 3, -- This should be equal to dropshipsAsigned
    dropshipTemplate = "dropship_%s_1",
    deploymentAllowed = true
}

function unitDeployer.squadAssembler()
    ---- We get the scenario & its actor palette elements.
    --local scenario = engine.tag.getTag(0, engine.tag.classes.scenario)
    --assert(scenario)
    --local actorsPalette = scenario.data.actorPalette
    ---- Get Fireteams labbed as random and randomize them.
    --local randomFireteams = table.filter(sentinelFireteamsList, function(fireteam)
    --    return fireteam.random
    --end)
    --if #randomFireteams == 0 then
    --    logger:warning("No Fireteams available for randomization.")
    --    return
    --end
    --local selectedTeam = randomFireteams[math.random(#randomFireteams)]
    ---- We're trying to change the value from the actor palette to match the value of the tag referenced here.
    --actorsPalette.elements[1].reference.tagHandle.value = selectedTeam.unit1.handle.value
    --actorsPalette.elements[2].reference.tagHandle.value = selectedTeam.unit2.handle.value
    --actorsPalette.elements[3].reference.tagHandle.value = selectedTeam.unit3.handle.value
    --actorsPalette.elements[4].reference.tagHandle.value = selectedTeam.unit4.handle.value
    --actorsPalette.elements[5].reference.tagHandle.value = selectedTeam.unit5.handle.value
    --actorsPalette.elements[6].reference.tagHandle.value = selectedTeam.unit6.handle.value
    --actorsPalette.elements[7].reference.tagHandle.value = selectedTeam.unit7.handle.value
    --actorsPalette.elements[8].reference.tagHandle.value = selectedTeam.unit8.handle.value
    --selectedTeam.random = false
    --logger:info("Selected Fireteam: " .. selectedTeam.name)
    ---- EVENTUALLY WE WILL USE ALL THIS SHIT ABOVE TO AI_PLACE, BUT RN IS NOT WORKING ----
    if Deployer.dropshipsLeft > 0 then
        hsc.ai_place("test_encounter/test_squad")
        local selectedDropship = Deployer.dropshipTemplate:format(Deployer.dropshipsLeft)
        hsc.object_create_anew(selectedDropship)
        hsc.ai_place("Enemy_Team_1/Spirit_Gunner")
        hsc.vehicle_load_magic(selectedDropship, "gunseat", hsc.ai_actors("Enemy_Team_1/Spirit_Gunner"))
        hsc.ai_migrate("Enemy_Team_1/Spirit_Gunner", "Covenant_Support")
        hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors("test_encounter/test_squad"))
        hsc.custom_animation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, false)
        hsc.ai_migrate("test_encounter/test_squad", "Covenant_Wave")
        Deployer.dropshipsLeft = Deployer.dropshipsLeft - 1
        unitDeployer.squadAssembler()
    else
        logger:debug("All Dropships have been sent!")
        Deployer.dropshipsLeft = Deployer.dropshipsAsigned
        Deployer.deploymentAllowed = false -- Gotta find a way to cap this if deploymentAllowed is false. Something else than yet another if.
        script.startup(unitDeployer.aiExitVehicle)
    end
end

function unitDeployer.aiExitVehicle(call, sleep)
    sleep(720)
    hsc.ai_exit_vehicle("Covenant_Wave")
    Deployer.deploymentAllowed = true
end

------------------------------------------------------------
------ Legacy Stuff ------
------------------------------------------------------------
--function unitDeployer.pelicanDeployer(call, sleep)
--    sleep(700)
--    hsc.ai_place("Human_Team/ODSTs")
--    hsc.ai_place("human_support/pelican_pilot")
--    hsc.object_create_anew("foehammer_cliff")
--    hsc.vehicle_load_magic("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs"))
--    hsc.vehicle_load_magic("foehammer_cliff", "driver", hsc.ai_actors("human_support/pelican_pilot"))
--    hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
--    --sleep(30)
--    hsc.unit_set_enterable_by_player("foehammer_cliff", false)
--    hsc.unit_close("foehammer_cliff")
--    hsc.object_teleport("foehammer_cliff", "foehammer_cliff_flag")
--    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), true)
--    hsc.recording_play_and_hover( "foehammer_cliff", "foehammer_cliff_in")
--    sleep(1200)
--    hsc.unit_open("foehammer_cliff")
--    sleep(90)
--    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), false)
--    hsc.vehicle_unload("foehammer_cliff", "rider")
--    sleep(120)
--    if not hsc.vehicle_test_seat_list("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs")) then
--        hsc.unit_close("foehammer_cliff")
--        sleep(120)
--        hsc.vehicle_hover("foehammer_cliff", false)
--        hsc.recording_play_and_delete("foehammer_cliff", "foehammer_cliff_out")
--    end
--end

return unitDeployer
