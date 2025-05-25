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
local nullHandle = 0xFFFFFFFF

-- These flags indicates if a skull is On or Off.
skullsManager.skulls = {
    famine = false,
    mythic = false,
    blind = false,
    --catch = false,
    berserk = false,
    toughLuck = false,
    fog = false,
    knucklehead = false,
    cowbell = false,
    havok = false,
    newton = false,
    --tilt = false,
    banger = false,
    doubleDown = false,
    eyePatch = false,
    triggerSwitch = false,
    slayer = false,
    assassin = false
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
        if restore == true then
            tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] * 2
            tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] * 2
            tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] * 2
            tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] * 2
            tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance * 100
        else
            tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] * 0.5
            tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] * 0.5
            tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] * 0.5
            tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] * 0.5
            tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance * 0.01
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
        if restore == true then
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 0.5
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 0.5
        else
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 2
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 2
        end
    end
    local playerCollisionTagEntry = findTags("spartan_mp", tagClasses.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        if restore == true then
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality / 1.5
            tagEntry.data.maximumBodyVitality = tagEntry.data.maximumBodyVitality / 1.5
        else
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 1.5
            tagEntry.data.maximumBodyVitality = tagEntry.data.maximumBodyVitality * 1.5
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
    if restore == true then
        for _, tagEntry in ipairs(blindTagsFiltered) do
            tagEntry.data.burstOriginRadius = tagEntry.data.burstOriginRadius * 0.5
        end
        skullsManager.skulls.blind = false
    else
        for _, tagEntry in ipairs(blindTagsFiltered) do
            tagEntry.data.burstOriginRadius = tagEntry.data.burstOriginRadius * 2
        end
        skullsManager.skulls.blind = true
        blindOnTick = true
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

---- Catch: Makes the AI launch grenades a fuck lot. CURRENTLY NOT WORKING.
-- function skullsManager.skullCatch(restore)
--    if skullsManager.skulls.catch then
--        for index, tagEntry in ipairs(tagEntries.actorVariant()) do
--            if restore then
--                tagEntry.data.flags:hasUnlimitedGrenades(false)
--                tagEntry.data.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.get(1) -- This doesn't work.
--                tagEntry.data.grenadeChance = tagEntry.data.grenadeChance - 1
--                tagEntry.data.grenadeCheckTime = tagEntry.data.grenadeCheckTime * 10
--                tagEntry.data.encounterGrenadeTimeout = tagEntry.data.encounterGrenadeTimeout * 100
--                tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance * 10
--            else
--                tagEntry.data.flags:hasUnlimitedGrenades(true)
--                tagEntry.data.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.get(2) -- This doesn't work.
--                tagEntry.data.grenadeChance = tagEntry.data.grenadeChance + 1
--                tagEntry.data.grenadeCheckTime = tagEntry.data.grenadeCheckTime * 0.1
--                tagEntry.data.encounterGrenadeTimeout = tagEntry.data.encounterGrenadeTimeout * 0.01
--                tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance * 0.1
--            end
--        end
--        logger:debug("Catch On")
--    end
-- end

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
        if restore == true then
            tagEntry.data.meleeAttackDelay = tagEntry.data.meleeAttackDelay * 100
            tagEntry.data.meleeChargeTime = tagEntry.data.meleeChargeTime - 100
            tagEntry.data.meleeLeapRange[1] = tagEntry.data.meleeLeapRange[1] - 1.5
            tagEntry.data.meleeLeapRange[2] = tagEntry.data.meleeLeapRange[2] - 10
            tagEntry.data.meleeLeapVelocity = tagEntry.data.meleeLeapVelocity - 0.5
            tagEntry.data.meleeLeapChance = tagEntry.data.meleeLeapChance - 1
            tagEntry.data.meleeLeapBallistic = tagEntry.data.meleeLeapBallistic - 0.5
            tagEntry.data.berserkProximity = tagEntry.data.berserkProximity - 50
            tagEntry.data.berserkGrenadeChance = tagEntry.data.berserkGrenadeChance - 1
            tagEntry.data.moreFlags:pathfindingIgnoresDanger(false)
        else
            tagEntry.data.meleeAttackDelay = tagEntry.data.meleeAttackDelay * 0.01
            tagEntry.data.meleeChargeTime = tagEntry.data.meleeChargeTime + 100
            tagEntry.data.meleeLeapRange[1] = tagEntry.data.meleeLeapRange[1] + 1.5
            tagEntry.data.meleeLeapRange[2] = tagEntry.data.meleeLeapRange[2] + 10
            tagEntry.data.meleeLeapVelocity = tagEntry.data.meleeLeapVelocity + 0.5
            tagEntry.data.meleeLeapChance = tagEntry.data.meleeLeapChance + 1
            tagEntry.data.meleeLeapBallistic = tagEntry.data.meleeLeapBallistic + 0.5
            tagEntry.data.berserkProximity = tagEntry.data.berserkProximity + 50
            tagEntry.data.berserkGrenadeChance = tagEntry.data.berserkGrenadeChance + 1
            tagEntry.data.moreFlags:pathfindingIgnoresDanger(true)
        end
    end
-- This down here will fail, bc when we call this as Restore, it will take all tags with this flag off,
-- thus making the filter useless. We have to make a table that doesn't change when Restore is called.
    --local pathfindingFlagFiltered = table.filter(berserkActorsFiltered, function(tagEntry)
    --    if tagEntry.data.moreFlags:pathfindingIgnoresDanger() == false then
    --        return true
    --    end
    --    return false
    --end)
    --for _, tagEntry in ipairs(pathfindingFlagFiltered) do
    --    if restore == true then
    --        tagEntry.data.moreFlags:pathfindingIgnoresDanger(false)
    --    else
    --        tagEntry.data.moreFlags:pathfindingIgnoresDanger(true)
    --    end
    --end
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
        if restore then
            tagEntry.data.noticeProjectileChance = tagEntry.data.noticeProjectileChance - 1
            tagEntry.data.noticeVehicleChance = tagEntry.data.noticeVehicleChance - 1
            tagEntry.data.diveFromGrenadeChance = tagEntry.data.diveFromGrenadeChance - 1
            tagEntry.data.diveIntoCoverChance = tagEntry.data.diveIntoCoverChance - 1
            tagEntry.data.combatPerceptionTime = tagEntry.data.combatPerceptionTime * 4
        else
            tagEntry.data.noticeProjectileChance = tagEntry.data.noticeProjectileChance + 1
            tagEntry.data.noticeVehicleChance = tagEntry.data.noticeVehicleChance + 1
            tagEntry.data.diveFromGrenadeChance = tagEntry.data.diveFromGrenadeChance + 1
            tagEntry.data.diveIntoCoverChance = tagEntry.data.diveIntoCoverChance + 1
            tagEntry.data.peripheralDistance = tagEntry.data.peripheralDistance * 3
            tagEntry.data.peripheralVisionAngle = tagEntry.data.peripheralVisionAngle * 3
            tagEntry.data.combatPerceptionTime = tagEntry.data.combatPerceptionTime * 0.25
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
        if restore then
            tagEntry.data.surpriseDistance = tagEntry.data.surpriseDistance - 10
        else
            tagEntry.data.surpriseDistance = tagEntry.data.surpriseDistance + 10
        end
    end
        if restore == true then
        skullsManager.skulls.fog = false
        -- logger:debug("Fog Off")
    else
        skullsManager.skulls.fog = true
        fogOnTick = true
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
                if material.flags:head() then
                    shield = shield * 0.02
                    body = body * 0.02
                end
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
        if restore == true then
            tagEntry.data.grunt = tagEntry.data.grunt * 5
            tagEntry.data.jackal = tagEntry.data.jackal * 5
            tagEntry.data.elite = tagEntry.data.elite * 5
            tagEntry.data.eliteEnergyShield = tagEntry.data.eliteEnergyShield * 5
            tagEntry.data.floodCarrierForm = tagEntry.data.floodCarrierForm * 5
            tagEntry.data.floodCombatForm = tagEntry.data.floodCombatForm * 5
            tagEntry.data.hunterSkin = tagEntry.data.hunterSkin * 0.5
        else
            tagEntry.data.grunt = tagEntry.data.grunt * 0.2
            tagEntry.data.jackal = tagEntry.data.jackal * 0.2
            tagEntry.data.elite = tagEntry.data.elite * 0.2
            tagEntry.data.eliteEnergyShield = tagEntry.data.eliteEnergyShield * 0.2
            tagEntry.data.floodCarrierForm = tagEntry.data.floodCarrierForm * 0.2
            tagEntry.data.floodCombatForm = tagEntry.data.floodCombatForm * 0.2
            tagEntry.data.hunterSkin = tagEntry.data.hunterSkin * 2
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
        if restore then
            tagEntry.data.accelerationScale = tagEntry.data.accelerationScale * 0.5
        else
            tagEntry.data.accelerationScale = tagEntry.data.accelerationScale * 2
        end
    end
    for _, tagEntry in ipairs(tagEntries.vehicle()) do
        if restore then
            tagEntry.data.accelerationScale = tagEntry.data.accelerationScale * 0.5
        else
            tagEntry.data.accelerationScale = tagEntry.data.accelerationScale * 2
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
        if restore then
            tagEntry.data.radius[2] = tagEntry.data.radius[2] / 1.5
            tagEntry.data.damageLowerBound = tagEntry.data.damageLowerBound * 2
        else
            tagEntry.data.radius[2] = tagEntry.data.radius[2] * 1.5
            tagEntry.data.damageLowerBound = tagEntry.data.damageLowerBound * 0.5
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
        if restore then
            tagEntry.data.damageInstantaneousAcceleration.i = tagEntry.data.damageInstantaneousAcceleration.i - 5
            if tagEntry.path:includes("response") then
                tagEntry.data.damageUpperBound[2] = tagEntry.data.damageUpperBound[2] - 1
            end
        else
            tagEntry.data.damageInstantaneousAcceleration.i = tagEntry.data.damageInstantaneousAcceleration.i + 5
            if tagEntry.path:includes("response") then
                tagEntry.data.damageUpperBound[2] = tagEntry.data.damageUpperBound[2] + 1
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
        "energy_sword",
        "fuel_rod",
        "plasma_cannon",
        "plasma_pistol",
        "plasma_rifle",
        "ghost",
        "wraith",
        "banshee",
        "spirit",
        "shade",
        "hunter"
    }
    local kineticWeapons = {
        "assault_rifle",
        "battle_rifle",
        "frag_grenade",
        "needler",
        "pistol",
        "rocket_launcher",
        "shotgun",
        "smg",
        "sniper_gauss",
        "sniper_rifle",
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
    end)
    for _, tagEntry in ipairs(energyDamageEffect) do
        local d = tagEntry.data
        if restore == true then
            d.metalHollow = d. metalHollow * 2
            d.metalThick = d. metalThick * 2
            d.metalThin = d. metalThin * 2
            d.forceField = d.forceField * 0.5
            d.grunt = d.grunt * 2
            d.hunterArmor = d.hunterArmor * 2
            d.hunterSkin = d.hunterSkin * 2
            d.elite = d.elite * 2
            d.eliteEnergyShield = d.eliteEnergyShield * 0.5
            d.jackal = d.jackal * 2
            d.jackalEnergyShield = d.jackalEnergyShield * 0.5
            d.engineerSkin = d.engineerSkin * 2
            d.engineerForceField = d.engineerForceField * 0.5
            d.floodCombatForm = d.floodCombatForm * 2
            d.floodCarrierForm = d.floodCarrierForm * 2
            d.cyborgArmor = d.cyborgArmor * 2
            d.cyborgEnergyShield = d.cyborgEnergyShield * 0.5
            d.humanArmor = d.humanArmor * 2
            d.humanSkin = d.humanSkin * 2
            d.sentinel = d.sentinel * 0.5
            d.monitor = d.monitor * 0.5
        else
            d.metalHollow = d. metalHollow * 0.5
            d.metalThick = d. metalThick * 0.5
            d.metalThin = d. metalThin * 0.5
            d.forceField = d.forceField * 2
            d.grunt = d.grunt * 0.5
            d.hunterArmor = d.hunterArmor * 0.5
            d.hunterSkin = d.hunterSkin * 0.5
            d.elite = d.elite * 0.5
            d.eliteEnergyShield = d.eliteEnergyShield * 2
            d.jackal = d.jackal * 0.5
            d.jackalEnergyShield = d.jackalEnergyShield * 2
            d.engineerSkin = d.engineerSkin * 0.5
            d.engineerForceField = d.engineerForceField * 2
            d.floodCombatForm = d.floodCombatForm * 0.5
            d.floodCarrierForm = d.floodCarrierForm * 0.5
            d.cyborgArmor = d.cyborgArmor * 0.5
            d.cyborgEnergyShield = d.cyborgEnergyShield * 2
            d.humanArmor = d.humanArmor * 0.5
            d.humanSkin = d.humanSkin * 0.5
            d.sentinel = d.sentinel * 2
            d.monitor = d.monitor * 2
        end
    end
    for _, tagEntry in ipairs(kineticDamageEffect) do
        local d = tagEntry.data
        if restore == true then
            d.metalHollow = d. metalHollow * 0.5
            d.metalThick = d. metalThick * 0.5
            d.metalThin = d. metalThin * 0.5
            d.forceField = d.forceField * 2
            d.grunt = d.grunt * 0.5
            d.hunterArmor = d.hunterArmor * 0.5
            d.hunterSkin = d.hunterSkin * 0.5
            d.elite = d.elite * 0.5
            d.eliteEnergyShield = d.eliteEnergyShield * 2
            d.jackal = d.jackal * 0.5
            d.jackalEnergyShield = d.jackalEnergyShield * 2
            d.engineerSkin = d.engineerSkin * 0.5
            d.engineerForceField = d.engineerForceField * 2
            d.floodCombatForm = d.floodCombatForm * 0.5
            d.floodCarrierForm = d.floodCarrierForm * 0.5
            d.cyborgArmor = d.cyborgArmor * 0.5
            d.cyborgEnergyShield = d.cyborgEnergyShield * 2
            d.humanArmor = d.humanArmor * 0.5
            d.humanSkin = d.humanSkin * 0.5
            d.sentinel = d.sentinel * 2
            d.monitor = d.monitor * 2
        else
            d.metalHollow = d. metalHollow * 2
            d.metalThick = d. metalThick * 2
            d.metalThin = d. metalThin * 2
            d.forceField = d.forceField * 0.5
            d.grunt = d.grunt * 2
            d.hunterArmor = d.hunterArmor * 2
            d.hunterSkin = d.hunterSkin * 2
            d.elite = d.elite * 2
            d.eliteEnergyShield = d.eliteEnergyShield * 0.5
            d.jackal = d.jackal * 2
            d.jackalEnergyShield = d.jackalEnergyShield * 0.5
            d.engineerSkin = d.engineerSkin * 2
            d.engineerForceField = d.engineerForceField * 0.5
            d.floodCombatForm = d.floodCombatForm * 2
            d.floodCarrierForm = d.floodCarrierForm * 2
            d.cyborgArmor = d.cyborgArmor * 2
            d.cyborgEnergyShield = d.cyborgEnergyShield * 0.5
            d.humanArmor = d.humanArmor * 2
            d.humanSkin = d.humanSkin * 2
            d.sentinel = d.sentinel * 0.5
            d.monitor = d.monitor * 0.5
            logger:debug("Cyborg multiplier: {}", d.grunt)
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
            if restore == true then
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold - 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = nullHandle
            else
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold + 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            end
        elseif tagEntry.path:includes("floodcombat_human") then
            if restore == true then
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold - 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = nullHandle
            else
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold + 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = floodExplosion.handle.value
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
    local playerCollisionTagEntry = findTags("spartan_mp", tagClasses.modelCollisionGeometry)[1]
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for _, tagEntry in ipairs(playerCollisionTagEntry) do
        if restore == true then
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 0.5
            tagEntry.data.stunTime = tagEntry.data.stunTime * 0.5
            tagEntry.data.rechargeTime = tagEntry.data.rechargeTime * 0.5
        else
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 2
            tagEntry.data.stunTime = tagEntry.data.stunTime * 2
            tagEntry.data.rechargeTime = tagEntry.data.rechargeTime * 2
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
        if restore == true then
            tagEntry.data.autoaimAngle = tagEntry.data.autoaimAngle * 100
            tagEntry.data.autoaimRange = tagEntry.data.autoaimRange * 100
            tagEntry.data.magnetismAngle = tagEntry.data.magnetismAngle * 100
            tagEntry.data.magnetismRange = tagEntry.data.magnetismRange * 100
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 100
                -- trigger.errorAngle[2] = trigger.errorAngle[2] * 2
            end
        else
            tagEntry.data.autoaimAngle = tagEntry.data.autoaimAngle * 0.01
            tagEntry.data.autoaimRange = tagEntry.data.autoaimRange * 0.01
            tagEntry.data.magnetismAngle = tagEntry.data.magnetismAngle * 0.01
            tagEntry.data.magnetismRange = tagEntry.data.magnetismRange * 0.01
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 0.01
                -- trigger.errorAngle[2] = trigger.errorAngle[2] * 0.5
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
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                if trigger.flags:doesNotRepeatAutomatically() == false then
                    trigger.flags:doesNotRepeatAutomatically(true)
                else
                    trigger.flags:doesNotRepeatAutomatically(false)
                end
            end
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
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.roundsPerShot = trigger.roundsPerShot * 0.5
                trigger.projectilesPerShot = trigger.projectilesPerShot * 0.5
                trigger.errorAngle[1] = trigger.errorAngle[1] * 0.5
                trigger.errorAngle[2] = trigger.errorAngle[2] * 0.5
            end
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
                if not tagEntry.path:includes("stealth") then
                    return true
                end
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(assassinTagsFiltered) do
        if restore == true then
            tagEntry.data.flags:activeCamouflage(false)
        else
            tagEntry.data.flags:activeCamouflage(true)
        end
    end
    for _, tagEntry in ipairs(tagEntries.weapon()) do
        if restore == true then
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 0.5
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 2
        else
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 2
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 0.5
        end
    end
    if restore == true then
        skullsManager.skulls.assassin = false
        -- logger:debug("Assassin Off")
    else
        skullsManager.skulls.assassin = true
        assassinOnTick = true -- This is needed to turn off skullAssassinOnTick
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

