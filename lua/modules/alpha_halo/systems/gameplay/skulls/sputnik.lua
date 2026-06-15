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
local effects = dependencies.paths.effects

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
        local sputnikAccelerationTag = findTags(effects.sputnik, tagClasses.damageEffect)[1]
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

            -- Esto solo sirve cuando recojes un arma, necesitamos que tambien funcione cuando cambias de arma.
            if blamBiped.meleeKey then --  or playerBiped.unitControlFlags.exchangeWeapon? Esto siempre se detecta por alguna razón, no sirve por ahora.
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
                local sputnikAcceleration = ((30 / weaponMaxROF) * 0.25)
                local accelerationMultiplier = sputnikAcceleration * finalSkullPower -- Get Acc Calc based on Weapon

                local damageEffect = sputnikTagEntry.data
                damageEffect.damageInstantaneousAcceleration.i = accelerationMultiplier
                damageEffect.damageFlags:skipsShields(true)
                damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 0.001
                logger:info("Acc per Shot: {}", damageEffect.damageInstantaneousAcceleration.i) -- Apply Acc Calc to Damage Tag.
            end

            if blamBiped.weaponPTH then
                hsc.damage_object("alpha_firefight\\skulls\\sputnik\\_fx\\sputnik_acceleration", blamBiped) -- Apply Damage Effect to Player.
                logger:info("Applying Sputnik acceleration effect to player.")
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