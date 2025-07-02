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
        name = "Starting_Squad",
        random = false,
        available = true,
    },
    eliteSquad = {
        name = "Elite_Squad",
        random = true,
        available = true,
    },
    stealthSquad = {
        name = "Stealth_Squad",
        random = true,
        available = true,
    },
    gruntSquad = {
        name = "Grunt_Squad",
        random = true,
        available = true,
    },
    jackalSquad = {
        name = "Jackal_Squad",
        random = true,
        available = true,
    },
    hunterSquad = {
        name = "Hunter_Squad",
        random = true,
        available = true,
    },
    specOpsSquad = {
        name = "SpecOps_Squad",
        random = false,
        available = true,
    },
    zealotSquad = {
        name = "Zealot_Squad",
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
        name = "Starting_Squad",
        random = false,
        available = true,
    },
    flameSquad = {
        name = "Flame_Squad",
        random = true,
        available = true,
    },
    sniperSquad = {
        name = "Sniper_Squad",
        random = true,
        available = true,
    },
    rocketSquad = {
        name = "Rocket_Squad",
        random = true,
        available = true,
    },
    eliteSquad = {
        name = "Elite_Squad",
        random = true,
        available = true,
    },
    stealthSquad = {
        name = "Stealth_Squad",
        random = true,
        available = true,
    },
    carrierSquad = {
        name = "Mixed_Squad",
        random = true,
        available = true,
    },
    specOpsSquad = {
        name = "SpecOps_Squad",
        random = false,
        available = true,
    },
    zealotSquad = {
        name = "Zealot_Squad",
        random = false,
        available = true,
    },
}

local floodList = {
    unitDeployer.floodFireteams.startingSquad,
    unitDeployer.floodFireteams.flameSquad,
    unitDeployer.floodFireteams.sniperSquad,
    unitDeployer.floodFireteams.rocketSquad,
    unitDeployer.floodFireteams.eliteSquad,
    unitDeployer.floodFireteams.stealthSquad,
    unitDeployer.floodFireteams.carrierSquad,
    unitDeployer.floodFireteams.specOpsSquad,
    unitDeployer.floodFireteams.zealotSquad,
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
unitDeployer.deployerSettings = {
    dropshipsAsigned = 3,
    dropshipsLeft = 3, -- This should be equal to dropshipsAsigned
    dropshipTemplate = "dropship_%s_1",
    deploymentAllowed = true,
    currentTeam = 1,
}
local Deployer = unitDeployer.deployerSettings -- For easier access to the Deployer table.

local randomizedTeam -- These ones are out bc we don't want to reset them;
local canRandomize = true -- every time we call the waveDeployer function.
local currentTeam
-- Call Wave Deployer based on the type of wave we're on.
---@param waveType string | "starting" | "boss" | "random"
function unitDeployer.waveDeployer(waveType)
    local currentTeamList
    local currentTeamFireteams
    local selectedSquad -- We're gonna define this and then do stuff with it.
    local currentWaveType = waveType -- We want to know which type of wave we've been called.

    if Deployer.currentTeam == 1 then
        currentTeam = "Covenant"
        currentTeamList = covenantList
        currentTeamFireteams = unitDeployer.covenantFireteams
    elseif Deployer.currentTeam == 2 then
        currentTeam = "Flood"
        currentTeamList = floodList
        currentTeamFireteams = unitDeployer.floodFireteams
    end -- Perhaps there's a better way to do this?

    -- Check if the waveType is valid
    if not waveType then
        logger:error(
            "WRONG! Usage: squad_assembler [ <starting> | <boss> | <random> ]")
        return
    end

    -- If we're on a starting wave...
    if waveType:lower() == "starting" then
        -- The 3 Dropships drops Starting Squads!
        selectedSquad = (currentTeam .. "_Fireteams/" .. currentTeamFireteams.startingSquad.name)
        logger:info("Starting Fireteam: " .. selectedSquad)
    end

    -- If we're on a boss wave...
    if waveType:lower() == "boss" then
        if Deployer.dropshipsLeft == Deployer.dropshipsAsigned then
            -- The first Dropship will drop a Zealot Squad, and...
            selectedSquad = (currentTeam .. "_Fireteams/" .. currentTeamFireteams.zealotSquad.name)
            logger:info("Bodyguard Fireteam: " .. selectedSquad)
        else
            -- The rest of them will deploy SpecOps Squads!
            selectedSquad = (currentTeam .. "_Fireteams/" .. currentTeamFireteams.specOpsSquad.name)
            logger:info("Boss Fireteam: " .. selectedSquad)
        end
    end

    -- If we're on a random wave...
    if waveType:lower() == "random" then
        if canRandomize == true then
            local randomFireteams = table.filter(currentTeamList, function(fireteam)
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
        selectedSquad = (currentTeam .. "_Fireteams/" .. randomizedTeam.name)
    end

    if Deployer.dropshipsLeft > 0 then
        hsc.ai_place(selectedSquad)
        local selectedDropship = Deployer.dropshipTemplate:format(Deployer.dropshipsLeft)
        hsc.object_create_anew(selectedDropship)
        hsc.ai_place(currentTeam .. "_Fireteams/Spirit_Gunner") -- Covenant-or-Flood_Fireteams/Spirit_Gunner
        hsc.vehicle_load_magic(selectedDropship, "gunseat", hsc.ai_actors(currentTeam .. "_Fireteams/Spirit_Gunner"))
        hsc.ai_migrate(currentTeam .. "_Fireteams/Spirit_Gunner", currentTeam .. "_Support") -- Covenant-or-Flood_Support squad block
        hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors(selectedSquad))
        hsc.custom_animation(selectedDropship, "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", selectedDropship, false)
        hsc.ai_migrate(selectedSquad, "Standby_Dropship")
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
    hsc.ai_braindead("Standby_Dropship", true)
    sleep(690)
    hsc.ai_migrate("Standby_Dropship", currentTeam .. "_Wave") -- Covenant-or-Flood_Wave encounter block
    sleep(15)
    hsc.ai_braindead(currentTeam .. "_Wave", false)
    sleep(15)
    hsc.ai_exit_vehicle(currentTeam .. "_Wave")
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
