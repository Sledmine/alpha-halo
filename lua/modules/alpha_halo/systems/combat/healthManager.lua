-- LIBRERÍAS DE LUA
local healthManager = {}
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local const = require "alpha_halo.systems.core.constants"
local script = require "script"

-- VARIABLES DE LA FUNCIÓN healthManager.healthRegen(playerIndex)
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

--- Cada tick. Aquí llamamos al resto de funciones si inició el juego & existe el jugador.
--- ACTUALMENTE NO HAY NADA HACIENDO LA COMPROBACIÓN. NECESITA ARREGLARSE PARA EVITAR CRASHEOS.
function healthManager.eachTick()
    healthManager.healthRegen()
    healthManager.regenerateAllyHealth()
end

--- Regenerate players health using game ticks
---@param playerIndex? number
function healthManager.healthRegen(playerIndex)
    if playerIndex then
        player = blam.biped(get_dynamic_player(playerIndex))
    else
        player = blam.biped(get_dynamic_player())
    end
    if player then
        healthManager.maxHealthCap()
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
            --gameIsOn = false
            logger:debug("Thanks for playing.")
            execute_script("sv_end_game")
        end
    end
end

-- We cap max health regen according to current player's health.
function healthManager.maxHealthCap()
    if player.health >= 0.605 then
        maxHealth = 1
    elseif player.health < 0.605 and player.health >= 0.305 then
        maxHealth = 0.6
    elseif player.health < 0.305 then
        maxHealth = 0.3
    end
end

-- A player has lost a life. What a looser.
function healthManager.tryingToRespawn(call, sleep)
    if waitingForRespawn == true and player then
        waitingForRespawn = false
        playerLives = playerLives - 1
        actualLivesLeft = livesLeftTemplate:format(playerLives)
        if playerLives > 0 then
            logger:debug(actualLivesLeft)
        end
        if playerLives == 5 then
            sleep(10)
            playSound(const.sounds.fiveLivesLeft.handle)
        end
        if playerLives == 1 then
            sleep(10)
            playSound(const.sounds.oneLiveLeft.handle)
        end
        if playerLives == 0 then
            logger:debug("No lives left.")
            logger:debug("You feel a sense of dread crawling up your spine...")
            sleep(10)
            playSound(const.sounds.noLivesLeft.handle)
        end
    end
end

script.continuous(healthManager.tryingToRespawn)

-- This function is called from other modules to add a live to the player.
function healthManager.livesGained(call, sleep)
    logger:debug("Lives added!")
    playerLives = playerLives + 1
    sleep(100)
    playSound(const.sounds.livesAdded.handle)
    if player then
        player.health = 1
    end
end

-- Regenerate a designated biped health using game ticks on singleplayer.
function healthManager.regenerateAllyHealth()
    for objectId, index in pairs(blam.getObjects()) do
        local bipedObject = blam.biped(get_object(objectId))
        if bipedObject then
            local bipedTagId = bipedObject.tagId
            assert(bipedTagId)
            if bipedTagId == const.bipeds.odstAllyTag.handle.value then
                if bipedObject.health < 1 and bipedObject.shield > 0.75 then
                    bipedObject.health = bipedObject.health + const.healthRegenAiAmount
                    if bipedObject.health > 1 then
                        bipedObject.health = 1
                    end
                end
            end
        end
    end
end

return healthManager
