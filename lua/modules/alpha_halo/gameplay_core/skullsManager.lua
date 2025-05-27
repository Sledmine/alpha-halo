local blam = require "blam"
local engine = Engine
local balltze = Balltze
local objectTypes = Engine.tag.objectType
local tagClasses = Engine.tag.classes
local findTags = Engine.tag.findTags
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local inspect = require "inspect"
local tagEntries = require "alpha_halo.constants.tagEntries"

local skullsManager = {}

-- Variable for null handle or empty tag reference
local nullHandleValue = 0xFFFFFFFF

-- These flags indicates if a skull is On or Off.
skullsManager.skulls = {
    famine = false,
    mythic = false,
    blind = false,
    catch = false,
    berserk = false,
    toughLuck = false,
    fog = false,
    knucklehead = false,
    cowbell = false,
    havok = false,
    newton = false,
    tilt = false,
    banger = false,
    doubleDown = false,
    eyePatch = false,
    triggerSwitch = false,
    slayer = false,
    assassin = false
}

skullsManager.skullsNew = {
    famine = {
        name = "Famine",
        func = skullsManager.skullFamine,
        active = false
    },
}

local player
local biped
local blamBiped
-- This function is called each tick and it's needed for some skulls.
function skullsManager.eachTick()
    player = getPlayer()
    if not player then
        return
    end
    biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end
    blamBiped = blam.biped(get_object(player.objectHandle.value))
    assert(blamBiped, "Biped tag must exist")
    skullsManager.skullFogOnTick()
    skullsManager.skullBlindOnTick()
    skullsManager.skullAssassinOnTick()
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
---@param restore boolean
function skullsManager.skullFamine(restore)
    local famineTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(famineTagsFiltered) do
        local actorVariant = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actorVariant.dropWeaponLoaded[1] = actorVariant.dropWeaponLoaded[1] * 0.5
            actorVariant.dropWeaponLoaded[2] = actorVariant.dropWeaponLoaded[2] * 0.5
            actorVariant.dropWeaponAmmo[1] = actorVariant.dropWeaponAmmo[1] * 0.5
            actorVariant.dropWeaponAmmo[2] = actorVariant.dropWeaponAmmo[2] * 0.5
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0.01
        end
    end
    if restore == true then
        skullsManager.skulls.famine = false
        --logger:debug("Famine Off")
    else
        skullsManager.skulls.famine = true
        --logger:debug("Famine On")
    end
