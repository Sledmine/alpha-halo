-- LIBRERÍAS DE LUA
local const = require "alpha_halo.constants"
local blam = require "blam"
local healthRegenSP = {}
-- VARIABLES DE LA FUNCIÓN healthRegenSP.regenerateHealth.
local player = blam.biped(get_dynamic_player())
local maxHealth = 1

--- Regeneramos la salud del jugador hasta cierto límite. Sólo para Singleplayer.
function healthRegenSP.regenerateHealth()
    player = blam.biped(get_dynamic_player())
    if player then
        healthRegenSP.maxHealthCap()
        if player.health < maxHealth and player.shield > 0.95 then
            player.health = player.health + const.healthRegenerationAmount
            if player.health > 1 then
                player.health = 1
            end
        end
    end
end

function healthRegenSP.maxHealthCap()
    if player.health < 1 and player.health >= 0.655 then
        maxHealth = 1
    elseif player.health < 0.655 and player.health >= 0.305 then
        maxHealth = 0.65
    elseif player.health < 0.305 then
        maxHealth = 0.30
    end
end

--[[function healthRegenSP.hitRegister()
    if tickCooldownCounter > 0 then
        firstTickHealth = player.health
        tickCooldownCounter = tickCooldownCounter - 1
    elseif tickCooldownCounter <= 0 then
        secondTickHealth = player.health
        tickCooldownCounter = tickCooldownTimer
    end

    if firstTickHealth == secondTickHealth then
        weBeenHit = false
    else
        weBeenHit = true
    end

    if weBeenHit == true then
        console_out(weBeenHit)
    end
end]]

return healthRegenSP