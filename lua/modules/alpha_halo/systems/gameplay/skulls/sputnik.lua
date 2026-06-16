--local tagEntries = require "alpha_halo.systems.core.tagEntries"
local hsc = require "hsc"
local blam = require "blam"
local blam2 = require "blam2"
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local dependencies = require "alpha_halo.systems.gameplay.skullsDependencies"

local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local findTags = Engine.tag.findTags

local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local damageEffects = dependencies.paths.damageEffects

local sputnikTagEntry
local finalSkullPower

local sputnik = {}

--local defaultGravity = blam.globalGravity()
local defaultGravity = 0.00356518

---Sputnik: Halves gravity and adds acceleration to firing responses.
---@param isActive boolean
function sputnik.skullEffect(isActive, totalSkullPower)
    finalSkullPower = totalSkullPower or 1
    if isActive then
        blam2.globalGravity(defaultGravity / (2 * finalSkullPower))
        local sputnikAccelerationTag = findTags(damageEffects.sputnik, tagClasses.damageEffect)[1]
        if not sputnikAccelerationTag then
            return
        end
        sputnikTagEntry = table.find(tagEntries.damageEffect(), function(tagEntry)
            return tagEntry.handle.value == sputnikAccelerationTag.handle.value
        end)
        assert(sputnikTagEntry)
    else
        blam2.globalGravity(defaultGravity)
    end
end

-- Sputnik OnTick
local wasActive = false
function sputnik.onTick(skullState)
    if skullState.isEnabled then
        if not wasActive then
            wasActive = true
            logger:debug("Sputnik skull activated: enabling effect.")
        end

        for playerIndex = 0, 15 do
            local player = getPlayer(playerIndex) -- Player.
            if not player then
                return
            end

            local playerBiped = getObject(player.objectHandle, objectTypes.biped) -- Player Object.
            if not playerBiped then
                return
            end

            local blamBiped = blam.biped(get_object(player.objectHandle.value)) -- Blam Biped.
            assert(blamBiped, "Biped tag must exist")

            local playerUnit = hsc.unit(hsc.list_get(hsc.players(), playerIndex)) -- Hsc Unit.
            assert(playerUnit, "Player unit must exist")

            local sputnikAcceleration
            if blamBiped.shooting == 1 then --  or playerBiped.unitControlFlags.exchangeWeapon? Esto siempre se detecta por alguna razón, no sirve por ahora.
                logger:info("Player weapon swap detected.")

                local weaponObjectHandle = playerBiped.weapons[blamBiped.weaponSlot + 1] -- Weapon Handler.
                if not weaponObjectHandle or (weaponObjectHandle and weaponObjectHandle:isNull()) then
                    return
                end

                local weaponObject = getObject(weaponObjectHandle, objectTypes.weapon) -- Weapon Object.
                if not weaponObject then
                    return
                end

                local weaponTag = table.find(tagEntries.weapon(), function(tagEntry) -- Weapon Tag.
                    return tagEntry.handle.value == weaponObject.tagHandle.value
                end)
                if not weaponTag then
                    logger:error("Weapon tag constant must exist")
                    return
                end

                local trigger = weaponTag.data.triggers.elements[1]
                local weaponMaxROF
                if trigger.maximumRateOfFire[2] > 0 then
                    weaponMaxROF = trigger.maximumRateOfFire[2]
                else
                    weaponMaxROF = 5
                end
                sputnikAcceleration = ((30 / weaponMaxROF) * 0.005) -- Get Acc Calc based on Weapon
            end

            if blamBiped.shooting == 1 then
                blamBiped.xVel = blamBiped.xVel - (blamBiped.cameraX * sputnikAcceleration)
                blamBiped.yVel = blamBiped.yVel - (blamBiped.cameraY * sputnikAcceleration)
                blamBiped.zVel = blamBiped.zVel - (blamBiped.cameraZ * sputnikAcceleration)
                logger:info("Acc per Shot: {}, {}, {}", blamBiped.xVel, blamBiped.yVel, blamBiped.zVel)
            end
        end
    else
        if wasActive then
            wasActive = false
            logger:debug("Sputnik skull deactivated: effect disabled.")
        end
    end
end

return sputnik