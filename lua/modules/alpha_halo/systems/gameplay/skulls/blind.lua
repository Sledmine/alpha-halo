local tagEntries = require "alpha_halo.systems.core.tagEntries"

local blind = {}

local allUnits = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "odst"
}

---@param isActive boolean
function blind.set(isActive, skulls)
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
    skulls.blind.active = isActive
    blind.onTick(true, skulls)
end

---@param isActive boolean
function blind.onTick(isActive, skulls)
    if not isActive and skulls.blind.active then
        execute_script("show_hud 0")
    elseif isActive and not skulls.blind.active then
        execute_script("show_hud 1")
    end
end

return blind
