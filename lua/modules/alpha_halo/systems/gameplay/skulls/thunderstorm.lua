local tagEntries = require "alpha_halo.systems.core.tagEntries"

local thunderstorm = {}

---Thunderstorm: All characters are upgraded to their major variant.
---@param isActive boolean
function thunderstorm.skullEffect(isActive)
    local tagClasses = Engine.tag.classes
    local findTags = Engine.tag.findTags
    local globalsEntry = findTags("", tagClasses.globals)[1]
        if isActive then
            for i = 1, globalsEntry.data.difficulty.count do
                local difficulty = globalsEntry.data.difficulty.elements[i]
                difficulty.easyMajorUpgrade = 1
                difficulty.normalMajorUpgrade = 1
                difficulty.hardMajorUpgrade = 1
                difficulty.impossMajorUpgrade = 1
                difficulty.easyMajorUpgrade1 = 1
                difficulty.normalMajorUpgrade1 = 1
                difficulty.hardMajorUpgrade1 = 1
                difficulty.impossMajorUpgrade1 = 1
                difficulty.easyMajorUpgrade2 = 1
                difficulty.normalMajorUpgrade2 = 1
                difficulty.hardMajorUpgrade2 = 1
                difficulty.impossMajorUpgrade2 = 1
            end
        else
            Balltze.features.reloadTagData(globalsEntry.handle)
        end
    -- skullsManager.skulls.thunderstorm.active = isActive
    -- logger:debug("Thunderstorm {}", isActive and "On" or "Off")
end

return thunderstorm