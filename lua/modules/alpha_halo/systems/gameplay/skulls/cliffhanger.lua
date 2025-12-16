local tagEntries = require "alpha_halo.systems.core.tagEntries"

local cliffhanger = {}

---Cliffhanger: Greatly expands the max detonation delay boundary for all explosives.
---@param isActive boolean
function cliffhanger.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.projectile()) do
        if isActive then
            local projectile = tagEntry.data
            if not projectile.effect.tagHandle:isNull() then
                projectile.aiPerceptionRadius = projectile.aiPerceptionRadius + 1
                projectile.dangerRadius = projectile.dangerRadius + 1
                ---@diagnostic disable-next-line: assign-type-mismatch
                projectile.timer = {0.5, 5}
                for i = 1, projectile.materialResponse.count do
                    local materialResponse = projectile.materialResponse.elements[i]
                    if materialResponse.defaultResponse ~= 2 then
                        materialResponse.defaultResponse = 4 -- 4 = attach
                    end
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

return cliffhanger
