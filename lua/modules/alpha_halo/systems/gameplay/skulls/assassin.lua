local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"
local blam = require "blam"

local assassin = {}

local allUnits = dependencies.names.units

-- Assassin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
local assassinOnTick = false
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
    if isActive then
        assassinOnTick = true
    else
        assassinOnTick = false
    end
end

-- Assassin OnTick
local activeCammoCounter = 0
local activeCammoTimer = 300
function assassin.onTick(skullState)
    if assassinOnTick then
        local player = blam.biped(get_dynamic_player())
        if not player then
            return
        end
        if skullState.isEnabled then
            player.isCamoActive = true
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
        else -- We add onTick variable in order to only set isCamoActive to false one tick, and not constantly.
            player.isCamoActive = false -- Otherwise, it will permanently turn off active cammo, even with powerups.
            assassinOnTick = false
        end
    end
end

return assassin