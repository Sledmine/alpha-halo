local engine = Engine
local hsc = require "hsc"

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
end

return acrophobia