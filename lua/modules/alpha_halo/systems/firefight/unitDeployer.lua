local engine = Engine
local balltze = Balltze
local hsc = require "hsc"
local script = require "script"
local constants = require "alpha_halo.systems.core.constants"

local unitDeployer = {}

unitDeployer.covenantFireteams = {
    startingSquad = {name = "Starting_Squad", isRandom = false, available = true},
    eliteSquad = {name = "Elite_Squad", isRandom = true, available = true},
    stealthSquad = {name = "Stealth_Squad", isRandom = true, available = true},
    gruntSquad = {name = "Grunt_Squad", isRandom = true, available = true},
    jackalSquad = {name = "Jackal_Squad", isRandom = true, available = true},
    hunterSquad = {name = "Hunter_Squad", isRandom = true, available = true},
    specOpsSquad = {name = "SpecOps_Squad", isRandom = false, available = true},
    zealotSquad = {name = "Zealot_Squad", isRandom = false, available = true}
}

unitDeployer.floodFireteams = {
    startingSquad = {name = "Starting_Squad", isRandom = false, available = true},
    flameSquad = {name = "Flame_Squad", isRandom = true, available = true},
    sniperSquad = {name = "Sniper_Squad", isRandom = true, available = true},
    rocketSquad = {name = "Rocket_Squad", isRandom = true, available = true},
    eliteSquad = {name = "Elite_Squad", isRandom = true, available = true},
    stealthSquad = {name = "Stealth_Squad", isRandom = true, available = true},
    carrierSquad = {name = "Mixed_Squad", isRandom = true, available = true},
    specOpsSquad = {name = "SpecOps_Squad", isRandom = false, available = true},
    zealotSquad = {name = "Zealot_Squad", isRandom = false, available = true}
}

unitDeployer.sentinelFireteams = {
    sentinelSquad = {name = "Sentinel Squad", isRandom = false, available = true}
}

local fireTeams = {
    covenant = {
        startingSquad = {name = "Starting_Squad", isRandom = false, available = true},
        eliteSquad = {name = "Elite_Squad", isRandom = true, available = true},
        stealthSquad = {name = "Stealth_Squad", isRandom = true, available = true},
        gruntSquad = {name = "Grunt_Squad", isRandom = true, available = true},
        jackalSquad = {name = "Jackal_Squad", isRandom = true, available = true},
        hunterSquad = {name = "Hunter_Squad", isRandom = true, available = true},
        specOpsSquad = {name = "SpecOps_Squad", isRandom = false, available = true},
        zealotSquad = {name = "Zealot_Squad", isRandom = false, available = true}
    },
    flood = {
        startingSquad = {name = "Starting_Squad", isRandom = false, available = true},
        flameSquad = {name = "Flame_Squad", isRandom = true, available = true},
        sniperSquad = {name = "Sniper_Squad", isRandom = true, available = true},
        rocketSquad = {name = "Rocket_Squad", isRandom = true, available = true},
        eliteSquad = {name = "Elite_Squad", isRandom = true, available = true},
        stealthSquad = {name = "Stealth_Squad", isRandom = true, available = true},
        carrierSquad = {name = "Mixed_Squad", isRandom = true, available = true},
        specOpsSquad = {name = "SpecOps_Squad", isRandom = false, available = true},
        zealotSquad = {name = "Zealot_Squad", isRandom = false, available = true}
    },
    human = {
        odstSquad = {name = "ODST Squad", isRandom = false, available = true}
    },
    sentinel = {
        sentinelSquad = {name = "Sentinel Squad", isRandom = false, available = true}
    }
}

unitDeployer.deployerSettings = {
    dropshipsAssigned = 3,
    dropshipsLeft = 0,
    dropshipTemplate = "dropship_%s_1",
    deploymentAllowed = true,
    currentTeam = 1
}
-- By default dropships left is equal to dropships assigned.
unitDeployer.deployerSettings.dropshipsLeft = unitDeployer.deployerSettings.dropshipsAssigned

-- Shorter reference to the settings table.
local settings = unitDeployer.deployerSettings

-- Restore availability of all random fireteams.
local function resetFireteamsAvailability()
    for _, fireteam in pairs(fireTeams) do
        for _, team in pairs(fireteam) do
            if team.isRandom then
                team.available = true
            end
        end
    end
