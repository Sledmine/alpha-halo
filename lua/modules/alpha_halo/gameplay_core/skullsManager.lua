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
    hunger = false,
    mythic = false,
    blind = false,
    --catch = false,
    berserk = false,
    knucklehead = false,
    tilt = false,
    banger = false,
    doubleDown = false,
    eyePatch = false,
    triggerSwitch = false,
    slayer = false,
    assassin = false
}

-------------------------------------------------------------- Golden Skulls ----------------------------------------------------------------------------
local allUnits = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "odst"
}
-- Hunger: Makes the AI drop half the ammo.
---@param restore boolean
function skullsManager.skullHunger(restore)
    local hungerTagsFiltered = table.filter(tagEntries.actorVariant(), function(tagEntry)
        for _, keyword in pairs(allUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    for _, tagEntry in ipairs(hungerTagsFiltered) do
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
        skullsManager.skulls.hunger = false
        --logger:debug("Hunger Off")
    else
        skullsManager.skulls.hunger = true
        --logger:debug("Hunger On")
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
    local playerCollisionTagEntry = findTags("marine_mp", tagClasses.modelCollisionGeometry)
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

-- Blind: Hides HUD and duplicates AI error.
local OnTick
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
        skullsManager.skulls.blind = false
        --logger:debug("Blind Off")
    else
        skullsManager.skulls.blind = true
        --logger:debug("Blind On")
    end
    if restore == true then
        for _, tagEntry in ipairs(blindTagsFiltered) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 0.5
        end
    else
        for _, tagEntry in ipairs(blindTagsFiltered) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 2
        end
        OnTick = true
    end
end

-- Blind OnTick
function skullsManager.skullBlindOnTick()
    if OnTick == true then
        local player = getPlayer()
        if not player then
            return
        end
        local biped = getObject(player.objectHandle, objectTypes.biped)
        if not biped then
            return
        end
        if skullsManager.skulls.blind == true then
            execute_script("show_hud 0")
        else
            execute_script("show_hud 1")
            OnTick = false
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
    local berserkTagsFiltered = table.filter(tagEntries.actor(), function(tagEntry)
        for _, keyword in pairs(berserkUnits) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    local berserkFlagFiltered = table.filter(berserkTagsFiltered, function(tagEntry)
        if tagEntry.data.flags:alwaysChargeAtEnemies() == false then
            return true
        end
        return false
    end)
    for _, tagEntry in ipairs(berserkTagsFiltered) do
        if restore == true then
            tagEntry.data.berserkProximity = tagEntry.data.berserkProximity - 50
        else
            tagEntry.data.berserkProximity = tagEntry.data.berserkProximity + 50
        end
    end
    for _, tagEntry in ipairs(berserkFlagFiltered) do
        if restore == true then
            tagEntry.data.flags:alwaysChargeAtEnemies(false)
        else
            tagEntry.data.flags:alwaysChargeAtEnemies(true)
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
    local playerCollisionTagEntry = findTags("marine_mp", tagClasses.modelCollisionGeometry)[1]
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
        skullsManager.skulls.slayer = false
        -- logger:debug("Slayer Off")
        else
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.roundsPerShot = trigger.roundsPerShot * 2
                trigger.projectilesPerShot = trigger.projectilesPerShot * 2
                trigger.errorAngle[1] = trigger.errorAngle[1] * 2
                trigger.errorAngle[2] = trigger.errorAngle[2] * 2
            end
        skullsManager.skulls.slayer = true
        -- logger:debug("Slayer On")            
        end
    end

end

local activateOnTick
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
        activateOnTick = true -- This is needed to turn off skullAssassinOnTick
        -- logger:debug("Assassin On")
    end
end

-- Assassin OnTick
function skullsManager.skullAssassinOnTick()
    if activateOnTick == true then
        local player = getPlayer()
        if not player then
            return
        end
        local biped = getObject(player.objectHandle, objectTypes.biped)
        if not biped then
            return
        end
        local blamBiped = blam.biped(get_object(player.objectHandle.value))
        assert(blamBiped, "Biped tag must exist")
        if skullsManager.skulls.assassin == true then
            blamBiped.isCamoActive = true
            if blamBiped.meleeKey then
                blamBiped.camoScale = 0
            end
        else
            blamBiped.isCamoActive = false
            activateOnTick = false -- This makes so this function turns off one tick after Assassin gets turned off.
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
        --    name = "Knucklehead",
        --    active = skullsManager.skulls.knucklehead,
        --    func = skullsManager.skullKnucklehead
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
            name = "Knucklehead",
            active = skullsManager.skulls.knucklehead,
            func = skullsManager.skullKnucklehead
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
            name = "Hunger",
            active = skullsManager.skulls.hunger,
            func = skullsManager.skullHunger
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
            name = "Hunger",
            active = skullsManager.skulls.hunger,
            func = skullsManager.skullHunger
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
