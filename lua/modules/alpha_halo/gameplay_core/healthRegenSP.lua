-- Lua libraries
local const = require "alpha_halo.constants"

local healthRegen = {}

--- Regenerate player health on low shield using game ticks on singleplayer
function healthRegen.regenerateHealth()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- Fix muted audio shield sync
        if server_type == "local" then
            if player.health <= 0 then
                player.health = 0.000000001
            end
        end
        if player.health < 1 and player.shield >= 0.98 and blam.isNull(player.vehicleObjectId) then
            local newPlayerHealth = player.health + const.healthRegenerationAmount
            if newPlayerHealth > 1 then
                player.health = 1
            else
                player.health = newPlayerHealth
            end
        end
    end
end

return healthRegen