end

-- Get a list of available random fireteams from a given list.
local function getAvailableRandomFireteams(fireteamList)
    return table.filter(fireteamList, function(fireteam)
        return fireteam.isRandom and fireteam.available
    end)
end

local randomizedTeam -- Hold randomized team data for random waves.
local isWaveRandomizable = true -- Control flag for random waves.
-- local randomizedGhost -- This one ill be used for the boss wave.
local currentTeam = "Covenant" -- We need to know which team we're deploying.
-- Call Wave Deployer based on the type of wave we're on.
---@param waveType string | "starting" | "boss" | "random"
function unitDeployer.waveDeployer(waveType)
    local currentFireteams
    local currentWaveType = waveType -- We want to know which type of wave we've been called.

    if settings.currentTeam == 1 then
        currentTeam = "Covenant"
        currentFireteams = fireTeams.covenant
    elseif settings.currentTeam == 2 then
        currentTeam = "Flood"
        currentFireteams = fireTeams.flood
    end -- Perhaps there's a better way to do this?

    -- By default, we deploy the starting squad.
    local selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.startingSquad.name

    -- If we're on a starting wave...
    if waveType == "starting" then
        -- The 3 Dropships drops Starting Squads!
        selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.startingSquad.name
        logger:info("Starting Fireteam: " .. selectedSquad)
    end

    -- If we're on a boss wave...
    if waveType == "boss" then
        if settings.dropshipsLeft == settings.dropshipsAssigned then
            -- The first Dropship will drop a Zealot Squad, and...
            selectedSquad = (currentTeam .. "_Fireteams/" .. currentFireteams.zealotSquad.name)
            -- randomizedGhost = math.random(1, 3) -- Randomize the Ghost for the boss wave.
            logger:info("Bodyguard Fireteam: " .. selectedSquad)
        else
            -- The rest of them will deploy SpecOps Squads!
            selectedSquad = (currentTeam .. "_Fireteams/" .. currentFireteams.specOpsSquad.name)
            logger:info("Boss Fireteam: " .. selectedSquad)
        end
    end

    -- If we're on a random wave...
    if waveType == "random" and isWaveRandomizable then
        local fireTeamList = table.values(currentFireteams)
        local availableFireteams = getAvailableRandomFireteams(fireTeamList)
        if #availableFireteams == 0 then
            resetFireteamsAvailability()
            availableFireteams = getAvailableRandomFireteams(fireTeamList)
            logger:warning("All random fireteams have been used. Resetting availability.")
        end
        randomizedTeam = availableFireteams[math.random(#availableFireteams)]
        if settings.dropshipsLeft == settings.dropshipsAssigned then
            -- The first Dropship will drop a Support Squad, and...
            logger:info("Support Team: {}, isRandom: {}, Available: {}", randomizedTeam.name,
                        tostring(randomizedTeam.isRandom), tostring(randomizedTeam.available))
        else
            -- The rest of them will drop the Main Squads, which will not repeat!
            -- We only want to make this once, despite this whole function being call again.
            randomizedTeam.available = false -- Mark this team as unavailable for the next randomization.
            logger:info("Main Team: {}, isRandom: {}, Available: {}", randomizedTeam.name,
                        tostring(randomizedTeam.isRandom), tostring(randomizedTeam.available))
            isWaveRandomizable = false
        end -- We need to restore availability if we reach 0.
        if randomizedTeam then
            selectedSquad = currentTeam .. "_Fireteams/" .. randomizedTeam.name
        end
    end

    if settings.dropshipsLeft > 0 then
        -- Define and create the Dropship.
        local selectedDropship = settings.dropshipTemplate:format(settings.dropshipsLeft)
        hsc.object_create_anew(selectedDropship)
        -- Place and load it's troopers & turrets.
        hsc.ai_place(selectedSquad)
        hsc.ai_place(currentTeam .. "_Fireteams/Spirit_Gunner")
        hsc.vehicle_load_magic(selectedDropship, "gunseat",
                               hsc.ai_actors(currentTeam .. "_Fireteams/Spirit_Gunner"))
        hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors(selectedSquad))
        -- Migrate them to their respective deployment encounters.
        hsc.ai_migrate(selectedSquad, "Standby_Dropship")
        hsc.ai_migrate(currentTeam .. "_Fireteams/Spirit_Gunner", currentTeam .. "_Support")
        -- If we're on a boss wave, create a Ghost for each dropship.
        -- if waveType:lower() == "boss" then
        --    -- Set and create the Ghost.
        --    local selectedGhost = "ghost_var" .. randomizedGhost .. "_drop" .. Deployer.dropshipsLeft
        --    hsc.object_create_anew(selectedGhost)
        --    -- Set and create the Ghost Pilot.
        --    local ghostPilot = currentTeam .. "_Fireteams/Ghost_Pilot"
        --    hsc.ai_place(ghostPilot)
        --    logger:info("Ghost Pilot: " .. ghostPilot)
        --    -- Load the Pilot into the Ghost, and the Ghost into the Dropship.
        --    hsc.vehicle_load_magic(selectedGhost, "driver", hsc.ai_actors(ghostPilot))
        --    hsc.unit_enter_vehicle(selectedGhost, selectedDropship, "cargo_ghost02")
        --    -- Set the Ghost to belong to current wave & make it's units impulsively entrable to it.
        --    hsc.ai_vehicle_encounter(selectedGhost, currentTeam .. "_Wave")
        --    hsc.ai_vehicle_enterable_actors(selectedGhost, currentTeam .. "_Wave")
        -- end -- The Ghost is ejected at Mach 5, not usable. Maybe in the future.
        -- Trigger the dropship animation, decrement dropshipsLeft, and call the waveDeployer function with the same parameter again.
        hsc.custom_animation(selectedDropship,
                             "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies",
                             selectedDropship, false)
        settings.dropshipsLeft = settings.dropshipsLeft - 1
        unitDeployer.waveDeployer(currentWaveType)
    else
        -- Restore all the necesary variables and flags. Begin the exit vehicle process.
        logger:debug("All Dropships have been sent!")
        settings.dropshipsLeft = settings.dropshipsAssigned
        isWaveRandomizable = true
        settings.deploymentAllowed = false -- We cap this so no dropships can be deployed 'till the Spirits are out.
        script.startup(unitDeployer.aiExitVehicle)
    end
end

function unitDeployer.aiExitVehicle(call, sleep)
    -- Set the troops onboard braindead (Does not apply to Ghost, but it doesn't matter).
    hsc.ai_braindead("Standby_Dropship", true)
    sleep(690)
    -- Migrate troops onboard to the current wave encounter.
    hsc.ai_migrate("Standby_Dropship", currentTeam .. "_Wave")
    sleep(30)
    -- We reestablish the brain of the units. Yes, this is very much necessary.
    hsc.ai_braindead(currentTeam .. "_Wave", false)
    sleep(30)
    -- Make the encounter to exit it's vehicles.
    -- This will make the pilot drop from it's ghost, but will try to climb in again after.
    hsc.vehicle_unload("dropship_1_1", "")
    hsc.vehicle_unload("dropship_2_1", "")
    hsc.vehicle_unload("dropship_3_1", "")
    sleep(900)
    settings.deploymentAllowed = true -- Now Spirits can run wild.
end

-- Deploy allied ODSTs in a Pelican.
function unitDeployer.scriptDeployPelicans(call, sleep)
    sleep(constants.pelicanDeploymentDelay)
    hsc.ai_place("Human_Team/ODSTs")
    hsc.ai_place("human_support/pelican_pilot")
    -- TODO Prevent ODSTs from receiving damage while in the Pelican.
    hsc.object_create_anew("foehammer_cliff")
    hsc.vehicle_load_magic("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs"))
    hsc.vehicle_load_magic("foehammer_cliff", "driver", hsc.ai_actors("human_support/pelican_pilot"))
    hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
    hsc.unit_set_enterable_by_player("foehammer_cliff", false)
    hsc.unit_close("foehammer_cliff")
    hsc.object_teleport("foehammer_cliff", "foehammer_cliff_flag")
    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), true)
    hsc.recording_play_and_hover("foehammer_cliff", "foehammer_cliff_in")
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
