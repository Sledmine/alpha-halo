local engine = Engine
local balltze = Balltze
local hsc = require "hsc"
local script = require "script"
local sleep = script.sleep
local constants = require "alpha_halo.systems.core.constants"

local unitDeployer = {}

unitDeployer.badGuys = {
    "Covenant_Wave",
    "Covenant_Support",
    "Flood_Wave",
    "Flood_Support",
    "Covenant_Banshee",
    "Covenant_Snipers",
    "Sentinel_Team",
    "Standby_Dropship"
}

unitDeployer.fireTeams = {
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
    human = {odstSquad = {name = "ODSTs", isRandom = false, available = true}},
    sentinel = {sentinelSquad = {name = "Sentinel Squad", isRandom = false, available = true}}
}

unitDeployer.unitTeams = {
    convenant = {index = 1, name = "Covenant", fireTeams = unitDeployer.fireTeams.covenant},
    flood = {index = 2, name = "Flood", fireTeams = unitDeployer.fireTeams.flood},
    sentinel = {index = 3, name = "Sentinel", fireTeams = unitDeployer.fireTeams.sentinel}
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
local deployerState = unitDeployer.deployerSettings

-- Restore availability of all random fireteams.
local function resetFireteamsAvailability()
    for _, fireteam in pairs(unitDeployer.fireTeams) do
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

---Call Wave Deployer based on the type of wave we're on.
---@param waveType string | "starting" | "boss" | "random"
function unitDeployer.waveDeployer(waveType)
    local currentFireteams

    local team = table.find(unitDeployer.unitTeams, function(t)
        return t.index == deployerState.currentTeam
    end)
    assert(team, "Invalid team index: " .. tostring(deployerState.currentTeam))
    currentTeam = team.name
    currentFireteams = team.fireTeams
    logger:debug("Current Team: " .. currentTeam)

    -- By default, we deploy the starting squad.
    local selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.startingSquad.name

    -- If we're on a starting wave...
    if waveType == "starting" then
        -- The 3 Dropships drops Starting Squads!
        selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.startingSquad.name
        logger:debug("Starting Fireteam: " .. selectedSquad)
    end

    -- If we're on a boss wave...
    if waveType == "boss" then
        if deployerState.dropshipsLeft == deployerState.dropshipsAssigned then
            -- The first Dropship will drop a Zealot Squad, and...
            selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.zealotSquad.name
            -- randomizedGhost = math.random(1, 3) -- Randomize the Ghost for the boss wave.
            logger:debug("Bodyguard Fireteam: " .. selectedSquad)
        else
            -- The rest of them will deploy SpecOps Squads!
            selectedSquad = currentTeam .. "_Fireteams/" .. currentFireteams.specOpsSquad.name
            logger:debug("Boss Fireteam: " .. selectedSquad)
        end
    end

    -- If we're on a random wave...
    if waveType == "random" and isWaveRandomizable then
        local fireTeamList = table.values(currentFireteams)
        if #getAvailableRandomFireteams(fireTeamList) == 0 then
            logger:debug("All random fireteams have been used. Resetting availability.")
            resetFireteamsAvailability()
        end
        local availableFireteams = getAvailableRandomFireteams(fireTeamList)
        assert(#availableFireteams > 0, "No available fireteams to select from.")
        randomizedTeam = availableFireteams[math.random(#availableFireteams)]
        if deployerState.dropshipsLeft == deployerState.dropshipsAssigned then
            -- The first Dropship will drop a Support Squad, and...
            logger:debug("Support Team: {}, isRandom: {}, Available: {}", randomizedTeam.name,
                         tostring(randomizedTeam.isRandom), tostring(randomizedTeam.available))
        else
            -- The rest of them will drop the Main Squads, which will not repeat!
            -- We only want to make this once, despite this whole function being call again.
            randomizedTeam.available = false -- Mark this team as unavailable for the next randomization.
            logger:debug("Main Team: {}, isRandom: {}, Available: {}", randomizedTeam.name,
                         tostring(randomizedTeam.isRandom), tostring(randomizedTeam.available))
            isWaveRandomizable = false
        end -- We need to restore availability if we reach 0.
        if randomizedTeam then
            selectedSquad = currentTeam .. "_Fireteams/" .. randomizedTeam.name
        end
    end

    if deployerState.dropshipsLeft > 0 then
        -- Define and create the Dropship.
        local selectedDropship = deployerState.dropshipTemplate:format(deployerState.dropshipsLeft)
        hsc.object_create_anew(selectedDropship)
        -- Place and load troopers
        hsc.ai_place(selectedSquad)
        -- Place turret Gunner
        hsc.ai_place(currentTeam .. "_Fireteams/Spirit_Gunner")

        -- Load AI into the Dropship.
        hsc.vehicle_load_magic(selectedDropship, "gunseat",
                               hsc.ai_actors(currentTeam .. "_Fireteams/Spirit_Gunner"))
        hsc.vehicle_load_magic(selectedDropship, "passenger", hsc.ai_actors(selectedSquad))

        -- Migrate them to their respective deployment encounters.
        hsc.ai_migrate(selectedSquad, "Standby_Dropship")
        hsc.ai_migrate(currentTeam .. "_Fireteams/Spirit_Gunner", currentTeam .. "_Support")

        deployerState.dropshipsLeft = deployerState.dropshipsLeft - 1
        unitDeployer.waveDeployer(waveType)
    else
        -- Restore all the necesary variables and flags. Begin the exit vehicle process.
        logger:debug("All Dropships have been sent!")
        deployerState.dropshipsLeft = deployerState.dropshipsAssigned
        isWaveRandomizable = true
        deployerState.deploymentAllowed = false -- We cap this so no dropships can be deployed 'till the Spirits are out.
        script.startup(unitDeployer.dispatchDropships)
    end
end

local function getLeftAnimationTime(unitName)
    return hsc.unit_get_custom_animation_time(unitName)
end

function unitDeployer.dispatchDropships()
    -- Final encounter name where the troops will be migrated.
    local currentEncounter = currentTeam .. "_Wave"

    -- Set the previously used global encounter for troops deployment.
    -- We use this to prevent making already in field troops to become braindead.
    -- While the dropship is deploying troops, we set this temp encounter to braindead.
    hsc.ai_braindead("Standby_Dropship", true)

    local availableDropships = {}
    for i = 1, deployerState.dropshipsAssigned do
        table.insert(availableDropships, deployerState.dropshipTemplate:format(i))
    end

    -- Play the Dropship deployment animation.
    for i = 1, deployerState.dropshipsAssigned do
        script.startup(function()
            sleep(constants.dropshipDelayTicks * (i - 1)) -- Stagger the deployment of each Dropship.
            local selectedDropship = table.remove(availableDropships, math.random(#availableDropships))
            logger:debug("Deploying troops from Dropship: {}", selectedDropship)
            hsc.custom_animation(selectedDropship,
                                 "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies",
                                 selectedDropship, false)

            -- Wait for desired frame to drop troops.
            sleep(function()
                return getLeftAnimationTime(selectedDropship) <= constants.dropshipDeploymentDropTick
            end)

            -- Migrate troops onboard to the current wave encounter.
            hsc.ai_migrate("Standby_Dropship", currentEncounter)
            sleep(1)
            -- We reestablish the brain of the units.
            hsc.ai_braindead(currentEncounter, false)
            sleep(1)

            -- Make the encounter to exit it's vehicles.
            -- This will make the pilot drop from it's ghost, but will try to climb in again after.
            hsc.vehicle_unload(selectedDropship, "")
        end)
    end

    sleep(function ()
        local leftAnimationTime = 0
        for i = 1, deployerState.dropshipsAssigned do
            local selectedDropship = deployerState.dropshipTemplate:format(i)
            leftAnimationTime = leftAnimationTime + getLeftAnimationTime(selectedDropship)
        end
        return leftAnimationTime <= 0
    end)

    logger:debug("All Dropships have finished deploying troops.")
    deployerState.deploymentAllowed = true -- Now Spirits can run wild.
end

local pelicanVehicleName = "foehammer_cliff"
local pelicanPilotName = "human_support/pelican_pilot"
unitDeployer.names = {
    odstSquad = "Human_Team/ODSTs"
}
local odstSquadName = unitDeployer.names.odstSquad
local odstPelicanSquad = "standby_pelican"

-- Deploy allied ODSTs in a Pelican.
function unitDeployer.scriptDeployPelicans()
    sleep(constants.pelicanDeploymentDelay)
    hsc.ai_place(odstSquadName)
    hsc.ai_place(pelicanPilotName)
    -- TODO Make a custom biped for the Pelican turrets that can attack while in the Pelican.
    -- TODO Prevent ODSTs from receiving damage while in the Pelican.
    hsc.object_create_anew(pelicanVehicleName)
    -- hsc.unit_close(pelicanVehicleName)
    hsc.vehicle_load_magic(pelicanVehicleName, "rider", hsc.ai_actors(odstSquadName))
    hsc.vehicle_load_magic(pelicanVehicleName, "driver", hsc.ai_actors(pelicanPilotName))
    hsc.ai_migrate(odstSquadName, odstPelicanSquad)
    hsc.ai_migrate(pelicanPilotName, odstPelicanSquad)
    -- TODO This should be a dynamic encounter based on the current wave.
    -- Otherwise it just forces the AI to only see Covenant
    -- hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
    hsc.unit_set_enterable_by_player(pelicanVehicleName, false)
    hsc.object_teleport(pelicanVehicleName, "foehammer_cliff_flag")
    hsc.ai_braindead_by_unit(hsc.ai_actors(odstPelicanSquad), true)
    hsc.recording_play_and_hover(pelicanVehicleName, "foehammer_cliff_in")
    sleep(1200)
    hsc.unit_open(pelicanVehicleName)
    sleep(70)
    hsc.ai_braindead_by_unit(hsc.ai_actors(odstPelicanSquad), false)
    hsc.ai_migrate(odstPelicanSquad, odstSquadName)
    hsc.vehicle_unload(pelicanVehicleName, "")
    sleep(120)
    if not hsc.vehicle_test_seat_list(pelicanVehicleName, "rider", hsc.ai_actors(odstSquadName)) then
        sleep(300)
        hsc.unit_close(pelicanVehicleName)
        hsc.vehicle_hover(pelicanVehicleName, false)
        hsc.recording_play_and_delete(pelicanVehicleName, "foehammer_cliff_out")
    end
end

function unitDeployer.testDropshipDeployment()
    hsc.object_create_anew("dropship_1_1")
    hsc.ai_place(currentTeam .. "_Fireteams/Starting_Squad")
    hsc.vehicle_load_magic("dropship_1_1", "passenger",
                           hsc.ai_actors(currentTeam .. "_Fireteams/Starting_Squad"))
    hsc.ai_migrate(currentTeam .. "_Fireteams/Starting_Squad", "Standby_Dropship")
    script.startup(unitDeployer.dispatchDropships)
end

return unitDeployer
