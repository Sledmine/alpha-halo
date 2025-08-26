local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local blam = require "blam"
local tagEntries = require "alpha_halo.systems.core.tagEntries"

local skullsManager = {
    paths = {
        effects = {
            plasma = "alpha_firefight\\effects\\skull_banger_plasma",
            flood = "alpha_firefight\\effects\\skull_banger_flood"
        },
        bipeds = {player = "gdd\\characters\\spartan_mp\\spartan_mp"}
    },
    names = {
        weapons = {
            energy = {
                "beam_rifle",
                "brute_plasma_rifle",
                "carbine",
                "energy sword",
                "fuel rod gun",
                "plasma_cannon",
                "plasma pistol",
                "plasma rifle",
                "ghost",
                "wraith",
                "banshee",
                "spirit",
                "shade",
                "hunter"
            },
            kinetic = {
                "assault rifle",
                "battle_rifle",
                "frag grenade",
                "needler",
                "pistol",
                "rocket launcher",
                "shotgun",
                "smg",
                "sniper_gauss",
                "sniper rifle",
                "m90_short",
                "warthog",
                "scorpion"
            }
        },
        actors = {berserk = {"flood", "elite", "odst"}}
    }
}

local skullsEffect = {}

-- This function is called each tick and it's needed for some skulls.
function skullsManager.eachTick()
    --skullsManager.skullFogOnTick()
    --skullsManager.skullBlindOnTick()
    --skullsManager.skullAssassinOnTick()
end

-------------------------------------------------------------- Golden Skulls ----------------------------------------------------------------------------
local allUnits = {"flood", "elite", "grunt", "jackal", "hunter", "odst"}

