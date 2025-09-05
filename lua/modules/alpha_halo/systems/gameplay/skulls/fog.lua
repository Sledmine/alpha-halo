local tagEntries = require "alpha_halo.systems.core.tagEntries"

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

--function fog.skullFogOnTick()
--    -- TODO Retrieve previous state of the motion sensor using transpilation
--    local previousMotionSensorState = false
--    if previousMotionSensorState then
--        if skullsManager.skulls.fog.spent > 0 then
--            execute_script("hud_show_motion_sensor 0")
--        else
--            execute_script("hud_show_motion_sensor 1")
--            fogOnTick = false
--        end
--    end
--end

return fog