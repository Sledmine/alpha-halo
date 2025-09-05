local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local blind = {}

local allUnits = dependencies.names.units

--local blindOnTick = false
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
            actorVariant.burstOriginRadius = actorVariant.burstOriginRadius * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    --blindOnTick = true
    -- skullsManager.skulls.blind.active = isActive
    -- logger:debug("Blind {}", isActive and "On" or "Off")
end

-- Blind OnTick
--function blind.skullOnTick()
--    if blindOnTick == true then
--        if skullsManager.skulls.blind.spent > 0 then
--            execute_script("show_hud 0")
--        else
--            execute_script("show_hud 1")
--            blindOnTick = false
--        end
--    end
--end

return blind