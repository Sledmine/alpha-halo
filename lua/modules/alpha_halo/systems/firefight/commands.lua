local skullsManager = require "alpha_halo.systems.gameplay.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local firefightManager = require "alpha_halo.systems.firefightManager"
local luna = require "luna"

local commands = {}

commands = {
    skull = {
        description = "Activate or disable a skull by name, or use \"random\" or \"all\"." ..
                      " Optionally set a multiplier for skull effects (default is 1).",+
        category = "debug",
        help = "<name | \"random\" | \"all\"> <boolean> [<multiplier = 1>]",
        example = "skull cowbell true 2",
        minArgs = 3,
        maxArgs = 3,
        func = function(name, isEnabled, multiplier)
            local name = name:lower()
            -- Check if the skullList is valid and name is provided
            if not name or not skullsManager.skulls[name] and name ~= "random" and name ~= "all" then
                logger:error("Invalid skull name '{}'. Usage: {}, {}", name, commands.skull.help,
                             commands.skull.example)
                return
            end
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
        minArgs = 0,
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
    }
}

return commands
