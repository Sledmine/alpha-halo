local engine = Engine
local hscExecuteScript = engine.hsc.executeScript
local hsc = require "hsc"

local achrophobia = {}

---achrophobia: Gives the player a jetpack.}
---i'm too lazy to implement this rn
---@param isActive boolean
function achrophobia.skullEffect(isActive)
    if isActive then
        hscExecuteScript("cheat_infinite_ammo 1")
    else
        hscExecuteScript("cheat_infinite_ammo 0")
    end
end

return achrophobia