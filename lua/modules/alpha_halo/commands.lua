local luna = require "luna"
local skullsManager = require "alpha_halo.gameplay_core.skullsManager"

local commands = {}

commands = {
    activate_silver_skull = {
        description = "Activate a silver skull by name.",
        help = [[<skull_name | "random">]],
        minArgs = 1,
        maxArgs = 1,
        func = function(skullName)
            skullsManager.activateSilverSkull(skullName)
        end
    },
}

return commands