local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local tagClasses = Engine.tag.classes
local const = require "alpha_halo.systems.core.constants"
local script = require "script"
-- local blam = require "blam"

local healthManager = {}

-- VARIABLES DE LA FUNCIÓN healthRegenSP.maxHealthCap
local maxHealth = 1

-- VARIALBES DE LA FUNCIÓN healthRegenSP.respawnAndDeath
local playerLives = 6
local livesLeftTemplate = "Lives left... %s"
local actualLivesLeft = livesLeftTemplate:format(playerLives)
local playSound = engine.userInterface.playSound

function healthManager.eachTick()
    healthManager.healthRegen()
    healthManager.regenerateAllyHealth()
end

-- VARIABLES DE LA FUNCIÓN healthManager.healthRegen(playerIndex)
local playerIsDead = false
local waitingForRespawn = false
function healthManager.healthRegen()
    for playerIndex = 0, 15 do
        local player = getPlayer(playerIndex)
        if not player then
            return
        end
        local biped = getObject(player.objectHandle, engine.tag.objectType.biped)
        if not biped then
            if playerIsDead == false then
                playerIsDead = true
                waitingForRespawn = true
            end
            if playerLives == 0 then
                -- gameIsOn = false
                logger:debug("Thanks for playing.")
                execute_script("sv_end_game")
            end
            return
        end
        healthManager.maxHealthCap()
        playerIsDead = false
        if biped.vitals.health <= 0 then
            biped.vitals.health = 0.000000001
        end
        if biped.vitals.health < maxHealth and biped.vitals.shield > 0.95 then
            local newPlayerHealth = biped.vitals.health + const.healthRegenerationAmount
            if newPlayerHealth > 1 then
                biped.vitals.health = 1
            else
                biped.vitals.health = newPlayerHealth
            end
        end
    end
end

-- We cap max health regen according to current player's health.
function healthManager.maxHealthCap()
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    if biped.vitals.health >= 0.605 then
        maxHealth = 1
    elseif biped.vitals.health < 0.605 and biped.vitals.health >= 0.305 then
        maxHealth = 0.6
    elseif biped.vitals.health < 0.305 then
        maxHealth = 0.3
    end
end

local livesLeftTemplate = "Lives left... %s"
local actualLivesLeft = livesLeftTemplate:format(playerLives)
local playSound = engine.userInterface.playSound
-- A player has lost a life. What a looser.
function healthManager.tryingToRespawn(call, sleep)
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    if waitingForRespawn == true and biped then
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
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    logger:debug("Lives added!")
    playerLives = playerLives + 1
    sleep(100)
    playSound(const.sounds.livesAdded.handle)
    biped.vitals.health = 1
end

-- Regenerate a designated biped health using game ticks on singleplayer. 
function healthManager.regenerateAllyHealth()
    for bipedIndex = 0, 4095 do
        local bipedObject = getObject(bipedIndex)
        if not bipedObject then
            return
        end
        if bipedObject.type == objectTypes.biped then
            local bipedAlly = getObject(bipedIndex, objectTypes.biped)
            assert(bipedAlly, "Failed to get biped object")
            local bipedAllyTag = engine.tag.getTag(bipedObject.tagHandle.value, tagClasses.biped)
            assert(bipedAllyTag, "Biped tag must exist")
            if bipedAllyTag.path:includes("odst_h2") then
                bipedAlly.tagHandle.value = bipedAllyTag.handle.value
                if bipedAlly.vitals.health < 1 and bipedAlly.vitals.shield > 0.75 then
                    bipedAlly.vitals.health = bipedAlly.vitals.health + const.healthRegenAiAmount
                    --logger:debug("Ally  '{}'  Health Regen:  '{}'", bipedAlly.tagHandle.value, bipedAlly.vitals.health)
                    if bipedAlly.vitals.health > 1 then
                        bipedAlly.vitals.health = 1
                    end
                end
                --logger:debug("Ally  '{}'  Health:  '{}'", bipedAlly.tagHandle.value, bipedAlly.vitals.health)
            end
        end
    end
end

return healthManager
