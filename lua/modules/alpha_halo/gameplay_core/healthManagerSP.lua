-- LIBRERÍAS DE LUA
local healthManagerSP = {}
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local script = require "script".script
-- VARIABLES DE LA FUNCIÓN healthManagerSP.WhenMapLoads
local const = require "alpha_halo.constants"
local gameIsOn = false
-- VARIABLES DE LA FUNCIÓN healthManagerSP.healthRegen(playerIndex)
local player
local playerIsDead = false
local waitingForRespawn = false
-- VARIABLES DE LA FUNCIÓN healthRegenSP.maxHealthCap
local maxHealth = 1
-- VARIALBES DE LA FUNCIÓN healthRegenSP.respawnAndDeath
local playerLives = 6
local livesLeftTemplate = "Lives left... %s"
local actualLivesLeft = livesLeftTemplate:format(playerLives)
local playSound = engine.userInterface.playSound

-- Cuando el mapa carga. Realiza los cambios que necesitamos al iniciar cada juego.
function healthManagerSP.onMapLoad()
    gameIsOn = true
end

--- Cada tick. Aquí llamamos al resto de funciones si inició el juego & existe el jugador.
function healthManagerSP.EachTick()
    if gameIsOn == true then
        healthManagerSP.healthRegen()
        healthManagerSP.tryingToRespawn()
    end
end

--- Regenerate players health on low shield using game ticks
---@param playerIndex? number
function healthManagerSP.healthRegen(playerIndex)
    if playerIndex then
        player = blam.biped(get_dynamic_player(playerIndex))
    else
        player = blam.biped(get_dynamic_player())
    end
    if player then
        healthManagerSP.maxHealthCap()
        playerIsDead = false
        if player.health <= 0 then
            player.health = 0.000000001
        end
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
            waitingForRespawn = true
        end
        if playerLives == 0 then
            gameIsOn = false
            console_out("Thanks for playing.")
            execute_script("sv_end_game")
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
function healthManagerSP.tryingToRespawn()
    if waitingForRespawn == true and player then
        waitingForRespawn = false
        playerLives = playerLives - 1
        actualLivesLeft = livesLeftTemplate:format(playerLives)
        if playerLives > 0 then
            console_out(actualLivesLeft)
        elseif playerLives == 5 then
            --healthManagerSP.playSound(const.sounds.fiveLivesLeft, 0.5)
            playSound(const.sounds.fiveLivesLeft.handle)
        elseif playerLives == 1 then
            --healthManagerSP.playSound(const.sounds.oneLiveLeft, 0.5)
            playSound(const.sounds.oneLiveLeft.handle)
        elseif playerLives == 0 then
            --healthManagerSP.playSound(const.sounds.noLivesLeft, 0.5)
            playSound(const.sounds.noLivesLeft.handle)
            console_out("No lives left.")
            console_out("You feel a sense of dread crawling up your spine...")
        end
    end
end

-- Esta función es llamada desde otros modulos cuando ganas una vida.
function healthManagerSP.livesGained()
    script(function (sleep, sleepUntil)
        console_out("Lives added!")
        playerLives = playerLives + 1
        sleep(100)
        playSound(const.sounds.livesAdded.handle)
    end)()
    if player then
        player.health = 1
    end
end

return healthManagerSP