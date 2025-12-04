local tagEntries = require "alpha_halo.systems.core.tagEntries"
local const = require "alpha_halo.systems.core.constants"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local tarkov = {}

---Tarkov: Wastes all rounds in magazines when reloading, but doubles their cappacity.
---@param isActive boolean
function tarkov.skullEffect(isActive)
    if not const.shaders.transparentChicago.brCounter and const.shaders.transparentChicago.glCounter.data then
        return
    end
    local brCounterShader = const.shaders.transparentChicago.brCounter.data
    local glCountershader = const.shaders.transparentChicago.glCounter.data
    if not const.hud.extAssaultRifle then
        return
    end
    local arHUD = const.hud.extAssaultRifle.data
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, arHUD.numberElements.count do
                local hudElement = arHUD.numberElements.elements[i]
                hudElement.maximumNumberOfDigits = 3
            end
            local weapon = tagEntry.data
            for i = 1, weapon.magazines.count do
                local magazine = weapon.magazines.elements[i]
                magazine.flags.wastesRoundsWhenReloaded = true
                magazine.roundsLoadedMaximum = magazine.roundsLoadedMaximum * 2
                magazine.roundsReloaded = magazine.roundsReloaded * 2
            end

            local glCounterLimit = glCountershader.numericCounterLimit
            local brCounterLimit = brCounterShader.numericCounterLimit
            if (brCounterLimit and brCounterLimit > 0) and (glCounterLimit and glCounterLimit > 0) then
                brCounterShader.numericCounterLimit = 72
                glCountershader.numericCounterLimit = 72
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
            Balltze.features.reloadTagData(const.hud.extAssaultRifle.handle)
            Balltze.features.reloadTagData(const.shaders.transparentChicago.brCounter.handle)
            Balltze.features.reloadTagData(const.shaders.transparentChicago.glCounter.handle)
        end
    end

    local weapons = dependencies.names.weapons
    local energyWeapons = table.filter(tagEntries.weapon(), function(tagEntry)
        for _, keyword in pairs(weapons.energy) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(energyWeapons) do
        local weaponModifier = tagEntry.data
        if isActive then
            weaponModifier.heatRecoveryThreshold = 0.001
            weaponModifier.heatLossRate = weaponModifier.heatLossRate * 0.5
            for i = 1, weaponModifier.triggers.count do
                local trigger = weaponModifier.triggers.elements[i]
                if trigger and trigger.heatGeneratedPerRound < 1 then
                    trigger.heatGeneratedPerRound = trigger.heatGeneratedPerRound * 0.4
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.tarkov.active = isActive
    -- logger:debug("Tarkov {}", isActive and "On" or "Off")
end

return tarkov