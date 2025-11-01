local tagEntries = require "alpha_halo.systems.core.tagEntries"

local cliffhanger = {}

---Cliffhanger: Greatly expands the max detonation delay boundary for all explosives.
---@param isActive boolean
function cliffhanger.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.projectile()) do
        local projectile = tagEntry.data
        if isActive then
            if not projectile.effect.tagHandle.value == nulled then
                projectile.timer[2] = 10
                for i = 1, projectile.projectileMaterialResponse.count do
                    local materialResponse = projectile.projectileMaterialResponse.elements[i]
                    -----@diagnostic disable-next-line: assign-type-mismatch
                    if  not materialResponse.defaultResponse == 2 then
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        materialResponse.defaultResponse = 4 -- 4 = attach
                    end
                    -----@diagnostic disable-next-line: assign-type-mismatch
                    if  not materialResponse.potentialResponse == 2 then
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        materialResponse.potentialResponse = 4 -- 4 = attach
                    end
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.cliffhanger.active = isActive
    -- logger:debug("Cliffhanger {}", isActive and "On" or "Off")
end

return cliffhanger