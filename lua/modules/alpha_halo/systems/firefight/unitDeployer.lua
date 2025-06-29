-- 📁 modules/project_modules/systems/firefight/manager.lua
local engine = Engine
local balltze = Balltze
local hsc = require "hsc"
local script = require "script"
--local actorVariants = require "alpha_halo.systems.core.actorVariants"
--local tagClasses = Engine.tag.classes
--local findTags = Engine.tag.findTags
--local getTag = Engine.tag.getTag

local unitDeployer = {}

------------------------------------------------------------
------ Covenant Fireteams ------
------------------------------------------------------------
unitDeployer.covenantFireteams = {
    startingSquad = {
        name = "Covenant_Fireteams/Starting_Squad",
        random = false,
        available = true,
    },
    eliteSquad = {
        name = "Covenant_Fireteams/Elite_Squad",
        random = true,
        available = true,
    },
    stealthSquad = {
        name = "Covenant_Fireteams/Stealth_Squad",
        random = true,
        available = true,
    },
    gruntSquad = {
        name = "Covenant_Fireteams/Grunt_Squad",
        random = true,
        available = true,
    },
    jackalSquad = {
        name = "Covenant_Fireteams/Jackal_Squad",
        random = true,
        available = true,
    },
    hunterSquad = {
        name = "Covenant_Fireteams/Hunter_Squad",
        random = true,
        available = true,
    },
    specOpsSquad = {
        name = "Covenant_Fireteams/SpecOps_Squad",
        random = false,
        available = true,
    },
    zealotSquad = {
        name = "Covenant_Fireteams/Zealot_Squad",
        random = false,
        available = true,
    },
}

local covenantList = {
    unitDeployer.covenantFireteams.startingSquad,
    unitDeployer.covenantFireteams.eliteSquad,
    unitDeployer.covenantFireteams.stealthSquad,
    unitDeployer.covenantFireteams.gruntSquad,
    unitDeployer.covenantFireteams.jackalSquad,
    unitDeployer.covenantFireteams.hunterSquad,
    unitDeployer.covenantFireteams.specOpsSquad,
    unitDeployer.covenantFireteams.zealotSquad,
}

------------------------------------------------------------
------ Flood Fireteams ------
------------------------------------------------------------
unitDeployer.floodFireteams = {
    startingSquad = {
        name = "Starting Squad",
        random = false,
        available = true,
    },
    humanFlame = {
        name = "Human Flame Squad",
        random = true,
        available = true,
    },
    humanSniper = {
        name = "Human Sniper Squad",
        random = true,
        available = true,
    },
    humanRocket = {
        name = "Human Rocket Squad",
        random = true,
        available = true,
    },
    eliteSquad = {
        name = "Elite Squad",
        random = true,
        available = true,
    },
    stealthSquad = {
        name = "Stealth Squad",
        random = true,
        available = true,
    },
    carrierSquad = {
        name = "Carrier Squad",
        random = true,
        available = true,
    },
    specOpsSquad = {
        name = "Spec Ops Squad",
        random = false,
        available = true,
    },
    zealotSquad = {
        name = "Zealot Squad",
        random = false,
        available = true,
    },
}

------------------------------------------------------------
------ Human Fireteams ------
------------------------------------------------------------
unitDeployer.humanFireteams = {
    odstSquad = {
        name = "ODST Squad",
        random = false,
        available = true,
    },
}

------------------------------------------------------------
------ Sentinel Fireteams ------
------------------------------------------------------------
unitDeployer.sentinelFireteams = {
    sentinelSquad = {
        name = "Sentinel Squad",
        random = false,
        available = true,
    },
}

------------------------------------------------------------
------ Wave Deployer ------
------------------------------------------------------------
Deployer = {
    dropshipsAsigned = 3,
    dropshipsLeft = 3, -- This should be equal to dropshipsAsigned
    dropshipTemplate = "dropship_%s_1",
    deploymentAllowed = true
}

