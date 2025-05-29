local skullsManager = require "alpha_halo.systems.combat.skullsManager"

local commands = {}

commands = {
    enable_skull = {
        description = "Activate a skull by <type> and <arg>.",
        category = "debug",
        help = "Usage: activate_skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> ]",
        minArgs = 2,
        maxArgs = 2,
        func = function(type, skullName)
            skullsManager.enableSkull(type, skullName)
        end
    },
    disable_skull = {
        description = "Deactivate a skull by <type> and <arg>.",
        category = "debug",
        help = "Usage: deactivate_skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> | <is_active> ]",
        minArgs = 2,
        maxArgs = 2,
        func = function(type, skullName)
            skullsManager.disableSkull(type, skullName)
        end
    },
}

return commands