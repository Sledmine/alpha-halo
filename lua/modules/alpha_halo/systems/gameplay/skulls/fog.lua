local tagEntries = require "alpha_halo.systems.core.tagEntries"
local engine = Engine
local hscExecuteScript = engine.hsc.executeScript
local hsc = require "hsc"

local fog = {}

---Fog: Turns off a HUD element & aguments AI surprise distance.
---@param isActive boolean
function fog.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if isActive then
            actor.surpriseDistance = actor.surpriseDistance + 10
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

-- TODO Retrieve previous state of the motion sensor using transpilation
local motionSensorState = true
function fog.onTick(skullState)
    if skullState.isEnabled then
        hscExecuteScript("hud_show_motion_sensor 0")
    else
        hscExecuteScript("hud_show_motion_sensor 1")
    end
end

return fog