local randomizedTeam
local canRandomize = true
-- Call Wave Deployer based on the type of wave we're on.
---@param waveType string | "starting" | "boss" | "random"
function unitDeployer.waveDeployer(waveType)
    local selectedTeam -- We're gonna define this and then do stuff with it.
    local currentWaveType = waveType -- We want to know which type of wave we've been called.

    -- Check if the waveType is valid
    if not waveType then
        logger:error(
            "WRONG! Usage: squad_assembler [ <starting> | <boss> | <random> ]")
        return
    end

    -- If we're on a starting wave...
    if waveType:lower() == "starting" then
        -- The 3 Dropships drops Starting Squads!
        selectedTeam = unitDeployer.covenantFireteams.startingSquad.name
        logger:info("Starting Fireteam: " .. selectedTeam)
    end

    -- If we're on a boss wave...
    if waveType:lower() == "boss" then
        if Deployer.dropshipsLeft == Deployer.dropshipsAsigned then
            -- The first Dropship will drop a Zealot Squad, and...
            selectedTeam = unitDeployer.covenantFireteams.zealotSquad.name
            logger:info("Bodyguard Fireteam: " .. selectedTeam)
        else
            -- The rest of them will deploy SpecOps Squads!
            selectedTeam = unitDeployer.covenantFireteams.specOpsSquad.name
            logger:info("Boss Fireteam: " .. selectedTeam)
        end
    end

    -- If we're on a random wave...
    if waveType:lower() == "random" then
        if canRandomize == true then
            local randomFireteams = table.filter(covenantList, function(fireteam)
                return fireteam.random
            end)
            local availableFireteams = table.filter(randomFireteams, function(fireteam)
                return fireteam.available
            end)
            if #availableFireteams == 0 then
                logger:warning("No Fireteams available for randomization.")
                return
            end
            if Deployer.dropshipsLeft == Deployer.dropshipsAsigned then
                -- The first Dropship will drop a Support Squad, and...
                randomizedTeam = randomFireteams[math.random(#randomFireteams)]
                logger:info("Support Team: {}, Available? {}", randomizedTeam.name, randomizedTeam.available)
            else
                -- The rest of them will drop the Main Squads, which will not repeat!
                -- We only want to make this once, despite this whole function being call again.
                randomizedTeam = availableFireteams[math.random(#availableFireteams)]
                randomizedTeam.available = false -- Mark this team as unavailable for the next randomization.
                logger:info("Main Team: {}, Available? {}", randomizedTeam.name, randomizedTeam.available)
                canRandomize = false
            end
        end
        selectedTeam = randomizedTeam.name
    end

    if Deployer.dropshipsLeft > 0 then
        hsc.ai_place(selectedTeam)
        local selectedDropship = Deployer.dropshipTemplate:format(Deployer.dropshipsLeft)
        hsc.object_create_anew(selectedDropship)
        hsc.ai_place("Covenant_Fireteams/Spirit_Gunner")
        hsc.vehicle_load_magic(selectedDropship, "gunseat", hsc.ai_actors("Covenant_Fireteams/Spirit_Gunner"))
        hsc.ai_migrate("Covenant_Fireteams/Spirit_Gunner", "Covenant_Support")
        hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors(selectedTeam))
        hsc.custom_animation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, false)
        hsc.ai_migrate(selectedTeam, "Covenant_Wave")
        Deployer.dropshipsLeft = Deployer.dropshipsLeft - 1
        unitDeployer.waveDeployer(currentWaveType) -- We're calling this again as the same type of wave we're on.
    else
        logger:debug("All Dropships have been sent!")
        Deployer.dropshipsLeft = Deployer.dropshipsAsigned
        canRandomize = true -- Reset the randomization flag for the next wave.
        Deployer.deploymentAllowed = false -- Gotta find a way to cap this func if deploymentAllowed is false, just in case.
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
function unitDeployer.pelicanDeployer(call, sleep)
    sleep(700)
    hsc.ai_place("Human_Team/ODSTs")
    hsc.ai_place("human_support/pelican_pilot")
    hsc.object_create_anew("foehammer_cliff")
    hsc.vehicle_load_magic("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs"))
    hsc.vehicle_load_magic("foehammer_cliff", "driver", hsc.ai_actors("human_support/pelican_pilot"))
    hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
    --sleep(30)
    hsc.unit_set_enterable_by_player("foehammer_cliff", false)
    hsc.unit_close("foehammer_cliff")
    hsc.object_teleport("foehammer_cliff", "foehammer_cliff_flag")
    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), true)
    hsc.recording_play_and_hover( "foehammer_cliff", "foehammer_cliff_in")
    sleep(1200)
    hsc.unit_open("foehammer_cliff")
    sleep(90)
    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), false)
    hsc.vehicle_unload("foehammer_cliff", "rider")
    sleep(120)
    if not hsc.vehicle_test_seat_list("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs")) then
        hsc.unit_close("foehammer_cliff")
        sleep(120)
        hsc.vehicle_hover("foehammer_cliff", false)
        hsc.recording_play_and_delete("foehammer_cliff", "foehammer_cliff_out")
    end
end

return unitDeployer
