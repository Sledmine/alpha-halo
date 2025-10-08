local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local doubleDown = {}

local bipeds = dependencies.paths.bipeds

-- Double Down: Duplicates player's shields, but also it's recharging time.
---@param isActive boolean
function doubleDown.skullEffect(isActive, totalSkullPower)
    local finalSkullPower = totalSkullPower or 1
    local playerCollisionTagEntry = findTags(bipeds.player, tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry)
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * (2 * finalSkullPower)
            collisionGeometry.stunTime = collisionGeometry.stunTime * (2 * finalSkullPower)
            collisionGeometry.rechargeTime = collisionGeometry.rechargeTime * (2 * finalSkullPower)
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.doubledown.active = isActive
    -- logger:debug("Double Down {}", isActive and "On" or "Off")
end

return doubleDown