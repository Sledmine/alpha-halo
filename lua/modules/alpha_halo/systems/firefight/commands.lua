local skullsManager = require "alpha_halo.systems.combat.skullsManager"
local unitDeployer = require "alpha_halo.systems.firefight.unitDeployer"
local luna         = require "luna"

local commands = {}

commands = {
    skull = {
        description = "Activate a skull by <type> and <arg> <isEnabled>",
        category = "debug",
        help = "Usage: skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> ]",
        minArgs = 3,
        maxArgs = 3,
        func = function(type, skullName, isEnabled)
            isEnabled = luna.bool(isEnabled)
            if isEnabled then
                skullsManager.enableSkull(type, skullName)
            else
                skullsManager.disableSkull(type, skullName)
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
}

return commands