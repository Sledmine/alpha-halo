local engine = Engine
local hscExecuteScript = engine.hsc.executeScript
local hsc = require "hsc"
local blam = require "blam"

local acrophobia = {}

---Acrophobia: Gives the player a jetpack.
local acrophobiaOnTick = false
---@param isActive boolean
function acrophobia.skullEffect(isActive)
    if isActive then
        acrophobiaOnTick = true
    else
        acrophobiaOnTick = false
    end
end

-- Acrophobia OnTick
function acrophobia.onTick(skullState)
    if acrophobiaOnTick then
        local player = blam.biped(get_dynamic_player())
        if not player then
            return
        end
        if skullState.isEnabled then
            if player.jumpHold and (not player.isOnGround) then
                player.zVel = player.zVel + 0.007
            end
            if player.crouchHold and (not player.isOnGround) then
                player.zVel = player.zVel - 0.003
            end
        else
            acrophobiaOnTick = false
        end
    end
end

return acrophobia