-- Famine: Makes the AI drop half the ammo.
---@param isActive boolean
function skullsEffect.famine(isActive)
    local famineTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(famineTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.dropWeaponLoaded[1] = actorVariant.dropWeaponLoaded[1] * 0.5
            actorVariant.dropWeaponLoaded[2] = actorVariant.dropWeaponLoaded[2] * 0.5
            actorVariant.dropWeaponAmmo[1] = actorVariant.dropWeaponAmmo[1] * 0.5
            actorVariant.dropWeaponAmmo[2] = actorVariant.dropWeaponAmmo[2] * 0.5
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.famine.active = isActive
    -- logger:debug("Famine {}", isActive and "On" or "Off")
end

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param isActive boolean
function skullsEffect.mythic(isActive)
    local mythicTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(mythicTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.bodyVitality = actorVariant.bodyVitality * 2
            actorVariant.shieldVitality = actorVariant.shieldVitality * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    local playerCollisionTagEntry = findTags("spartan_mp", tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * 1.5
            collisionGeometry.maximumBodyVitality = collisionGeometry.maximumBodyVitality * 1.5
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.mythic.active = isActive
    -- logger:debug("Mythic {}", isActive and "On" or "Off")
end

-- Blind: Hides HUD and duplicates AI burst origin radius.
local blindOnTick = false
---@param isActive boolean
function skullsEffect.blind(isActive)
    local blindTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(blindTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            actorVariant.burstOriginRadius = actorVariant.burstOriginRadius * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    blindOnTick = true
    -- skullsManager.skulls.blind.active = isActive
    -- logger:debug("Blind {}", isActive and "On" or "Off")
end

-- Blind OnTick
function skullsEffect.skullBlindOnTick()
    if blindOnTick == true then
        if skullsManager.skulls.blind.spent > 0 then
            execute_script("show_hud 0")
        else
            execute_script("show_hud 1")
            blindOnTick = false
        end
    end
end

-- Catch: Makes the AI launch grenades a fuck lot.
---@param isActive boolean
function skullsEffect.catch(isActive)
    local catchTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(catchTagsFiltered) do
        local actorVariant = tagEntry.data
        if isActive then
            -- actorVariant.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.visibleTarget
            actorVariant.flags:hasUnlimitedGrenades(true)
            actorVariant.grenadeChance = actorVariant.grenadeChance + 1
            actorVariant.grenadeCheckTime = actorVariant.grenadeCheckTime * 0.1
            actorVariant.encounterGrenadeTimeout = actorVariant.encounterGrenadeTimeout * 0
            actorVariant.grenadeCount[1] = actorVariant.grenadeCount[1] + 1
            actorVariant.grenadeCount[2] = actorVariant.grenadeCount[2] + 1
            if not tagEntry.path:includes("odst") then
                actorVariant.grenadeVelocity = actorVariant.grenadeVelocity * 2
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.catch.active = isActive
    -- logger:debug("Catch {}", isActive and "On" or "Off")
end

-------------------------------------------------------------- Silver Skulls ----------------------------------------------------------------------------

---Berserk: Makes the AI enter in constant Berserk state.
---@param isActive boolean
function skullsEffect.berserk(isActive)
    local berserkActorsFiltered = table.filter(tagEntries.actor(), function(tagEntry)
        for _, unitName in pairs(skullsManager.names.actors.berserk) do
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

---Tough Luck: Makes AI react to everything and enhances their senses.
---@param isActive boolean
function skullsEffect.toughluck(isActive)
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

---Fog: Turns off a HUD element & aguments AI surprise distance.
---@param isActive boolean
function skullsEffect.fog(isActive)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if isActive then
            actor.surpriseDistance = actor.surpriseDistance + 10
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
end

function skullsManager.skullFogOnTick()
    -- TODO Retrieve previous state of the motion sensor using transpilation
    local previousMotionSensorState = false
    if previousMotionSensorState then
        if skullsManager.skulls.fog.spent > 0 then
            execute_script("hud_show_motion_sensor 0")
        else
            execute_script("hud_show_motion_sensor 1")
            fogOnTick = false
        end
    end
end

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param isActive boolean
function skullsEffect.knucklehead(isActive)
    local knuckleheadTagsFiltered = table.filter(tagEntries.modelCollisionGeometry(),
                                                 function(tagEntry)
        for _, unitName in pairs(allUnits) do
            if tagEntry.path:includes(unitName) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(knuckleheadTagsFiltered) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if isActive then
                if material.flags:head() then
                    shield = shield * 25
                    body = body * 25
                end
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    for _, tagEntry in ipairs(tagEntries.impactDamageEffect()) do
        local damageEffectModifier = tagEntry.data
        if isActive then
            damageEffectModifier.grunt = damageEffectModifier.grunt * 0.2
            damageEffectModifier.jackal = damageEffectModifier.jackal * 0.2
            damageEffectModifier.elite = damageEffectModifier.elite * 0.2
            damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 0.2
            damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 0.2
            damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 0.2
            damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.knucklehead.active = isActive
    -- logger:debug("Knucklehead {}", isActive and "On" or "Off")
end

---Cowbell: Doubles bipeds & vehicles accelerationScale.
---@param isActive boolean
function skullsEffect.cowbell(isActive)
    for _, tagEntry in ipairs(tagEntries.biped()) do
        local bipedTag = tagEntry.data
        if isActive then
            bipedTag.accelerationScale = bipedTag.accelerationScale * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    for _, tagEntry in ipairs(tagEntries.vehicle()) do
        local vehicle = tagEntry.data
        if isActive then
            vehicle.accelerationScale = vehicle.accelerationScale * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.cowbell.active = isActive
    -- logger:debug("Cowbell {}", isActive and "On" or "Off")
end

---Havok: Doubles all damage_effect's damage radius, and it scales properly.
---@param isActive boolean
function skullsEffect.havok(isActive)
    for _, tagEntry in ipairs(tagEntries.explosionDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.radius[2] = damageEffect.radius[2] * 1.5
            damageEffect.damageLowerBound = damageEffect.damageLowerBound * 0.75
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.havok.active = isActive
    -- logger:debug("Havok {}", isActive and "On" or "Off")
end

---Newton: Augments instant acceleration for melee damages.
---@param isActive boolean
function skullsEffect.newton(isActive)
    for _, tagEntry in ipairs(tagEntries.meleeDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.damageInstantaneousAcceleration.i =
                damageEffect.damageInstantaneousAcceleration.i + 5
            if tagEntry.path:includes("response") then
                damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 1
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.newton.active = isActive
    -- logger:debug("Newton {}", isActive and "On" or "Off")
end

---Tilt: Doubles strenghts and weakenesses.
---@param isActive boolean
function skullsEffect.tilt(isActive)
    local energyDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(skullsManager.names.weapons.energy) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    local kineticDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(skullsManager.names.weapons.kinetic) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end) -- This is a kinda nuttered version of Tilt, in hopes to reduce the load on the game.
    for _, tagEntry in ipairs(energyDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * 0.5
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * 0.5
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * 0.5
                damageEffectModifier.grunt = damageEffectModifier.grunt * 0.5
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * 0.5
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 0.5
                damageEffectModifier.elite = damageEffectModifier.elite * 0.5
                damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 2
                damageEffectModifier.jackal = damageEffectModifier.jackal * 0.5
                damageEffectModifier.jackalEnergyShield =
                    damageEffectModifier.jackalEnergyShield * 2
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 0.5
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 0.5
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    for _, tagEntry in ipairs(kineticDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if isActive then
                damageEffectModifier.metalHollow = damageEffectModifier.metalHollow * 2
                damageEffectModifier.metalThick = damageEffectModifier.metalThick * 2
                damageEffectModifier.metalThin = damageEffectModifier.metalThin * 2
                damageEffectModifier.grunt = damageEffectModifier.grunt * 2
                damageEffectModifier.hunterArmor = damageEffectModifier.hunterArmor * 2
                damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 2
                damageEffectModifier.elite = damageEffectModifier.elite * 2
                damageEffectModifier.eliteEnergyShield =
                    damageEffectModifier.eliteEnergyShield * 0.5
                damageEffectModifier.jackal = damageEffectModifier.jackal * 2
                damageEffectModifier.jackalEnergyShield =
                    damageEffectModifier.jackalEnergyShield * 0.5
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 2
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 2
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    -- skullsManager.skulls.tilt.active = isActive
    -- logger:debug("Tilt {}", isActive and "On" or "Off")
end

---Banger: Makes Grunts and Human Floods explode after dying.
---@param isActive boolean
function skullsEffect.banger(isActive)
    local plasmaExplosion = findTags(skullsManager.paths.effects.plasma, tagClasses.effect)[1]
    local floodExplosion = findTags(skullsManager.paths.effects.flood, tagClasses.effect)[1]
    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("grunt") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        elseif tagEntry.path:includes("floodcombat_marine") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold =
                    collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    -- skullsManager.skulls.banger.active = isActive
    -- logger:debug("Banger {}", isActive and "On" or "Off")
end

-- Double Down: Duplicates player's shields, but also it's recharging time.
---@param isActive boolean
function skullsEffect.doubledown(isActive)
    local playerCollisionTagEntry = findTags(skullsManager.paths.bipeds.player,
                                             tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry)
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if isActive then
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * 2
            collisionGeometry.stunTime = collisionGeometry.stunTime * 2
            collisionGeometry.rechargeTime = collisionGeometry.rechargeTime * 2
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.doubledown.active = isActive
    -- logger:debug("Double Down {}", isActive and "On" or "Off")
end

-- Eye Patch: Eliminates weapons assistances & initial error.
---@param isActive boolean
function skullsEffect.eyepatch(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        -- if not tagEntry.data.weaponType == engine.tag.weaponType.needler then -- We spare the Needler of this skull.
        local weapon = tagEntry.data
        if isActive then
            weapon.autoaimAngle = 0
            weapon.magnetismAngle = 0
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.minimumError = 0
                trigger.errorAngle[1] = 0
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
        -- end -- Comment this if you want to apply the skull to the Needler as well (It will not track targets).
    end
    -- skullsManager.skulls.eyepatch.active = isActive
    -- logger:debug("Eye Patch {}", isActive and "On" or "Off")
end

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param isActive boolean
function skullsEffect.triggerswitch(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                --if trigger.flags:doesNotRepeatAutomatically() == false then
                if not trigger.flags.doesNotRepeatAutomatically then
                    trigger.flags.doesNotRepeatAutomatically = true
                else
                    trigger.flags.doesNotRepeatAutomatically = false
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.triggerswitch.active = isActive
    -- logger:debug("Trigger Switch {}", isActive and "On" or "Off")
end

-- Slayer: Weapons shoot doble rounds and waste double ammo.
---@param isActive boolean
function skullsEffect.slayer(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            -- for i = 1, tagEntry.data.magazines.count do
            --    local magazine = tagEntry.data.magazines.elements[i]
            --    magazine.roundsLoadedMaximum = magazine.roundsLoadedMaximum * 2
            -- end -- This whole mechanic might be turn into a new skull all together.
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                -- trigger.roundsPerShot = trigger.roundsPerShot * 2
                trigger.projectilesPerShot = trigger.projectilesPerShot * 2
                trigger.errorAngle[2] = trigger.errorAngle[2] * 2
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    -- skullsManager.skulls.slayer.active = isActive
    -- logger:debug("Slayer {}", isActive and "On" or "Off")
end

-- Assassin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
local assassinOnTick = false
---@param isActive boolean
function skullsEffect.assassin(isActive)
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
            actorVariant.flags:activeCamouflage(true)
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
    assassinOnTick = true
    -- skullsManager.skulls.assassin.active = isActive
    -- logger:debug("Assassin {}", isActive and "On" or "Off")
end

-- Assassin OnTick
local activeCammoCounter = 0
local activeCammoTimer = 300
function skullsManager.skullAssassinOnTick()
    if assassinOnTick == true then
        local player = blam.biped(get_dynamic_player())
        if not player then
            return
        end
        if skullsManager.skulls.assassin.spent > 0 then
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
        else
            player.isCamoActive = false
            assassinOnTick = false
        end
    end
end

skullsManager.skulls = {
    famine = {
        name = "Famine",
        effect = skullsEffect.famine,
        state = {count = 0, max = 1, multiplier = 1},
        isEnabled = false,
        isPermanent = false
    },
    mythic = {
        name = "Mythic",
        effect = skullsEffect.mythic,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    blind = {
        name = "Blind",
        effect = skullsEffect.blind,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    catch = {
        name = "Catch",
        effect = skullsEffect.catch,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    berserk = {
        name = "Berserk",
        effect = skullsEffect.berserk,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    toughluck = {
        name = "Though Luck",
        effect = skullsEffect.toughluck,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    fog = {
        name = "Fog",
        effect = skullsEffect.fog,
        state = {count = 0, max = 1},
        isEnabled = false,
        onTick = function()

        end,
        isPermanent = false
    },
    knucklehead = {
        name = "Knucklehead",
        effect = skullsEffect.knucklehead,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    cowbell = {
        name = "Cowbell",
        effect = skullsEffect.cowbell,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    havok = {
        name = "Havok",
        effect = skullsEffect.havok,
        state = {count = 0, max = 1},
        isPermanent = false
    },
    newton = {
        name = "Newton",
        effect = skullsEffect.newton,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    tilt = {
        name = "Tilt",
        effect = skullsEffect.tilt,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    banger = {
        name = "Banger",
        effect = skullsEffect.banger,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    doubledown = {
        name = "Double Down",
        effect = skullsEffect.doubledown,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    eyepatch = {
        name = "Eye Patch",
        effect = skullsEffect.eyepatch,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    triggerswitch = {
        name = "Trigger Switch",
        effect = skullsEffect.triggerswitch,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    slayer = {
        name = "Slayer",
        effect = skullsEffect.slayer,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    },
    assassin = {
        name = "Assassin",
        effect = skullsEffect.assassin,
        state = {count = 0, max = 1},
        isEnabled = false,
        isPermanent = false
    }
}

local skullList = {
    skullsManager.skulls.famine,
    skullsManager.skulls.mythic,
    skullsManager.skulls.blind,
    skullsManager.skulls.catch,
    skullsManager.skulls.berserk,
    skullsManager.skulls.toughluck,
    skullsManager.skulls.fog,
    skullsManager.skulls.knucklehead,
    skullsManager.skulls.cowbell,
    skullsManager.skulls.havok,
    skullsManager.skulls.newton,
    skullsManager.skulls.tilt,
    skullsManager.skulls.banger,
    skullsManager.skulls.doubledown,
    skullsManager.skulls.eyepatch,
    skullsManager.skulls.triggerswitch,
    skullsManager.skulls.slayer,
    skullsManager.skulls.assassin
}
skullsManager.skullList = skullList

-- Functions to enable/disable skulls --

--- Initiate Skull Effect applying its function the number of times specified in its state.
local function initiateSkullEffect(skull)
    --for i = 1, skull.state.count do
        --skull.effect(true)
        pcall(skull.effect, true)
    --end
end

local function isSkullAvailable(name)
    for _, skull in ipairs(skullList) do
        if name == skull.name:lower() then
            return skull.state.count < skull.state.max
        end
    end
    return false
end

local function spendSkull(skull)
    skull.state.count = skull.state.count + 1
    if skull.state.count > skull.state.max then
        skull.state.count = skull.state.max
        logger:warning("Skull '{}' has reached its maximum count of {}.", skull.name,
                       skull.state.max)
    end
    skullsManager.enableSkull(skull.name)
end

local function restoreSkull(skull)
    skull.state.count = skull.state.count - 1
    if skull.state.count < 0 then
        skull.state.count = 0
        logger:warning("Skull '{}' is already at its minimum count of 0.", skull.name)
    end
    skullsManager.disableSkull(skull.name)
end

---Enable skull balancing count availability against its max.
---@param name string | "random" | "all"
function skullsManager.enableSkullWithBalance(name)
    local name = name:lower()
    -- Use the existing enableSkull function to activate the skull
    for _, skull in ipairs(skullList) do
        if name == skull.name:lower() then
            if isSkullAvailable(name) then
                spendSkull(skull)
            end
            return
        elseif name == "all" then
            if isSkullAvailable(skull.name:lower()) then
                spendSkull(skull)
            end
        elseif name == "random" then
            local randomIndex = math.random(1, #skullList)
            local randomSkull = skullList[randomIndex]
            if isSkullAvailable(randomSkull.name:lower()) then
                spendSkull(randomSkull)
            end
        end
    end
end

---Disable skull balancing count availability against its max.
---@param name string | "random" | "all"
function skullsManager.disableSkullWithBalance(name)
    local name = name:lower()
    -- Use the existing disableSkull function to deactivate the skull
    for _, skull in ipairs(skullList) do
        if name == skull.name:lower() then
            if skull.state.count > 0 then
                restoreSkull(skull)
            end
            return
        elseif name == "all" then
            if skull.state.count > 0 then
                restoreSkull(skull)
            end
        elseif name == "random" then
            local randomIndex = math.random(1, #skullList)
            local randomSkull = skullList[randomIndex]
            if randomSkull.state.count > 0 then
                restoreSkull(randomSkull)
            end
        end
    end
end

---Activate Specified Skull by type and name
---@param name string | "random" | "all"
function skullsManager.enableSkull(name)
    local name = name:lower()

    -- Disable all skulls to revert their effects
    --logger:debug("Reverting all skull effects before enabling new ones.")
    for _, skull in ipairs(skullList) do
        skull.effect(false)
    end

    -- Enable desired skull
    for _, skull in ipairs(skullList) do
        if name == skull.name:lower() then
            skull.isEnabled = true
            --logger:info("Enabling Skull: {} x{}", skull.name, skull.state.multiplier)
            logger:info("Enabling Skull: {}", skull.name)
        elseif name == "all" then
            skull.isEnabled = true
            logger:info("Enabling Skull: {}", skull.name)
        elseif name == "random" then
            local randomIndex = math.random(1, #skullList)
            skullList[randomIndex].isEnabled = true
            logger:info("Enabling Skull: {}", skull.name)
            break
        end
    end

    -- Initiate the effect of the enabled skulls
    for _, skull in ipairs(skullList) do
        if skull.isEnabled then
            initiateSkullEffect(skull)
        end
    end
end

---Deactivate specified Skull by type and name
---@param name string | "random" | "all"
function skullsManager.disableSkull(name)
    local name = name:lower()
    -- Check if the skullList is valid and name is provided
    if not name or not skullsManager.skulls[name] and name ~= "random" and name ~= "all" then
        logger:error("Invalid skull name. Usage: deactivate_skull [ <name> | <random> | <all> ]")
        return
    end

    -- Disable desired skull
    for _, skull in ipairs(skullList) do
        if name == skull.name:lower() then
            skull.isEnabled = false
        elseif name == "all" then
            skull.isEnabled = false
        elseif name == "random" then
            local randomIndex = math.random(1, #skullList)
            skullList[randomIndex].isEnabled = false
            break
        end
    end

    -- Revert the effect of the disabled skulls
    for _, skull in ipairs(skullList) do
        if not skull.isEnabled then
            logger:info("Disabling Skull: {}", skull.name)
            --skull.effect(false)
        end
    end
end

return skullsManager
