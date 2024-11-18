-- Lua libraries
local const = require "alpha_halo.constants"
local blam = require "blam"

local healthRegenSP = {}

--- Regenerate player health on low shield using game ticks on singleplayer
function healthRegenSP.regenerateHealth()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- Fix muted audio shield sync
        if server_type == "local" then
            if player.health <= 0 then
                player.health = 0.000000001
            end
        end
        if player.health < 1 and player.shield > 0.75 then
            player.health = player.health + const.healthRegenerationAmount
            if player.health > 1 then
                player.health = 1
            end
        end
    end
end

return healthRegenSP