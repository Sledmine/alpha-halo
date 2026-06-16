--local tagEntries = require "alpha_halo.systems.core.tagEntries"
local blam = require "blam"
local blam2 = require "blam2"
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local objectTypes = Engine.tag.objectType
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
            local player = getPlayer(playerIndex)
            if not player then
                return
            end

            local playerBiped = getObject(player.objectHandle, objectTypes.biped)
            if not playerBiped then
                return
            end

            local blamBiped = blam.biped(get_object(player.objectHandle.value))
            assert(blamBiped)

            local sputnikAcceleration
            if blamBiped.shooting == 1 then --  CONDICION TEMPORAL. Esto debería ocurrir solo cuando el jugador cambie de arma.
                logger:info("Player weapon swap detected.")

                local weaponObjectHandle = playerBiped.weapons[blamBiped.weaponSlot + 1]
                if not weaponObjectHandle or (weaponObjectHandle and weaponObjectHandle:isNull()) then
                    return
                end

                local weaponObject = getObject(weaponObjectHandle, objectTypes.weapon)
                if not weaponObject then
                    return
                end

                local weaponTag = table.find(tagEntries.weapon(), function(tagEntry)
                    return tagEntry.handle.value == weaponObject.tagHandle.value
                end)
                if not weaponTag then
                    return
                end

                local trigger = weaponTag.data.triggers.elements[1]
                local weaponMaxROF
                if trigger.maximumRateOfFire[2] > 0 then
                    weaponMaxROF = trigger.maximumRateOfFire[2]
                else
                    weaponMaxROF = 5
                end
                if weaponMaxROF >= 10 then
                    sputnikAcceleration = ((30 / weaponMaxROF) * 0.01)
                else
                    sputnikAcceleration = ((30 / weaponMaxROF) * 0.005) -- VALOR TEMPORAL. Cuando se arregle la condicion del trigger, la aceleración se reducirá al nivel del ROF del arma.
                end -- Justo ahora se aplica la aceleración cada tick por culpa de la condicionante placeholder. *0.01 se volverá el estandar cuando se resuelva la condicionante.
            end

            if blamBiped.shooting == 1 then  --  CONDICION TEMPORAL. Esto debería ocurrir solo cuando el arma dispare.
                if blamBiped.isOnGround == false then
                    blamBiped.xVel = blamBiped.xVel - (blamBiped.cameraX * sputnikAcceleration)
                    blamBiped.yVel = blamBiped.yVel - (blamBiped.cameraY * sputnikAcceleration)
                    blamBiped.zVel = blamBiped.zVel - (blamBiped.cameraZ * sputnikAcceleration)
                else
                    blamBiped.xVel = blamBiped.xVel - (blamBiped.cameraX * sputnikAcceleration * 2.5)
                    blamBiped.yVel = blamBiped.yVel - (blamBiped.cameraY * sputnikAcceleration * 2.5)
                    blamBiped.zVel = blamBiped.zVel - (blamBiped.cameraZ * sputnikAcceleration * 2.5)
                end
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