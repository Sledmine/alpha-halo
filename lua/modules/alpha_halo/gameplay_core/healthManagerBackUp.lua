-- LIBRERÍAS DE LUA
local healthManagerSP = {}
local const = require "alpha_halo.constants"
local blam = require "blam"
local hsc = require "hsc"
-- VARIABLES DE LA FUNCIÓN healthManagerSP.WhenMapLoads
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN healthManagerSP.EachTick.
local player
-- VARIABLES DE LA FUNCIÓN healthManagerSP.vehicleHandler.
local playerVehicle
-- VARIABLES DE LA FUNCIÓN healthRegenSP.maxHealthCap.
local maxHealth = 1
-- VARIALBES DE LA FUNCIÓN healthRegenSP.respawnAndDeath.
local diedOnVehicle = false
local playerIsDead = false
local playerLives = 6
local livesLeftTemplate = "Lives left... %s"
local actualLivesLeft = livesLeftTemplate:format(playerLives)
-- VARIABLES DE LA FUNCIÓN healthRegenSP.respawnCountdown.
local respawnCountdownTimer = 150
local respawnCountdownCounter = 0
local playerVehicleHealth = 1

-- Cuando el mapa carga. Realiza los cambios que necesitamos al iniciar cada juego.
function healthManagerSP.WhenMapLoads()
    gameIsOn = true
end

--- Cada tick. Aquí llamamos al resto de funciones si inició el juego & existe el jugador.
function healthManagerSP.EachTick()
    if gameIsOn == true then
        healthManagerSP.healthRegen()
    end
end

--- Regenerate players health on low shield using game ticks
---@param playerIndex? number
function healthManagerSP.healthRegen(playerIndex)
    -- Definimos qué es el player. De esta definición se va a agarrar el resto del script.
    if playerIndex then
        player = blam.biped(get_dynamic_player(playerIndex))
    else
        player = blam.biped(get_dynamic_player())
    end
    -- Si existe el player, revisamos su healthCap y no está muerto.
    if player then
        healthManagerSP.maxHealthCap()
        playerIsDead = false
        -- Si su salud llega a 0, la regresamos a 0.001, por alguna razón.
        if player.health <= 0 then
            player.health = 0.000000001
        end
        -- Le regeneramos la salud cuando no tenga sus escudos, hasta el límite establecido.
        if player.health < maxHealth and player.shield > 0.95 then
            local newPlayerHealth = player.health + const.healthRegenerationAmount
            if newPlayerHealth > 1 then
                player.health = 1
            else
                player.health = newPlayerHealth
            end
        end
    else
        if playerIsDead == false then
            playerIsDead = true
            healthManagerSP.livesLost()
        end
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

-- El jugador ha perdido una vida. Vaya fracasado.
function healthManagerSP.livesLost()
    playerLives = playerLives - 1
    actualLivesLeft = livesLeftTemplate:format(playerLives)
    if playerLives > 0 then
        console_out(actualLivesLeft)
    elseif playerLives == 0 then
        console_out("No lives left.")
    elseif playerLives < 0 then
        console_out("Thanks for playing.")
    end
end

-- Esta función es llamada desde otros modulos cuando ganas una vida.
function healthManagerSP.livesGained()
    console_out("Lives added!")
    playerLives = playerLives + 1
    if player then
        player.health = 1
    end
end

-- Esta función hace cositas con los vehículos.
function healthManagerSP.vehicleHandler()
    -- Ya que cheat_deathless_player no deja que tu Ghost sea destruído, lo destruimos por ti.
    playerVehicle = blam.vehicle(get_object(player.vehicleObjectId))
    if playerVehicle then
        playerVehicleHealth = playerVehicle.health
        if playerVehicleHealth <= 0 then
            playerVehicle.isSilentlyKilled = true
        end
    else
        playerVehicleHealth = 1
    end
    -- Añadimos una capa adicional de protección, porque a veces el vehículo no capta que está muerto.
    for objectId, index in pairs(blam.getObjects()) do
        local vehicleObject = blam.vehicle(get_object(objectId))
        if vehicleObject then
            local vehicleTagId = vehicleObject.tagId
            if vehicleTagId == const.vehicles.ghostNormal.id or const.vehicles.ghostFuelRod.id or const.vehicles.ghostNeedler.id then
                if vehicleObject.health <= 0 then
                    vehicleObject.isPlayerNotAllowedToEntry = true
                else
                    vehicleObject.isPlayerNotAllowedToEntry = false
                end
            end
        end
    end
end

-- Simulamos la muerte y ordenamos el respawn.
function healthManagerSP.respawnAndDeath()
    -- Si "playerDead" es falso y te has quedado sin vida...
    if playerDead == false then
        if player.health <= 0 then --or playerVehicleHealth <= 0 then
            ---- Llamamos todas las funciones necesarias para simular la muerte.
            --if blam.isNull(player.vehicleObjectId) == false then
            --    diedOnVehicle = true
            --    hsc.unitExitVehicle("(player0)")
            --end
            --player.isNotDamageable = true
            --hsc.aiDisregard("(player0)", 1)
            --hsc.playerEnableInput(0)
            --hsc.playerAddEquipment("(player0)", "empty_loadout", 1)
            --hsc.Fade("out", 0, 0, 0, 90)
            --hsc.cameraControl(1)
            --hsc.cameraSetDead("(player0)")
            ---- Hacemos cambios a las variables necesarias para iniciar el respawn.
            playerDead = true
            playerLives = playerLives - 1
            --respawnCountdownCounter = respawnCountdownTimer
            -- Anunciamos al jugador cuántas vidas le quedan.
            actualLivesLeft = livesLeftTemplate:format(playerLives)
            if playerLives > 0 then
                console_out(actualLivesLeft)
            elseif playerLives == 0 then
                console_out("No lives left.")
            elseif playerLives < 0 then
                console_out("Thanks for playing.")
            end
        else
            playerDead = false
        end
    end
end

-- Realizamos el cooldown para el respawn.
function healthManagerSP.respawnCountdown()
    -- Si "playerDead" es verdad...
    if playerDead == true then
        -- Antes que todo, realizamos la cuenta regresiva del respawn.
        if respawnCountdownCounter > 0 then
            respawnCountdownCounter = respawnCountdownCounter - 1
            if blam.isNull(player.vehicleObjectId) == false then
                diedOnVehicle = true
                hsc.unitExitVehicle("(player0)")
            end
        elseif respawnCountdownCounter <= 0 then
            -- Si aún te quedan vidas, revives.
            if playerLives >= 0 then
                if diedOnVehicle == false then
                    hsc.playerAddEquipment("(player0)", "spawn_loadout", 1)
                elseif diedOnVehicle == true then
                    hsc.playerAddEquipment("(player0)", "default_loadout", 1)
                    diedOnVehicle = false
                end
                player.isNotDamageable = false
                hsc.aiDisregard("(player0)", 0)
                hsc.playerEnableInput(1)
                hsc.Fade("in", 0, 0, 0, 30)
                hsc.cameraControl(0)
                hsc.objectTeleport("(player0)", "player_respawn")
                playerDead = false
                if playerLives == 0 then
                    console_out("You feel a sense of dread crawling up your spine...")
                end
            -- Si ya no te quedan vidas, se reinicia el mapa.
            elseif playerLives < 0 then
                execute_script("map_name alpha_halo_dev")
            end
        end
    end
end

return healthManagerSP