local engine = Engine
local hscExecuteScript = engine.hsc.executeScript
local hsc = require "hsc"

local bandana = {}

---bandana: Gives the player infinite ammo.
---@param isActive boolean
function bandana.skullEffect(isActive)
    if isActive then
        hscExecuteScript("cheat_infinite_ammo 1")
    else
        hscExecuteScript("cheat_infinite_ammo 0")
    end
end

return bandana