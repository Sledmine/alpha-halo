-- Lua libraries
local const = require "alpha_halo.constants"
local blam = require "blam"
local healthRegenSP = {}

local maxHealth = 1
--- Regeneramos la salud del jugador hasta cierto límite. Sólo para Singleplayer.
function healthRegenSP.regenerateHealth()
    local player = blam.biped(get_dynamic_player())
    if player then
        -- Fix muted audio shield sync
        if server_type == "local" then
            if player.health <= 0 then
                player.health = 0.000000001
            end
        end
        -- Esto inicia la acción de recargar salud.
        if player.health < maxHealth and player.shield > 0.75 then
            player.health = player.health + const.healthRegenerationAmount
            if player.health > 1 then
                player.health = 1
            end
        end
    end
end

return healthRegenSP