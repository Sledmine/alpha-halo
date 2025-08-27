local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local firefightManager = require "alpha_halo.systems.firefightManager"
local luna = require "luna"

local commands = {}

commands = {
    skull = {
        description = "Activate or disable a skull by name, or use 'random' or 'all'.",
        category = "debug",
        help = "Usage: skull [ <name> | <random> | <all> ] [ true | false ]",
        minArgs = 3,
        maxArgs = 3,
        func = function(name, isEnabled)
            isEnabled = luna.bool(isEnabled)
            if isEnabled then
                local name = name:lower()
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
    },
    spawn_allies = {
        description = "Spawn allied ODSTs around the player.",
        category = "debug",
        help = "Usage: spawn_allies",
        func = function()
            firefightManager.deployPlayerAllies()
        end
    }
}

return commands
