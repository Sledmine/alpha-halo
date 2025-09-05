local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local berserk = {}

local actors = dependencies.names.actors.berserk

---Berserk: Makes the AI enter in constant Berserk state.
---@param isActive boolean
function berserk.skullEffect(isActive)
    local berserkActorsFiltered = table.filter(tagEntries.actor(), function(tagEntry)
        for _, unitName in pairs(actors) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(berserkActorsFiltered) do
        local actor = tagEntry.data
        if isActive then
            actor.meleeAttackDelay = actor.meleeAttackDelay * 0.01
            actor.meleeChargeTime = actor.meleeChargeTime + 100
            actor.meleeLeapRange[1] = actor.meleeLeapRange[1] + 1.5
            actor.meleeLeapRange[2] = actor.meleeLeapRange[2] + 10
            actor.meleeLeapVelocity = actor.meleeLeapVelocity + 0.5
            actor.meleeLeapChance = actor.meleeLeapChance + 1
            actor.meleeLeapBallistic = actor.meleeLeapBallistic + 0.5
            actor.berserkProximity = actor.berserkProximity + 50
            actor.berserkGrenadeChance = actor.berserkGrenadeChance + 1
            actor.moreFlags:pathfindingIgnoresDanger(true)
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.berserk.active = isActive
    -- logger:debug("Berserk {}", isActive and "On" or "Off")
end

return berserk