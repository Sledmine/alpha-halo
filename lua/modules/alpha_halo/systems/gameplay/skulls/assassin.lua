local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"
local engine = Engine

local assassin = {}

local allUnits = dependencies.names.units

-- Assassin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
---@param isActive boolean
function assassin.skullEffect(isActive)
    local assassinTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(assassinTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.flags.activeCamouflage = true
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        local weapon = tagEntry.data
        if isActive then
            weapon.activeCamoDing = weapon.activeCamoDing * 2
            weapon.activeCamoRegrowthRate = weapon.activeCamoRegrowthRate * 0.5
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

-- Assassin OnTick
local activeCammoCounter = 0
local activeCammoTimer = 300
local wasActive = false

function assassin.onTick(skullState)
    -- TODO WE NEED TO SUPPORT MULTIPLAYER PLAYERS FOR THIS!!!
    local player = Engine.player.getPlayer()
    if not player then
        return
    end
    local playerUnit = engine.object.getObject(player.unitHandle)
    if not playerUnit then
        return
    end

    -- TODO AHORITA VEMOS QUE PEDO
    if true then
        return
    end

    if skullState.isEnabled then

        if not wasActive then
            wasActive = true
            logger.debug("Assassin skull activated: enabling camo.")
        end

        playerUnit.flags0 = true

        if player.meleeKey or player.grenadeHold then
            player.camoScale = 0
        end

        if player.camoScale > 0 then
            if activeCammoCounter > 0 then
                activeCammoCounter = activeCammoCounter - 1
            else
                player.camoScale = 0
                activeCammoCounter = activeCammoTimer
            end
        else
            activeCammoCounter = activeCammoTimer
        end

    else
        if wasActive then
            wasActive = false
            player.isCamoActive = false -- disable camo only once
            logger.debug("Assassin skull deactivated: camo disabled.")
        end
    end
end

return assassin
