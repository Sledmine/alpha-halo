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
                if projectile.detonationTimerStarts == 0 then -- Los timers Inmediatly afectan el propostio de Cliffhanger; los cambiamos a When at rest.
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    projectile.detonationTimerStarts = 2
                end
                ---@diagnostic disable-next-line: assign-type-mismatch
                projectile.timer = {2, 10}
                for i = 1, projectile.materialResponse.count do
                    local materialResponse = projectile.materialResponse.elements[i]
                    local potentialChance = (materialResponse.potentialBetween[2] > 0) or (materialResponse.potentialAnd[2] > 0) -- Revisamos si hay una chance de que se ejecute el potentialResponse en primer lugar.
                    if materialResponse.defaultResponse == 0 or materialResponse.defaultResponse == 1 then -- Si es Disappear o Detonate, lo cambiamos a Attach. Dejamos Overpenetrate y Bounce funcionando.
                        materialResponse.defaultResponse = 4
                    end
                    if potentialChance and (materialResponse.potentialResponse == 0 or materialResponse.potentialResponse == 1) then -- Si hay una chance y es Disappear o Detonate, lo cambiamos a Attach.
                        materialResponse.potentialResponse = 4
                    end
                    --if materialResponse.defaultResponse ~= 2 then
                    --    materialResponse.defaultResponse = 4 -- 4 = attach
                    --end
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

return cliffhanger