end

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param restore boolean
function skullsManager.skullMythic(restore)
    local mythicTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(mythicTagsFiltered) do
        local actorVariant = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actorVariant.bodyVitality = actorVariant.bodyVitality * 2
            actorVariant.shieldVitality = actorVariant.shieldVitality * 2
        end
    end
    local playerCollisionTagEntry = findTags("spartan_mp", tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * 1.5
            collisionGeometry.maximumBodyVitality = collisionGeometry.maximumBodyVitality * 1.5
        end
    end
    if restore == true then
        skullsManager.skulls.mythic = false
        --logger:debug("Mythic Off")
    else
        skullsManager.skulls.mythic = true
        --logger:debug("Mythic On")
    end
end

-- Blind: Hides HUD and duplicates AI burst origin radius.
local blindOnTick
---@param restore boolean
function skullsManager.skullBlind(restore)
    local blindTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(blindTagsFiltered) do
        local actorVariant = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actorVariant.burstOriginRadius = actorVariant.burstOriginRadius * 2
        end
    end
    if restore == true then
        skullsManager.skulls.blind = false
        --logger:debug("Blind Off")
    else
        skullsManager.skulls.blind = true
        blindOnTick = true -- This is needed to turn off OnTick function one tick after the skull.
        --logger:debug("Blind On")
    end
end

-- Blind OnTick
function skullsManager.skullBlindOnTick()
    if blindOnTick == true then
        if skullsManager.skulls.blind == true then
            execute_script("show_hud 0")
        else
            execute_script("show_hud 1")
            blindOnTick = false
        end
    end
end

-- Catch: Makes the AI launch grenades a fuck lot.
function skullsManager.skullCatch(restore)
    local catchTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(catchTagsFiltered) do
        local actorVariant = tagEntry.data
        if restore then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            --actorVariant.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus(2) -- This doesn't work.
            actorVariant.flags:hasUnlimitedGrenades(true)
            actorVariant.grenadeChance = actorVariant.grenadeChance + 1
            actorVariant.grenadeCheckTime = actorVariant.grenadeCheckTime * 0.1
            actorVariant.encounterGrenadeTimeout = actorVariant.encounterGrenadeTimeout * 0.01
            actorVariant.dontDropGrenadesChance = actorVariant.dontDropGrenadesChance * 0.1
        end
    end
    if restore == true then
        skullsManager.skulls.catcg = false
        -- logger:debug("Catch Off")
    else
        skullsManager.skulls.catch = true
        -- logger:debug("Catch On")
    end
end

-------------------------------------------------------------- Silver Skulls ----------------------------------------------------------------------------

---Berserk: Makes the AI enter in constant Berserk state.
---@param restore boolean
function skullsManager.skullBerserk(restore)
    local berserkUnits = {
        "flood",
        "elite",
        "hunter",
        "odst"
    }
    local berserkActorsFiltered = table.filter(tagEntries.actor(), function(tagEntry)
        for _, keyword in pairs(berserkUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(berserkActorsFiltered) do
        local actor = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
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
        end
    end
    if restore == true then
        skullsManager.skulls.berserk = false
        -- logger:debug("Berserk Off")
    else
        skullsManager.skulls.berserk = true
        -- logger:debug("Berserk On")
    end
end

---Tough Luck: Makes AI react to everything and enhances their senses.
---@param restore boolean
function skullsManager.skullToughLuck(restore)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actor.noticeProjectileChance = actor.noticeProjectileChance + 1
            actor.noticeVehicleChance = actor.noticeVehicleChance + 1
            actor.diveFromGrenadeChance = actor.diveFromGrenadeChance + 1
            actor.diveIntoCoverChance = actor.diveIntoCoverChance + 1
            actor.peripheralDistance = actor.peripheralDistance * 3
            actor.peripheralVisionAngle = actor.peripheralVisionAngle * 3
            actor.combatPerceptionTime = actor.combatPerceptionTime * 0.25
        end
    end
    if restore == true then
        skullsManager.skulls.toughLuck = false
        -- logger:debug("Tough Luck Off")
    else
        skullsManager.skulls.toughLuck = true
        -- logger:debug("Tough Luck On")
    end
end

local fogOnTick
---Fog: Turns off motion tracker & aguments AI surprise distance.
---@param restore boolean
function skullsManager.skullFog(restore)
    for _, tagEntry in ipairs(tagEntries.actor()) do
        local actor = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actor.surpriseDistance = actor.surpriseDistance + 10
        end
    end
    if restore == true then
        skullsManager.skulls.fog = false
        -- logger:debug("Fog Off")
    else
        skullsManager.skulls.fog = true
        fogOnTick = true -- This is needed to turn off OnTick function one tick after the skull.
        -- logger:debug("Fog On")
    end
end

-- Fog OnTick
function skullsManager.skullFogOnTick()
    if fogOnTick == true then
        if skullsManager.skulls.fog == true then
            execute_script("hud_show_motion_sensor 0")
        else
            execute_script("hud_show_motion_sensor 1")
            fogOnTick = false
        end
    end
end

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param restore boolean
function skullsManager.skullKnucklehead(restore)
    local knuckleheadTagsFiltered = table.filter(tagEntries.modelCollisionGeometry(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
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
            if restore == true then
                Balltze.features.reloadTagData(tagEntry.handle)
            else
                if material.flags:head() then
                    shield = shield * 25
                    body = body * 25
                end
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    for _, tagEntry in ipairs(tagEntries.impactDamageEffect()) do
        local damageEffectModifier = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            damageEffectModifier.grunt = damageEffectModifier.grunt * 0.2
            damageEffectModifier.jackal = damageEffectModifier.jackal * 0.2
            damageEffectModifier.elite = damageEffectModifier.elite * 0.2
            damageEffectModifier.eliteEnergyShield = damageEffectModifier.eliteEnergyShield * 0.2
            damageEffectModifier.floodCarrierForm = damageEffectModifier.floodCarrierForm * 0.2
            damageEffectModifier.floodCombatForm = damageEffectModifier.floodCombatForm * 0.2
            damageEffectModifier.hunterSkin = damageEffectModifier.hunterSkin * 2
        end
    end
    if restore == true then
        skullsManager.skulls.knucklehead = false
        -- logger:debug("Knucklehead Off")
    else
        skullsManager.skulls.knucklehead = true
        -- logger:debug("Knucklehead On")
    end
end

---Cowbell: Doubles bipeds & vehicles accelerationScale.
---@param restore boolean
function skullsManager.skullCowbell(restore)
    for _, tagEntry in ipairs(tagEntries.biped()) do
        local bipedTag = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            bipedTag.accelerationScale = bipedTag.accelerationScale * 2
        end
    end
    for _, tagEntry in ipairs(tagEntries.vehicle()) do
        local vehicle = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            vehicle.accelerationScale = vehicle.accelerationScale * 2
        end
    end
    if restore == true then
        skullsManager.skulls.cowbell = false
        -- logger:debug("Cowbell Off")
    else
        skullsManager.skulls.cowbell = true
        -- logger:debug("Cowbell On")
    end
end

---Havok: Doubles all damage_effect's damage radius, and it scales properly.
---@param restore boolean
function skullsManager.skullHavok(restore)
    for _, tagEntry in ipairs(tagEntries.explosionDamageEffect()) do
        local damageEffect = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            damageEffect.radius[2] = damageEffect.radius[2] * 1.5
            damageEffect.damageLowerBound = damageEffect.damageLowerBound * 0.5
        end
    end
    if restore == true then
        skullsManager.skulls.havok = false
        -- logger:debug("Havok Off")
    else
        skullsManager.skulls.havok = true
        -- logger:debug("Havok On")
    end
end

---Newton: Augments instant acceleration for melee damages.
---@param restore boolean
function skullsManager.skullNewton(restore)
    for _, tagEntry in ipairs(tagEntries.meleeDamageEffect()) do
        local damageEffect = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            damageEffect.damageInstantaneousAcceleration.i = damageEffect.damageInstantaneousAcceleration.i + 5
            if tagEntry.path:includes("response") then
                damageEffect.damageUpperBound[2] = damageEffect.damageUpperBound[2] + 1
            end
        end
    end
    if restore == true then
        skullsManager.skulls.newton = false
        -- logger:debug("Newton Off")
    else
        skullsManager.skulls.newton = true
        -- logger:debug("Newton On")
    end
end

---Tilt: Doubles strenghts and weakenesses.
---@param restore boolean
function skullsManager.skullTilt(restore)
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
            if restore == true then
                Balltze.features.reloadTagData(tagEntry.handle)
            else
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
            end
        end
    end
    for _, tagEntry in ipairs(kineticDamageEffect) do
        if not tagEntry.path:includes("melee") then
            local damageEffectModifier = tagEntry.data
            if restore == true then
                Balltze.features.reloadTagData(tagEntry.handle)
            else
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
            end
        end
    end
    if restore == true then
        skullsManager.skulls.tilt = false
        -- logger:debug("Tilt Off")
    else
        skullsManager.skulls.tilt = true
        -- logger:debug("Tilt On")
    end
end

---Banger: Makes Grunts and Human Floods explode after dying.
---@param restore boolean
function skullsManager.skullBanger(restore)
    local plasmaExplosion = findTags("weapons\\plasma grenade\\effects\\explosion", tagClasses.effect)[1]
    local floodExplosion = findTags("characters\\floodcarrier\\effects\\body destroyed", tagClasses.effect)[1]
    for _, tagEntry in ipairs(tagEntries.modelCollisionGeometry()) do
        if tagEntry.path:includes("grunt") then
            local collisionGeometry = tagEntry.data
            if restore == true then
                Balltze.features.reloadTagData(tagEntry.handle)
            else
                collisionGeometry.bodyDamagedThreshold = collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            end
        elseif tagEntry.path:includes("floodcombat_human") then
            local collisionGeometry = tagEntry.data
            if restore == true then
                Balltze.features.reloadTagData(tagEntry.handle)
            else
                collisionGeometry.bodyDamagedThreshold = collisionGeometry.bodyDamagedThreshold + 0.1
                collisionGeometry.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
            end
        end
    end
    if restore == true then
        skullsManager.skulls.banger = false
        -- logger:debug("Banger Off")
    else
        skullsManager.skulls.banger = true
        -- logger:debug("Banger On")
    end
end

-- Double Down: Duplicates player's shields, but also it's recharging time.
---@param restore boolean
function skullsManager.skullDoubleDown(restore)
    local playerCollisionTagEntry = findTags("gdd\\characters\\spartan_mp\\spartan_mp", tagClasses
        .modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        local collisionGeometry = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            collisionGeometry.maximumShieldVitality = collisionGeometry.maximumShieldVitality * 2
            collisionGeometry.stunTime = collisionGeometry.stunTime * 2
            collisionGeometry.rechargeTime = collisionGeometry.rechargeTime * 2
        end
    end
    if restore == true then
        skullsManager.skulls.doubleDown = false
        -- logger:debug("Double Down Off")
    else
        skullsManager.skulls.doubleDown = true
        -- logger:debug("Double Down On")
    end
end

-- Eye Patch: Eliminates weapons assistances & initial error.
---@param restore boolean
function skullsManager.skullEyePatch(restore)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        local weapon = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            weapon.autoaimAngle = weapon.autoaimAngle * 0.01
            weapon.autoaimRange = weapon.autoaimRange * 0.01
            weapon.magnetismAngle = weapon.magnetismAngle * 0.01
            weapon.magnetismRange = weapon.magnetismRange * 0.01
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 0.01
            end
        end
    end
    if restore == true then
        skullsManager.skulls.eyePatch = false
        -- logger:debug("Eye Patch Off")
    else
        skullsManager.skulls.eyePatch = true
        -- logger:debug("Eye Patch On")
    end
end

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param restore boolean
function skullsManager.skullTriggerSwitch(restore)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                if trigger.flags:doesNotRepeatAutomatically() == false then
                    trigger.flags:doesNotRepeatAutomatically(true)
                else
                    trigger.flags:doesNotRepeatAutomatically(false)
                end
            end
        end
    end
    if restore == true then
        skullsManager.skulls.triggerSwitch = false
        -- logger:debug("Trigger Switch Off")
    else
        skullsManager.skulls.triggerSwitch = true
        -- logger:debug("Trigger Switch On")
    end
end

-- Slayer: Weapons shoot doble rounds and waste double ammo.
---@param restore boolean
function skullsManager.skullSlayer(restore)
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.roundsPerShot = trigger.roundsPerShot * 2
                trigger.projectilesPerShot = trigger.projectilesPerShot * 2
                trigger.errorAngle[1] = trigger.errorAngle[1] * 2
                trigger.errorAngle[2] = trigger.errorAngle[2] * 2
            end
        end
    end
    if restore then
        skullsManager.skulls.slayer = false
        -- logger:debug("Slayer Off")
    else
        skullsManager.skulls.slayer = true
        -- logger:debug("Slayer On")
    end
end

local assassinOnTick
-- Assassin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
---@param restore boolean
function skullsManager.skullAssassin(restore)
    local assassinTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                if tagEntry.data.flags:activeCamouflage() == false then
                    return true
                end
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(assassinTagsFiltered) do
        local actorVariant = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actorVariant.flags:activeCamouflage(true)
        end
    end
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        local actorVariant = tagEntry.data
        if restore == true then
            Balltze.features.reloadTagData(tagEntry.handle)
        else
            actorVariant.activeCamoDing = actorVariant.activeCamoDing * 2
            actorVariant.activeCamoRegrowthRate = actorVariant.activeCamoRegrowthRate * 0.5
        end
    end
    if restore == true then
        skullsManager.skulls.assassin = false
        -- logger:debug("Assassin Off")
    else
        skullsManager.skulls.assassin = true
        assassinOnTick = true -- This is needed to turn off OnTick function one tick after the skull.
        -- logger:debug("Assassin On")
    end
end

-- Assassin OnTick
function skullsManager.skullAssassinOnTick()
    if assassinOnTick == true then
        if skullsManager.skulls.assassin == true then
            blamBiped.isCamoActive = true
            if blamBiped.meleeKey or blamBiped.grenadeHold then
                blamBiped.camoScale = 0
            end
        else
            blamBiped.isCamoActive = false
            assassinOnTick = false -- This makes so this function turns off one tick after Assassin gets turned off.
        end
    end
end

-- We should not be using this lol
local silverSkullList = {
    {
        name = "Berserk",
        func = skullsManager.skullBerserk
    },
    {
        name = "Tough Luck",
        func = skullsManager.skullToughLuck
    },
    {
        name = "Fog",
        func = skullsManager.skullFog
    },
    {
        name = "Knucklehead",
        func = skullsManager.skullKnucklehead
    },
    {
        name = "Cowbell",
        func = skullsManager.skullCowbell
    },
    {
        name = "Havok",
        func = skullsManager.skullHavok
    },
    {
        name = "Newton",
        func = skullsManager.skullNewton
    },
    {
        name = "Tilt",
        func = skullsManager.skullTilt
    },
    {
        name = "Banger",
        func = skullsManager.skullBanger
    },
    {
        name = "Double Down",
        func = skullsManager.skullDoubleDown
    },
    {
        name = "Eye Patch",
        func = skullsManager.skullEyePatch
    },
    {
        name = "Trigger Switch",
        func = skullsManager.skullTriggerSwitch
    },
    {
        name = "Slayer",
        func = skullsManager.skullSlayer
    },
    {
        name = "Assassin",
        func = skullsManager.skullAssassin
    }
}

---Activate specified skull
---@param desiredSkullName string | "random"
function skullsManager.activateSilverSkull(desiredSkullName)
    if desiredSkullName and desiredSkullName:lower() == "random" then
        -- Empty table for skulls that are not activated yet
        local availableSkulls = table.filter(table.keys(skullsManager.skulls), function(skullName)
            local searchableSkullName = skullName:lower():replace(" ", "")
            local isSilverSkull = table.find(silverSkullList, function(skull)
                return skull.name:lower():replace(" ", "") == searchableSkullName
            end) ~= nil
            local isActive = skullsManager.skulls[skullName]
            return not isActive and isSilverSkull
        end)

        -- If no skulls are available for activate, stop the execution
        if #availableSkulls == 0 then
            logger:debug("All silver skulls are activated.")
            return
        end

        -- Selects a random available skull from table and activate it
        local selectedSkullName = availableSkulls[math.random(1, #availableSkulls)]:lower():replace(" ", "")
        logger:debug("Selected random skull name {}", selectedSkullName)

        local selectedSkull = table.find(silverSkullList, function(skull)
            return skull.name:lower():replace(" ", "") == selectedSkullName
        end)
        assert(selectedSkull)
        selectedSkull.func(false) -- Activates the skull

        logger:debug("Silver Skull On: {}", selectedSkull.name)
        return
    end

    for _, skull in ipairs(silverSkullList) do
        if skull.name:lower():replace(" ", "") == desiredSkullName then
            skull.func(false)
            logger:debug("Silver Skull '{}' activated.", desiredSkullName)
            return
        end
    end
    logger:debug("Skull '{}' not found in the list.", desiredSkullName)
end

function skullsManager.deactivateSilverSkulls()
    local anyDeactivated = false

    for _, skull in ipairs(silverSkullList) do
        if skull.active == true then
            skull.func(true) -- Call to disable skull with restore = true
            logger:debug("Silver Skull Off: {}", skull.name)
            anyDeactivated = true
        end
    end

    if not anyDeactivated then
        logger:debug("No silver skulls activated to deactivate.")
    end
end

local goldenSkullList = {
    {
        name = "Famine",
        active = skullsManager.skulls.famine, -- true
        func = skullsManager.skullFamine
    },
    {
        name = "Mythic",
        active = skullsManager.skulls.mythic, -- false
        func = skullsManager.skullMythic
    },
    {
        name = "Blind",
        active = skullsManager.skulls.blind,
        func = skullsManager.skullBlind
    },
    { -- This one might cause problems.
        name = "Catch",
        active = skullsManager.skulls.catch,
        func = skullsManager.skullCatch
    },
}

------------------------------------------

function skullsManager.goldenSkulls()
    -- Empty table for skulls that are not activated yet
    local availableSkulls = {}

    for _, skull in ipairs(goldenSkullList) do
        if skull.active == false then
            table.insert(availableSkulls, skull)
        end
    end

    -- If no skulls are available for activate, stop the execution
    if #availableSkulls == 0 then
        logger:debug("All golden skulls are activated.")
        return
    end

    -- Selects a random available skull from table and activates it
    local selectedIndex = math.random(1, #availableSkulls)

    ---@class skullTable
    local selectedSkull = availableSkulls[selectedIndex]

    selectedSkull.func(false) -- Activates the skull
    logger:debug("Golden Skull On: {}", selectedSkull.name)
end

function skullsManager.resetGoldenSkulls()
    local anyDeactivated = false

    for _, skull in ipairs(goldenSkullList) do
        if skull.active == true then
            skull.func(true) -- Call to disable skull with restore = true
            logger:debug("Golden Skull Off: {}", skull.name)
            anyDeactivated = true
        end
    end

    if not anyDeactivated then
        logger:debug("No golden skulls activated to deactivate.")
    end
end

return skullsManager
