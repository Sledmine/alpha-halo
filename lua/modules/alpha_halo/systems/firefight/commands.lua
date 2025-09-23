local skullsManager = require "alpha_halo.systems.gameplay.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local firefightManager = require "alpha_halo.systems.firefightManager"
local eventsManager = require "alpha_halo.systems.firefight.eventsManager"
local luna = require "luna"

local commands = {}

commands = {
    debug = {
        description = "Toggle debug mode.",
        category = "debug",
        help = "<boolean>",
        example = "debug true",
        minArgs = 1,
        maxArgs = 1,
        func = function(isEnabled)
            DebugMode = luna.bool(isEnabled)
            if DebugMode then
                logger:info("Debug mode enabled.")
            else
                logger:info("Debug mode disabled.")
            end
            logger:muteDebug(not DebugMode)
        end
    },
    skull = {
        description = "Activate or disable a skull by name, or use \"random\" or \"all\"." ..
            " Optionally set a multiplier for skull effects (default is 1).",
        category = "debug",
        help = "<name | \"random\" | \"all\"> <boolean> [<multiplier = 1>]",
        example = "skull cowbell true 2",
        minArgs = 2,
        maxArgs = 3,
        func = function(name, isEnabled, multiplier)
            local name = name:lower()
            -- Check if the skullList is valid and name is provided
            if not name or not skullsManager.skulls[name] and name ~= "random" and name ~= "all" then
                logger:error("Invalid skull name '{}'. Usage: {}, {}", name, commands.skull.help,
                             commands.skull.example)
                return
            end
            logger:debug("Toggling skull '{}' to {}", name, isEnabled)
            isEnabled = luna.bool(isEnabled)
            multiplier = tonumber(multiplier) or 1
            if multiplier <= 0 then
                logger:error("Invalid multiplier '{}'. It must be a positive number.", multiplier)
                return
            end
            if isEnabled then
                skullsManager.enableSkull(name, multiplier)
            else
                skullsManager.disableSkull(name)
            end
        end
    },
    squad_assembler = {
        description = "Assemble a squad of AI.",
        category = "debug",
        help = "<\"starting\" | \"boss\" | \"random\" ]",
        minArgs = 1,
        maxArgs = 1,
        func = function(waveType)
            if not waveType or
                (waveType ~= "starting" and waveType ~= "boss" and waveType ~= "random") then
                logger:error("Invalid or missing wave type. Usage: {}",
                             commands.squad_assembler.help)
                return
            end
            unitDeployer.waveDeployer(waveType)
        end
    },
    spawn_allies = {
        description = "Spawn allied ODSTs in the firefight map.",
        category = "debug",
        help = "",
        func = function()
            firefightManager.deployPlayerAllies()
        end
    },
    spawn_encounter_event = {
        description = "Spawn a encounter event (Banshees, Snipers, Sentinels).",
        category = "debug",
        help = "<\"banshee\" | \"sniper\" | \"sentinel\">",
        example = "spawn_encounter_event banshee",
        minArgs = 1,
        maxArgs = 1,
        func = function(eventType)
            if not eventType or
                (eventType ~= "banshee" and eventType ~= "sniper" and eventType ~= "sentinel") then
                logger:error("Invalid or missing event type. Usage: {}",
                             commands.spawn_encounter_event.help)
                return
            end
            if eventType == "banshee" then
                eventsManager.bansheeEvent()
            elseif eventType == "sniper" then
                eventsManager.sniperEvent()
            elseif eventType == "sentinel" then
                eventsManager.sentinelEvent()
            end
        end
    }
}

return commands
