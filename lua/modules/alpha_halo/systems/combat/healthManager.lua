local engine = Engine
local getObject = Engine.object.getObject
local getPlayer = Engine.player.getPlayer
local const = require "alpha_halo.systems.core.constants"

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
        local player = getPlayer(playerIndex)
        if not player then
            return
        end
        local biped = getObject(player.unitHandle, "biped")
        if not biped then
            return
        end
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
    for bipedIndex = 0, const.maximumObjectsCount - 1 do
        local bipedObject = getObject(bipedIndex)
        if not bipedObject then
            return
        end
        if bipedObject.type == "biped" then
            local bipedAlly = getObject(bipedIndex, "biped")
            assert(bipedAlly, "Failed to get biped object")
            local bipedAllyTag = engine.tag.lookupTag and engine.tag.lookupTag(bipedObject.tagHandle.value, "biped")
            if bipedAllyTag then
                bipedAllyTag = engine.tag.getTagData(bipedAllyTag, "biped")
            end
            assert(bipedAllyTag, "Biped tag must exist")
            if bipedAllyTag.path:includes("odst_h2") then
                bipedAlly.tagHandle.value = bipedAllyTag.handle and bipedAllyTag.handle.value or bipedAllyTag.path
                if bipedAlly.vitals.health < 1 and bipedAlly.vitals.shield > 0.75 then
                    bipedAlly.vitals.health = bipedAlly.vitals.health + const.healthRegenAiAmount
                    if bipedAlly.vitals.health > 1 then
                        bipedAlly.vitals.health = 1
                    end
                end
            end
        end
    end
end

return healthManager
