local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local luna = require "luna"

local commands = {}

commands = {
    skull = {
        description = "Activate or disable a skull by <type> and <arg> <isEnabled>",
        category = "debug",
        help = "Usage: skull [ <name> | <random> | <all> ]",
        minArgs = 3,
        maxArgs = 3,
        func = function(name, isEnabled)
            isEnabled = luna.bool(isEnabled)
            if isEnabled then
                local name 
                -- Check if the skullList is valid and name is provided
                if not name or not skullsManager.skulls[name] and name ~= "random" and name ~= "all" then
                    logger:error("Invalid skull name '{}'. Usage: {}", name, commands.skull.help)
                    return
                end
                skullsManager.enableSkull(name)
            else
                skullsManager.disableSkull(name)
            end
        end
    },
    squad_assembler = {
        description = "Assemble a squad of AI.",
        category = "debug",
        help = "Usage: squad_assembler [ <starting> | <boss> | <random> ]",
        minArgs = 0,
        maxArgs = 1,
        func = function(waveType)
            unitDeployer.waveDeployer(waveType)
        end
    }
}

return commands
