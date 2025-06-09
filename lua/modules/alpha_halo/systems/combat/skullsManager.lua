local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
--local blam = require "blam"
local tagEntries = require "alpha_halo.systems.core.tagEntries"
local player
local biped

local skullsManager = {}

-- This function is called each tick and it's needed for some skulls.
function skullsManager.eachTick()
    skullsManager.skullFogOnTick(false)
    skullsManager.skullBlindOnTick(false)
    skullsManager.skullAssassinOnTick(false)
end

-------------------------------------------------------------- Golden Skulls ----------------------------------------------------------------------------
local allUnits = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "odst"
}

-- Famine: Makes the AI drop half the ammo.
---@param isActive boolean
function skullsManager.famine(isActive)
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
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0.01
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.famine.active = isActive
    -- logger:debug("Famine {}", isActive and "On" or "Off")
end

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param isActive boolean
function skullsManager.mythic(isActive)
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
    skullsManager.skulls.mythic.active = isActive
    -- logger:debug("Mythic {}", isActive and "On" or "Off")
end

-- Blind: Hides HUD and duplicates AI burst origin radius.
---@param isActive boolean
function skullsManager.blind(isActive)
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
    skullsManager.skulls.blind.active = isActive
    skullsManager.skullBlindOnTick(true)
    -- logger:debug("Blind {}", isActive and "On" or "Off")
end

-- Blind OnTick
---@param isActive boolean
function skullsManager.skullBlindOnTick(isActive)
    if not isActive and skullsManager.skulls.blind.active then
        execute_script("show_hud 0")
    elseif isActive and not skullsManager.skulls.blind.active then
        execute_script("show_hud 1")
    end
end

-- Catch: Makes the AI launch grenades a fuck lot.
---@param isActive boolean
function skullsManager.catch(isActive)
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
            actorVariant.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.visibleTarget
            actorVariant.flags:hasUnlimitedGrenades(true)
            actorVariant.grenadeChance = actorVariant.grenadeChance + 1
            actorVariant.grenadeCheckTime = actorVariant.grenadeCheckTime * 0.1
            actorVariant.encounterGrenadeTimeout = actorVariant.encounterGrenadeTimeout * 0.01
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0.1
            if not tagEntry.path:includes("odst") then
                actorVariant.grenadeVelocity = actorVariant.grenadeVelocity * 2
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.catch.active = isActive
    -- logger:debug("Catch {}", isActive and "On" or "Off")
end

-------------------------------------------------------------- Silver Skulls ----------------------------------------------------------------------------

