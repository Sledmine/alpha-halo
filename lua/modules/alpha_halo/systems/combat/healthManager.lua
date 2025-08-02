local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local tagClasses = Engine.tag.classes
local const = require "alpha_halo.systems.core.constants"
local script = require "script"

local healthManager = {}

---- THESE FUNCTIONS ARE CALLED EACH TICK ----
function healthManager.eachTick()
    healthManager.healthRegen()
    healthManager.regenerateAllyHealth()
end

---- THIS FUNCTION MANAGES THE HEALTH REGENERATION FOR THE PLAYER ----
local maxHealth = 1
function healthManager.healthRegen()
    for playerIndex = 0, 15 do
        -- We get the player.
        local player = getPlayer(playerIndex)
        if not player then
            return
        end
        -- We get the player biped.
        local biped = getObject(player.objectHandle, engine.tag.objectType.biped)
        if not biped then
            return
        end
        -- Idk why we need this, honestly.
        if biped.vitals.health <= 0 then
            biped.vitals.health = 0.000000001
        end
        -- If player's shield is above 0.95 and health is below maxHealth, we regenerate health.
        if biped.vitals.health < maxHealth and biped.vitals.shield > 0.95 then
            local newPlayerHealth = biped.vitals.health + const.healthRegenerationAmount
            if newPlayerHealth > 1 then
                biped.vitals.health = 1
            else
                biped.vitals.health = newPlayerHealth
            end
        end
        -- We define what is maxHealth for each player.
        if biped.vitals.health >= 0.605 then
            maxHealth = 1
        elseif biped.vitals.health < 0.605 and biped.vitals.health >= 0.305 then
            maxHealth = 0.6
        elseif biped.vitals.health < 0.305 then
            maxHealth = 0.3
        end
    end
end

---- THIS FUNCTION REGENERATES THE HEALTH OF ALLIED BIPEDS ----
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
