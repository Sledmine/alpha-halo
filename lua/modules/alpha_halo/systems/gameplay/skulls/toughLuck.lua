local tagEntries = require "alpha_halo.systems.core.tagEntries"

local toughLuck = {}

---Tough Luck: Makes AI react to everything and enhances their senses.
---@param isActive boolean
function toughLuck.skullEffect(isActive)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if isActive then
            actor.noticeProjectileChance = actor.noticeProjectileChance + 1
            actor.noticeVehicleChance = actor.noticeVehicleChance + 1
            actor.diveFromGrenadeChance = actor.diveFromGrenadeChance + 1
            actor.diveIntoCoverChance = actor.diveIntoCoverChance + 1
            actor.peripheralDistance = actor.peripheralDistance * 3
            actor.peripheralVisionAngle = actor.peripheralVisionAngle * 3
            actor.combatPerceptionTime = actor.combatPerceptionTime * 0.25
            actor.leaderKilledPanicChance = 0
            actor.friendKilledPanicChance = 0
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    for _, tagEntry in ipairs(tagEntries.projectile()) do
        local projectile = tagEntry.data
        if isActive then
            if not projectile.effect.tagHandle:isNull() then
                projectile.aiPerceptionRadius = projectile.aiPerceptionRadius + 1
                projectile.dangerRadius = projectile.dangerRadius + 1
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    for _, tagEntry in ipairs(tagEntries.explosionDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            ---@diagnostic disable-next-line: assign-type-mismatch
            damageEffect.damageCategory = 3 -- 3 = grenade
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.toughluck.active = isActive
    -- logger:debug("Tough Luck {}", isActive and "On" or "Off")
end

return toughLuck