-- Lua libraries
local const = require "alpha_halo.constants"
local blam = require "blam"

local healthRegenAlly = {}

--- Regenerate a designated biped health on low shield using game ticks on singleplayer
function healthRegenAlly.regenerateHealth()
    for objectId, index in pairs(blam.getObjects()) do
        local bipedObject = blam.biped(get_object(objectId))
        if bipedObject then
            local bipedTagId = bipedObject.tagId
            if bipedTagId == const.bipeds.odstAllyTag.id then
                --console_out("Biped found")
                if bipedObject.health < 1 and bipedObject.shield > 0.95 and blam.isNull(bipedObject.vehicleObjectId) then
                    bipedObject.health = bipedObject.health + const.healthRegenAiAmount
                    if bipedObject.health > 1 then
                        bipedObject.health = 1
                    end
                end
            end
        end
    end
end

return healthRegenAlly