---Berserk: Makes the AI enter in constant Berserk state.
---@param isActive boolean
function skullsManager.berserk(isActive)
    local berserkUnits = {"flood", "elite", "hunter", "odst"}
    local berserkActorsFiltered = table.filter(tagEntries.actor(), function(tagEntry)
        for _, unitName in pairs(berserkUnits) do
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
    skullsManager.skulls.berserk.active = isActive
    -- logger:debug("Berserk {}", isActive and "On" or "Off")
end

---Tough Luck: Makes AI react to everything and enhances their senses.
---@param isActive boolean
function skullsManager.toughluck(isActive)
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
    skullsManager.skulls.toughluck.active = isActive
    -- logger:debug("Tough Luck {}", isActive and "On" or "Off")
end

---Fog: Turns off a HUD element & aguments AI surprise distance.
---@param isActive boolean
function skullsManager.fog(isActive)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if isActive then
            actor.surpriseDistance = actor.surpriseDistance + 10
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.fog.active = isActive
    skullsManager.skullFogOnTick(true)
    -- logger:debug("Fog {}", isActive and "On" or "Off")
end

---- Fog Table
--skullsManager.fogTable = {
--    motion_sensor = {
--        name = "Motion Sensor",
--        func = execute_script("hud_show_motion_sensor 0"),
--        active = false
--    },
--    health = {
--        name = "Health",
--        func = execute_script("hud_show_health 0"),
--        active = false
--    },
--    shield = {
--        name = "Shield",
--        func = execute_script("hud_show_shield 0"),
--        active = false
--    },
--    crosshair = {
--        name = "Crosshair",
--        func = execute_script("hud_show_crosshair 0"),
--        active = false
--    }
--}
---- Fog OnTick
--local fogCounter = 0
--local fogTimer = 300
---@param isActive boolean
function skullsManager.skullFogOnTick(isActive)
    if not isActive and skullsManager.skulls.fog.active then
        execute_script("hud_show_motion_sensor 0")
        --if fogCounter > 0 then
        --    fogCounter = fogCounter - 1
        --    logger:debug("Fog countdown: {}", fogCounter)
        --else
        --    execute_script("show_hud 1")
        --    local fogElements = skullsManager.fogTable
        --    local randomElement = fogElements[math.random(#fogElements)]
        --    randomElement.func()
        --    fogCounter = fogTimer
        --end
    elseif isActive and not skullsManager.skulls.fog.active then
        execute_script("hud_show_motion_sensor 1")
        --execute_script("show_hud 1")
    end
end

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param isActive boolean
function skullsManager.knucklehead(isActive)
    local knuckleheadTagsFiltered = table.filter(tagEntries.modelCollisionGeometry(), function(tagEntry)
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
    skullsManager.skulls.knucklehead.active = isActive
    -- logger:debug("Knucklehead {}", isActive and "On" or "Off")
end

---Cowbell: Doubles bipeds & vehicles accelerationScale.
---@param isActive boolean
function skullsManager.cowbell(isActive)
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
    skullsManager.skulls.cowbell.active = isActive
    -- logger:debug("Cowbell {}", isActive and "On" or "Off")
end

---Havok: Doubles all damage_effect's damage radius, and it scales properly.
---@param isActive boolean
function skullsManager.havok(isActive)
    for _, tagEntry in ipairs(tagEntries.explosionDamageEffect()) do
        local damageEffect = tagEntry.data
        if isActive then
            damageEffect.radius[2] = damageEffect.radius[2] * 1.5
            damageEffect.damageLowerBound = damageEffect.damageLowerBound * 0.5
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.havok.active = isActive
    -- logger:debug("Havok {}", isActive and "On" or "Off")
end

---Newton: Augments instant acceleration for melee damages.
---@param isActive boolean
function skullsManager.newton(isActive)
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
    skullsManager.skulls.newton.active = isActive
    -- logger:debug("Newton {}", isActive and "On" or "Off")
end

---Tilt: Doubles strenghts and weakenesses.
---@param isActive boolean
function skullsManager.tilt(isActive)
    local energyWeapons = {
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
    }
    local kineticWeapons = {
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
    local energyDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(energyWeapons) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    local kineticDamageEffect = table.filter(tagEntries.damageEffect(), function(tagEntry)
        for _, keyword in pairs(kineticWeapons) do
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
                damageEffectModifier.jackalEnergyShield = damageEffectModifier.jackalEnergyShield * 2
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
                damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 0.5
                damageEffectModifier.jackal = damageEffectModifier.jackal * 2
                damageEffectModifier.jackalEnergyShield = damageEffectModifier.jackalEnergyShield * 0.5
                damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 2
                damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 2
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    skullsManager.skulls.tilt.active = isActive
    -- logger:debug("Tilt {}", isActive and "On" or "Off")
end

---Banger: Makes Grunts and Human Floods explode after dying.
---@param isActive boolean
function skullsManager.banger(isActive)
    local plasmaExplosion = findTags("alpha_firefight\\effects\\skull_banger_plasma", tagClasses.effect)[1]
    local floodExplosion = findTags("alpha_firefight\\effects\\skull_banger_flood", tagClasses.effect)[1]
    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("grunt") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold = collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        elseif tagEntry.path:includes("floodcombat_human") then
            local collisionGeometry = tagEntry.data
            if isActive then
                collisionGeometry.bodyDamagedThreshold = collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
            else
                Balltze.features.reloadTagData(tagEntry.handle)
            end
        end
    end
    skullsManager.skulls.banger.active = isActive
    -- logger:debug("Banger {}", isActive and "On" or "Off")
end

-- Double Down: Duplicates player's shields, but also it's recharging time.
---@param isActive boolean
function skullsManager.doubledown(isActive)
    local playerCollisionTagEntry = findTags("gdd\\characters\\spartan_mp\\spartan_mp", tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
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
    skullsManager.skulls.doubledown.active = isActive
    -- logger:debug("Double Down {}", isActive and "On" or "Off")
end

-- Eye Patch: Eliminates weapons assistances & initial error.
---@param isActive boolean
function skullsManager.eyepatch(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        local weapon = tagEntry.data
        if isActive then
            weapon.autoaimAngle = weapon.autoaimAngle * 0.01
            weapon.autoaimRange = weapon.autoaimRange * 0.01
            weapon.magnetismAngle = weapon.magnetismAngle * 0.01
            weapon.magnetismRange = weapon.magnetismRange * 0.01
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 0.01
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.eyepatch.active = isActive
    -- logger:debug("Eye Patch {}", isActive and "On" or "Off")
end

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param isActive boolean
function skullsManager.triggerswitch(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                if trigger.flags:doesNotRepeatAutomatically() == false then
                    trigger.flags:doesNotRepeatAutomatically(true)
                else
                    trigger.flags:doesNotRepeatAutomatically(false)
                end
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.triggerswitch.active = isActive
    -- logger:debug("Trigger Switch {}", isActive and "On" or "Off")
end

-- Slayer: Weapons shoot doble rounds and waste double ammo.
---@param isActive boolean
function skullsManager.slayer(isActive)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if isActive then
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.roundsPerShot = trigger.roundsPerShot * 2
                trigger.projectilesPerShot = trigger.projectilesPerShot * 2
                trigger.errorAngle[1] = trigger.errorAngle[1] * 2
                trigger.errorAngle[2] = trigger.errorAngle[2] * 2
                trigger.flags:canFireWithPartialAmmo(true)
            end
        else
            Balltze.features.reloadTagData(tagEntry.handle)
        end
    end
    skullsManager.skulls.slayer.active = isActive
    -- logger:debug("Slayer {}", isActive and "On" or "Off")
end

-- Assassin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
---@param isActive boolean
function skullsManager.assassin(isActive)
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
    skullsManager.skulls.assassin.active = isActive
    skullsManager.skullAssassinOnTick(true)
    -- logger:debug("Assassin {}", isActive and "On" or "Off")
end

-- Assassin OnTick
local activeCammoCounter = 0
local activeCammoTimer = 150
---@param isActive boolean
function skullsManager.skullAssassinOnTick(isActive)
    player = getPlayer()
    if not player then
        return
    end
    biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    if not isActive and skullsManager.skulls.assassin.active == true then
        biped.unitFlags:powerUp(true)
        if biped.unitControlFlags:melee() or biped.unitControlFlags:grenade() and (biped.grenadeCounts[1] > 0 or biped.grenadeCounts[2] > 0) then
            biped.camoPower = 0
        end
        if biped.camoPower > 0 then
            if activeCammoCounter > 0 then
                activeCammoCounter = activeCammoCounter - 1
            else
                biped.camoPower = 0
                activeCammoCounter = activeCammoTimer
            end
        else
            activeCammoCounter = activeCammoTimer
        end
    else
        biped.unitFlags:powerUp(false)
    end
    -- Proof of concept for biped enemies camo in real time need improvement
    --for bipedIndex = 0, 4095 do
    --    local bipedObject = getObject(bipedIndex)
    --    if not bipedObject then
    --        return
    --    end
    --    if bipedObject.type == objectTypes.biped then
    --        local bipedEnemy = getObject(bipedIndex, objectTypes.biped)
    --        assert(bipedEnemy, "Failed to get biped object")
    --        local bipedEnemyTag = engine.tag.getTag(bipedObject.tagHandle.value, tagClasses.biped)
    --        assert(bipedEnemyTag, "Biped tag must exist")
    --        for _, bipedName in pairs(allUnits) do
    --            if bipedEnemyTag.path:includes(bipedName) then
    --                bipedEnemy.tagHandle.value = bipedEnemyTag.handle.value
    --                if not isActive and skullsManager.skulls.assassin.active == true then
    --                    bipedEnemy.unitFlags:powerUp(true)
    --                else
    --                    bipedEnemy.unitFlags:powerUp(false)
    --                end
    --            end
    --        end
    --    end
    --end
end

-------------------------------------------------------------------- Tables ------------------------------------------------------------------

---Skull List
skullsManager.skulls = {
    famine = {
        name = "Famine",
        type = "golden",
        func = skullsManager.famine,
        active = false
    },
    mythic = {
        name = "Mythic",
        type = "golden",
        func = skullsManager.mythic,
        active = false
    },
    blind = {
        name = "Blind",
        type = "golden",
        func = skullsManager.blind,
        active = false
    },
    catch = {
        name = "Catch",
        type = "golden",
        func = skullsManager.catch,
        active = false
    },
    berserk = {
        name = "Berserk",
        type = "silver",
        func = skullsManager.berserk,
        active = false
    },
    toughluck = {
        name = "Though Luck",
        type = "silver",
        func = skullsManager.toughluck,
        active = false
    },
    fog = {
        name = "Fog",
        type = "silver",
        func = skullsManager.fog,
        active = false
    },
    knucklehead = {
        name = "Knucklehead",
        type = "silver",
        func = skullsManager.knucklehead,
        active = false
    },
    cowbell = {
        name = "Cowbell",
        type = "silver",
        func = skullsManager.cowbell,
        active = false
    },
    havok = {
        name = "Havok",
        type = "silver",
        func = skullsManager.havok,
        active = false
    },
    newton = {
        name = "Newton",
        type = "silver",
        func = skullsManager.newton,
        active = false
    },
    tilt = {
        name = "Tilt",
        type = "silver",
        func = skullsManager.tilt,
        active = false
    },
    banger = {
        name = "Banger",
        type = "silver",
        func = skullsManager.banger,
        active = false
    },
    doubledown = {
        name = "Double Down",
        type = "silver",
        func = skullsManager.doubledown,
        active = false
    },
    eyepatch = {
        name = "Eye Patch",
        type = "silver",
        func = skullsManager.eyepatch,
        active = false
    },
    triggerswitch = {
        name = "Trigger Switch",
        type = "silver",
        func = skullsManager.triggerswitch,
        active = false
    },
    slayer = {
        name = "Slayer",
        type = "silver",
        func = skullsManager.slayer,
        active = false
    },
    assassin = {
        name = "Assassin",
        type = "silver",
        func = skullsManager.assassin,
        active = false
    }
}

-- local silverSkulls = {}
-- local goldenSkulls = {}
--
-- for _, skull in pairs(skullsManager.skulls) do
--    if skull.type == "golden" then
--        table.insert(goldenSkulls, skull)
--    elseif skull.type == "silver" then
--        table.insert(silverSkulls, skull)
--    end
-- end

local goldenSkulls = {
    skullsManager.skulls.famine,
    skullsManager.skulls.mythic,
    skullsManager.skulls.blind,
    skullsManager.skulls.catch
}

local silverSkulls = {
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


------------------------------------------------------ Functions to enable/disable skulls ------------------------------------------------------

---Activate Specified Skull by type and name
---@param skullType string | "silver" | "golden"
---@param name string | "random" | "all"
function skullsManager.enableSkull(skullType, name)
    local skullList = skullType == "silver" and silverSkulls or skullType == "golden" and goldenSkulls or nil

    -- Check if the skullList is valid and name is provided
    if not skullList or not name then
        logger:error(
            "Invalid parameters. Usage: activate_skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> ]")
        return
    end

    -- Enable all skulls of one type
    if name:lower() == "all" then
        if skullList then
            for _, skull in ipairs(skullList) do
                if not skull.active then
                    skull.func(true)
                    skull.active = true
                    logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper), skull.name)
                else
                    logger:warning("{} skull '{}' is already active.", skullType:gsub("^%l", string.upper), skull.name)
                end
            end
        end
        return
    end

    -- Enable a skull by random
    if name:lower() == "random" then
        local notActive = table.filter(skullList, function(skull)
            return not skull.active
        end)

        if #notActive == 0 then
            logger:warning("All {} skulls are already active.", skullType:gsub("^%l", string.upper))
            return
        end

        local randomSkull = notActive[math.random(#notActive)]
        randomSkull.func(true)
        randomSkull.active = true
        logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper), randomSkull.name)
        return
    end

    -- Search by specific name
    for _, skull in ipairs(skullList) do
        if name:lower() == skull.name:lower() then
            if skull.active then
                logger:warning("{} skull '{}' is already active.", skullType:gsub("^%l", string.upper), skull.name)
            else
                skull.func(true)
                skull.active = true
                logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper), skull.name)
            end
            return
        end
    end

    logger:info("{} skull '{}' not found. Available: {}", skullType:gsub("^%l", string.upper), name, table.concat(table.map(skullList, function(s)
        return s.name:lower()
    end), ", "))
end


---Deactivate specified Skull by type and name
---@param skullType string | "silver" | "golden"
---@param name string | "random" | "all" | "is_active"
function skullsManager.disableSkull(skullType, name)
    -- Select the list of skulls by type
    local skullList = skullType == "silver" and silverSkulls or skullType == "golden" and goldenSkulls or nil

    -- Check if the skullList is valid and name is provided
    if not skullList or not name then
        logger:error(
            "Invalid parameters. Usage: deactivate_skull  [ <silver> | <golden> ]  [ <name> | <random> | <all> | <is_active> ]")
        return
    end

    -- Disable all skulls of one type
    if name:lower() == "all" then
        for _, skull in ipairs(skullList) do
            if skull.active then
                skull.func(false)
                skull.active = false
                logger:info("{} skull: '{}' deactivated", skullType:gsub("^%l", string.upper), skull.name)
            else
                logger:warning("{} skull '{}' is already inactive.", skullType:gsub("^%l", string.upper), skull.name)
            end
        end
        return
    end

    -- Disable an active skull by random
    if name:lower() == "random" then
        -- Filter the skull ones that are active
        local activeSkulls = table.filter(skullList, function(skull)
            return skull.active
        end)

        -- If none skull are active, exit
        if #activeSkulls == 0 then
            logger:warning("All {} skulls are already deactivated.", skullType:gsub("^%l", string.upper))
            return
        end

        -- Choose a random active skull and deactivate it
        local randomSkull = activeSkulls[math.random(#activeSkulls)]
        randomSkull.func(false)
        randomSkull.active = false
        logger:info("{} skull: '{}' deactivated", skullType:gsub("^%l", string.upper), randomSkull.name)
        return
    end

    -- Disable only the currently activated skulls of this type
    if name:lower() == "is_active" then
        local anyDeactivated = false
        for _, skull in ipairs(skullList) do
            if skull.active then
                skull.func(false)
                skull.active = false
                logger:info("{} Skull '{}' deactivated.", skullType:gsub("^%l", string.upper), skull.name)
                anyDeactivated = true
            end
        end

        if not anyDeactivated then
            logger:warning("No {} skulls are currently activated.", skullType:gsub("^%l", string.upper))
        end
        return
    end

    -- Search by specific name
    for _, skull in ipairs(skullList) do
        if name:lower() == skull.name:lower() then
            if not skull.active then
                logger:warning("{} Skull '{}' is already inactive.", skullType:gsub("^%l", string.upper), skull.name)
            else
                skull.func(false)
                skull.active = false
                logger:info("{} Skull '{}' deactivated.", skullType:gsub("^%l", string.upper), skull.name)
            end
            return
        end
    end

    -- If the name does not match any skull, show error
    logger:info("{} Skull '{}' not found. Available: {}", skullType:gsub("^%l", string.upper), name, table.concat(table.map(skullList, function(s)
        return s.name:lower()
    end), ", "))
end

function skullsManager.spawnBaddies1()
    local scenarioTagHandle = engine.tag.getTag(0, engine.tag.classes.scenario) -- Gets the first (and only) .scenario tag from the map
    assert(scenarioTagHandle, "Failed to get scenario tag handle.") -- Assert handle is not nil (or false)
    local actorPaletteIndex0 = scenarioTagHandle.data.actorPalette.elements[0].tagHandle.value
end

function skullsManager.spawnBaddies2()
    
end

function skullsManager.spawnBaddies3()
    
end


return skullsManager