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
    -- skullsManager.skulls.toughluck.active = isActive
    -- logger:debug("Tough Luck {}", isActive and "On" or "Off")
end

return toughLuck