function skullsManager.silverSkulls()
    local skullList = {
        --{
        --    name = "Berserk",
        --    active = skullsManager.skulls.berserk,
        --    func = skullsManager.skullBerserk
        --},
        --{
        --    name = "Tough Luck",
        --    active = skullsManager.skulls.toughLuck,
        --    func = skullsManager.skullToughLuck
        --},
        --{
        --    name = "Fog",
        --    active = skullsManager.skulls.fog,
        --    func = skullsManager.skullFog
        --},
        --{
        --    name = "Knucklehead",
        --    active = skullsManager.skulls.knucklehead,
        --    func = skullsManager.skullKnucklehead
        --},
        --{
        --    name = "Cowbell",
        --    active = skullsManager.skulls.cowbell,
        --    func = skullsManager.skullCowbell
        --},
        --{
        --    name = "Havok",
        --    active = skullsManager.skulls.havok,
        --    func = skullsManager.skullHavok
        --},
        --{
        --    name = "Newton",
        --    active = skullsManager.skulls.newton,
        --    func = skullsManager.skullNewton
        --},
        {
            name = "Tilt",
            active = skullsManager.skulls.tilt,
            func = skullsManager.skullTilt
        },
        --{
        --    name = "Banger",
        --    active = skullsManager.skulls.banger,
        --    func = skullsManager.skullBanger
        --},
        --{
        --    name = "Double Down",
        --    active = skullsManager.skulls.doubleDown,
        --    func = skullsManager.skullDoubleDown
        --},
        --{
        --    name = "Eye Patch",
        --    active = skullsManager.skulls.eyePatch,
        --    func = skullsManager.skullEyePatch
        --},
        --{
        --    name = "Trigger Switch",
        --    active = skullsManager.skulls.triggerSwitch,
        --    func = skullsManager.skullTriggerSwitch
        --},
        --{
        --    name = "Slayer",
        --    active = skullsManager.skulls.slayer,
        --    func = skullsManager.skullSlayer
        --},
        --{
        --    name = "Assassin",
        --    active = skullsManager.skulls.assassin,
        --    func = skullsManager.skullAssassin
        --}
        -- You can add more skulls if you want
    }

    -- Empty table for skulls that are not activated yet
    local availableSkulls = {}

    for _, skull in ipairs(skullList) do
        if skull.active == false then
            table.insert(availableSkulls, skull)
        end
    end

    -- If no skulls are available for activate, stop the execution
    if #availableSkulls == 0 then
        logger:debug("All silver skulls are activated.")
        return
    end

    -- Selects a random available skull from table and activates it
    local selectedIndex = math.random(1, #availableSkulls)

    ---@class skullTable
    ---@field name string
    ---@field active boolean
    ---@field func boolean restore
    local selectedSkull = availableSkulls[selectedIndex]

    selectedSkull.func(false) -- Activates the skull
    logger:debug("Silver Skull On: {}", selectedSkull.name)
end

function skullsManager.resetSilverSkulls()
    local skullList = {
        {
            name = "Berserk",
            active = skullsManager.skulls.berserk,
            func = skullsManager.skullBerserk
        },
        {
            name = "Tough Luck",
            active = skullsManager.skulls.toughLuck,
            func = skullsManager.skullToughLuck
        },
        {
            name = "Fog",
            active = skullsManager.skulls.fog,
            func = skullsManager.skullFog
        },
        {
            name = "Knucklehead",
            active = skullsManager.skulls.knucklehead,
            func = skullsManager.skullKnucklehead
        },
        {
            name = "Cowbell",
            active = skullsManager.skulls.cowbell,
            func = skullsManager.skullCowbell
        },
        {
            name = "Havok",
            active = skullsManager.skulls.havok,
            func = skullsManager.skullHavok
        },
        {
            name = "Newton",
            active = skullsManager.skulls.newton,
            func = skullsManager.skullNewton
        },
        {
            name = "Tilt",
            active = skullsManager.skulls.tilt,
            func = skullsManager.skullTilt
        },
        {
            name = "Banger",
            active = skullsManager.skulls.banger,
            func = skullsManager.skullBanger
        },
        {
            name = "Double Down",
            active = skullsManager.skulls.doubleDown,
            func = skullsManager.skullDoubleDown
        },
        {
            name = "Eye Patch",
            active = skullsManager.skulls.eyePatch,
            func = skullsManager.skullEyePatch
        },
        {
            name = "Trigger Switch",
            active = skullsManager.skulls.triggerSwitch,
            func = skullsManager.skullTriggerSwitch
        },
        {
            name = "Slayer",
            active = skullsManager.skulls.slayer,
            func = skullsManager.skullSlayer
        },
        {
            name = "Assassin",
            active = skullsManager.skulls.assassin,
            func = skullsManager.skullAssassin
        }
    }

    local anyDeactivated = false

    for _, skull in ipairs(skullList) do
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

function skullsManager.goldenSkulls()
    local skullList = {
        {
            name = "Famine",
            active = skullsManager.skulls.famine,
            func = skullsManager.skullFamine
        },
        {
            name = "Mythic",
            active = skullsManager.skulls.mythic,
            func = skullsManager.skullMythic
        },
        {
            name = "Blind",
            active = skullsManager.skulls.blind,
            func = skullsManager.skullBlind
        },
        --{ -- Currently not working.
        --    name = "Catch",
        --    active = skullsManager.skulls.catch,
        --    func = skullsManager.skullCatch
        --},
    }

    -- Empty table for skulls that are not activated yet
    local availableSkulls = {}

    for _, skull in ipairs(skullList) do
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
    local skullList = {
            {
            name = "Famine",
            active = skullsManager.skulls.famine,
            func = skullsManager.skullFamine
        },
            {
            name = "Mythic",
            active = skullsManager.skulls.mythic,
            func = skullsManager.skullMythic
        },
            {
            name = "Blind",
            active = skullsManager.skulls.blind,
            func = skullsManager.skullBlind
        },
        --    {
        --    name = "Catch",
        --    active = skullsManager.skulls.catch,
        --    func = skullsManager.skullCatch
        --},
    }

    local anyDeactivated = false

    for _, skull in ipairs(skullList) do
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
