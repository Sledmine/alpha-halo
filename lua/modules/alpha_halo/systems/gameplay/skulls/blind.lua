local engine = Engine
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"
local hscExecuteScript = engine.hsc.executeScript

local blind = {}

local allUnits = dependencies.names.units

-- local blindOnTick = false
-- Blind: Hides HUD and duplicates AI burst origin radius.
---@param isActive boolean
function blind.skullEffect(isActive)
    local blindTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(blindTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            ---@diagnostic disable-next-line: undefined-field
            actorVariant.burstGeometry.burstOriginRadius = actorVariant.burstGeometry.burstOriginRadius * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

-- TODO Retrieve previous state of the motion sensor using transpilation
function blind.onTick(skullState)
    if skullState.isEnabled then
        hscExecuteScript("show_hud 0")
    else
        hscExecuteScript("show_hud 1")
    end
end

return blind
