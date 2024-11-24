-- LIBRERÍAS DE LUA
local healthManagerSP = {}
local const = require "alpha_halo.constants"
local blam = require "blam"
local hsc = require "hsc"
-- VARIABLES DE LA FUNCIÓN healthManagerSP.WhenMapLoads
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN healthManagerSP.EachTick.
local player = blam.biped(get_dynamic_player())
-- VARIABLES DE LA FUNCIÓN healthRegenSP.maxHealthCap.
local maxHealth = 1
-- VARIALBES DE LA FUNCIÓN healthRegenSP.respawnAndDeath.
local playerDead = false
-- VARIABLES DE LA FUNCIÓN healthRegenSP.respawnCountdown.
local respawnCountdownTimer = 300
local respawnCountdownCounter = 0

-- Cuando el mapa carga. Realiza los cambios que necesitamos al iniciar cada juego.
function healthManagerSP.WhenMapLoads()
    execute_script("set cheat_deathless_player true")
    gameIsOn = true
end

--- Cada tick. Aquí llamamos al resto de funciones si inició el juego & existe el jugador.
function healthManagerSP.EachTick()
    if gameIsOn == true then
        player = blam.biped(get_dynamic_player())
        console_out(player.health)
        --if player then
            healthManagerSP.maxHealthCap()
            healthManagerSP.healthRegen()
            healthManagerSP.respawnAndDeath()
            healthManagerSP.respawnCountdown()
        --end
    end
end

-- Le ponemos un límite al máximo health regen, según el estado del jugador.
function healthManagerSP.maxHealthCap()
    if player.health >= 0.655 then
        maxHealth = 1
    elseif player.health < 0.655 and player.health >= 0.305 then
        maxHealth = 0.65
    elseif player.health < 0.305 then
        maxHealth = 0.30
    end
end

-- Le regeneramos la salud al jugador hasta el límite establecido.
function healthManagerSP.healthRegen()
    if player.health < maxHealth and player.shield > 0.95 then
        player.health = player.health + const.healthRegenerationAmount
        if player.health > 1 then
            player.health = 1
        end
    end
end

-- Revisamos si el jugador, que es inmortal, ha perdido toda su salud.
function healthManagerSP.respawnAndDeath()
    if playerDead == false then
        if player.health <= 0 then
            execute_script("player_enable_input 0")
            execute_script("camera_control 1")
            execute_script("camera_set_dead (player0)")
            execute_script("player_add_equipment (player0) empty_loadout 1")
            execute_script("fade_out 0 0 0 150")
            console_out("You're dead, idiot!")
            playerDead = true
            respawnCountdownCounter = respawnCountdownTimer
        end
    end
end

-- Realizamos el cooldown para el respawn.
function healthManagerSP.respawnCountdown()
    if playerDead == true then
        if respawnCountdownCounter > 0 then
            respawnCountdownCounter = respawnCountdownCounter - 1
        elseif respawnCountdownCounter <= 0 then
            execute_script("player_add_equipment (player0) default_loadout 1")
            execute_script("camera_control 0")
            execute_script("player_enable_input 1")
            execute_script("fade_in 0 0 0 150")
            execute_script("object_teleport (player0) player_respawn")
            console_out("Get up, idiot!")
            playerDead = false
        end
    end
end

--execute_script("map_name alpha_halo_dev")
return healthManagerSP