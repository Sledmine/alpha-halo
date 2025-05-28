local luna = require "luna"
local skullsManager = require "alpha_halo.gameplay_core.skullsManager"

local commands = {}

commands = {
    activate_skull = {
        description = "Activate a skull by <type> and <arg>.",
        category = "debug",
        help = "Usage: activate_skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> ]",
        minArgs = 2,
        maxArgs = 2,
        func = function(type, skullName)
            skullsManager.enableSkull(type, skullName)
        end
    },
    deactivate_skull = {
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