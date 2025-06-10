local tagEntries = require "alpha_halo.systems.core.tagEntries"

local fog = {}

---@param isActive boolean
function fog.set(isActive, skulls)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if isActive then
            actor.surpriseDistance = actor.surpriseDistance + 10
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skulls.fog.active = isActive
    fog.onTick(true, skulls)
end

---@param isActive boolean
function fog.onTick(isActive, skulls)
    if not isActive and skulls.fog.active then
        execute_script("hud_show_motion_sensor 0")
    elseif isActive and not skulls.fog.active then
        execute_script("hud_show_motion_sensor 1")
    end
end

return fog
