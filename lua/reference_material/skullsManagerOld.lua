local blam = require "blam"
local engine = Engine
local balltze = Balltze
local inspect = require "inspect"
math.randomseed(os.time())

local skullsManager = {}


function skullsManager.silverSkulls()
    local skullList = {
        {
            name = "berserk",
            active = skullsManager.skulls.berserk,
            func = skullsManager.skullBerserk
        },
        {
            name = "dobledown",
            active = skullsManager.skulls.dobledown,
            func = skullsManager.skullDoubleDown
        },
        {
            name = "eyepatch",
            active = skullsManager.skulls.eyepatch,
            func = skullsManager.skullEyePatch
        },
        {
            name = "triggerswitch",
            active = skullsManager.skulls.triggerswitch,
            func = skullsManager.skullTriggerSwitch
        },
        {name = "slayer", active = skullsManager.skulls.slayer, action = skullsManager.skullSlayer},
        {name = "banger", active = skullsManager.skulls.banger, action = skullsManager.skullBanger},
        {
            name = "knuckehead",
            active = skullsManager.skulls.knuckehead,
            func = skullsManager.skullKnucklehead
        }
        -- Puedes añadir más aquí si deseas
    }

    -- Filtrar solo las calaveras que aún no están activadas
    local availableSkulls = {}

    for _, skull in ipairs(skullList) do
        if skull.active == false then
            table.insert(availableSkulls, skull)
        end
    end

    -- Si no hay calaveras disponibles, salir
    if #availableSkulls == 0 then
        logger:debug("Todas las silver skulls ya están activadas.")
        return
    end

    -- Seleccionar una al azar y activarla
    local selectedIndex = math.random(1, #availableSkulls)
    local selectedSkull = availableSkulls[selectedIndex]

    selectedSkull.func(false) -- Activa la calavera
    logger:debug("Silver Skull activada: " .. selectedSkull.name)
end

function skullsManager.resetSilverSkulls()
    local skullList = {
        {
            name = "berserk",
            active = skullsManager.skulls.berserk,
            func = skullsManager.skullBerserk
        },
        {
            name = "dobledown",
            active = skullsManager.skulls.dobledown,
            func = skullsManager.skullDoubleDown
        },
        {
            name = "eyepatch",
            active = skullsManager.skulls.eyepatch,
            func = skullsManager.skullEyePatch
        },
        {
            name = "triggerswitch",
            active = skullsManager.skulls.triggerswitch,
            func = skullsManager.skullTriggerSwitch
        },
        {
            name = "slayer",
            active = skullsManager.skulls.slayer,
            func = skullsManager.skullSlayer
        },
        {
            name = "banger",
            active = skullsManager.skulls.banger,
            func = skullsManager.skullBanger},
        {
            name = "knuckehead",
            active = skullsManager.skulls.knuckehead,
            func = skullsManager.skullKnucklehead
        }
    }

    local anyDeactivated = false

    for _, skull in ipairs(skullList) do
        if skull.active == true then
            skull.func(true) -- Llama a la función de desactivación con restore=true
            logger:debug("Skull desactivada: " .. skull.name)
            anyDeactivated = true
        end
    end

    if not anyDeactivated then
        logger:debug("No hay silver skulls activadas para desactivar.")
    end
end


local currentSet = 1
function skullsManager.goldenSkulls()
    currentSet = currentSet + 1
    if currentSet == 2 then
        skullsManager.skullHunger(false)
    elseif currentSet == 3 then
        skullsManager.skullMythic(false)
    elseif currentSet == 4 then
        skullsManager.skullBlind(false)
    end
    -- skullsManager.skullCatch()
end

-- Variable para handle nulo o vacío de un Tag
local nullHandle = 0xFFFFFFFF

-- These flags indicate where a skull is On or Off.
skullsManager.skulls = {
    hunger = false,
    mythic = false,
    blind = false,
    -- catch = false,
    assasin = false,
    berserk = false,
    knuckehead = false,
    banger = false,
    dobledown = false,
    eyepatch = false,
    triggerswitch = false,
    slayer = false
}

-- These keywords help separate the tags needed.
local keywords = {"flood", "elite", "grunt", "jackal", "hunter", "odst"}

-- We look for all actor_variants in the map.
function skullsManager.actorVariantsFiltered()
    local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
    assert(actorVariantTagEntries)
    local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function(tagEntry)
        for _, keyword in pairs(keywords) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    return actorVariantEntriesFiltered
end

-- Blind: Hides HUD and duplicates AI error.
---@param restore boolean
function skullsManager.skullBlind(restore)
    local hscLegacy = require "hscLegacy"
    if restore == true then
        for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 0.5
        end
        hscLegacy.showHud(1)
        skullsManager.skulls.blind = false
        logger:debug("Blind Off")
    else
        for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 2
        end
        hscLegacy.showHud(0)
        skullsManager.skulls.blind = true
        logger:debug("Blind On")
    end
end

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
---@param restore boolean
function skullsManager.skullMythic(restore)
    for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if restore == true then
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 0.5
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 0.5
        else
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 2
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 2
        end
    end
    local playerCollisionTagEntry = engine.tag.findTags("marine_mp",
                                                        engine.tag.classes.modelCollisionGeometry)
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
        logger:debug("Mythic Off")
    else
        skullsManager.skulls.mythic = true
        logger:debug("Mythic On")
    end
end

-- Hunger: Makes the AI drop half the ammo.
---@param restore boolean
function skullsManager.skullHunger(restore)
    for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
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
        logger:debug("Hunger Off")
    else
        skullsManager.skulls.hunger = true
        logger:debug("Hunger On")
    end
end

-- Assasin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
local activateOnTick
function skullsManager.skullAssasin() -- (restore)
    if skullsManager.skulls.assasin == true then
        for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if not tagEntry.path:includes("stealth") then
                tagEntry.data.flags:activeCamouflage(false)
            end
        end
        for _, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 0.5
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 2
        end
        skullsManager.skulls.assasin = false
        logger:debug("Assasin Off")
    else
        for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if not tagEntry.path:includes("stealth") then
                tagEntry.data.flags:activeCamouflage(true)
            end
        end
        for _, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 2
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 0.5
            -- for i = 1, tagEntry.data.triggers.count do -- Need to find out how to access a child tag from a parent tag.
            --    local trigger = tagEntry.data.triggers.elements[i]
            --    trigger.projectile.impactDamage.damageActiveCamouflageDamage = wololooo
            -- end
        end
        skullsManager.skulls.assasin = true
        activateOnTick = true
        logger:debug("Assasin On")
    end
end

local player
---@param playerIndex? number
function skullsManager.skullAssasinOnTick(playerIndex)
    if activateOnTick == true then
        if skullsManager.skulls.assasin == true then
            if playerIndex then
                player = blam.biped(get_dynamic_player(playerIndex))
            else
                player = blam.biped(get_dynamic_player())
            end
            assert(player)
            if player then
                player.isCamoActive = true
            end
            if player.meleeKey then
                player.camoScale = 0
            end
        else
            player.isCamoActive = false
            activateOnTick = false
        end
    end
end

---- Catch: Makes the AI launch grenades a fuck lot. CURRENTLY NOT WORKING.
-- function skullsManager.skullCatch(restore)
--    if skullsManager.skulls.catch then
--        for _, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
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

-- We look for all actors in the map.
function skullsManager.actorsFiltered()
    local actorTagEntries = engine.tag.findTags("", engine.tag.classes.actor)
    assert(actorTagEntries)
    local actorEntriesFiltered = table.filter(actorTagEntries, function(tagEntry)
        for _, keyword in pairs(keywords) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    return actorEntriesFiltered
end

---Berserk: Makes the AI enter in constant Berserk state.
---@param restore boolean
function skullsManager.skullBerserk(restore)
    for _, tagEntry in ipairs(skullsManager.actorsFiltered()) do
        if tagEntry.path:includes("elite") or tagEntry.path:includes("hunter") then
            if restore == true then
                tagEntry.data.flags:alwaysChargeAtEnemies(false)
                tagEntry.data.flags:alwaysBerserkInAttackingMode(false)
                tagEntry.data.flags:alwaysChargeInAttackingMode(false)
            else
                tagEntry.data.flags:alwaysChargeAtEnemies(true)
                tagEntry.data.flags:alwaysBerserkInAttackingMode(true)
                tagEntry.data.flags:alwaysChargeInAttackingMode(true)
            end
        end
    end
    if restore == true then
        skullsManager.skulls.berserk = false
        logger:debug("Berserk Off")
    else
        skullsManager.skulls.berserk = true
        logger:debug("Berserk On")
    end
end

-- We look for all actors in the map.
function skullsManager.collisionsFiltered()
    local modelCollisionTagEntries = engine.tag.findTags("",
                                                         engine.tag.classes.modelCollisionGeometry)
    assert(modelCollisionTagEntries)
    local modelCollisionEntriesFiltered = table.filter(modelCollisionTagEntries, function(tagEntry)
        for _, keyword in pairs(keywords) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    return modelCollisionEntriesFiltered
end

-- We look for all impact damages referenced in the projectiles.
function skullsManager.impactDamageFiltered()
    local projectileTagEntries = engine.tag.findTags("", engine.tag.classes.projectile)
    assert(projectileTagEntries)
    local damageEffectTagEntries = engine.tag.findTags("", engine.tag.classes.damageEffect)
    assert(damageEffectTagEntries)
    local impactDamageFiltered = table.filter(damageEffectTagEntries, function(tagEntry)
        for _, impactValue in ipairs(projectileTagEntries) do
            if tagEntry.handle.value == impactValue.data.impactDamage.tagHandle.value then
                return true
            end
        end
        return false
    end)
    -- local impactDamageFiltered
    -- for _, tagEntry in ipairs(projectileTagEntries) do
    --    impactDamageFiltered = tagEntry.data.impactDamage.tagHandle.value
    -- end
    return impactDamageFiltered
end

-- Knucklehead: Multiplies damage to the head x50. Reduces weapon's impact damage to a 1/5
---@param restore boolean
function skullsManager.skullKnucklehead(restore)
    for _, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if not tagEntry.path:includes("hunter") then
                if restore == true then
                    if material.flags:head() then
                        shield = shield * 0.02
                        body = body * 0.02
                    end
                else
                    if material.flags:head() then
                        shield = shield * 50
                        body = body * 50
                    end
                end
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    for _, tagEntry in ipairs(skullsManager.impactDamageFiltered()) do
        if restore == true then
            tagEntry.data.damageLowerBound = tagEntry.data.damageLowerBound * 5
            tagEntry.data.damageUpperBound[1] = tagEntry.data.damageUpperBound[1] * 5
            tagEntry.data.damageUpperBound[2] = tagEntry.data.damageUpperBound[2] * 5
            tagEntry.data.cyborgArmor = tagEntry.data.cyborgArmor * 0.2
            tagEntry.data.cyborgArmor = tagEntry.data.cyborgArmor * 0.2
            tagEntry.data.humanArmor = tagEntry.data.humanArmor * 0.2
            tagEntry.data.humanSkin = tagEntry.data.humanSkin * 0.2
        else
            tagEntry.data.damageLowerBound = tagEntry.data.damageLowerBound * 0.2
            tagEntry.data.damageUpperBound[1] = tagEntry.data.damageUpperBound[1] * 0.2
            tagEntry.data.damageUpperBound[2] = tagEntry.data.damageUpperBound[2] * 0.2
            tagEntry.data.cyborgArmor = tagEntry.data.cyborgArmor * 5
            tagEntry.data.cyborgArmor = tagEntry.data.cyborgArmor * 5
            tagEntry.data.humanArmor = tagEntry.data.humanArmor * 5
            tagEntry.data.humanSkin = tagEntry.data.humanSkin * 5
        end
    end
    if restore == true then
        skullsManager.skulls.knuckehead = false
        logger:debug("Knucklehead Off")
    else
        skullsManager.skulls.knuckehead = true
        logger:debug("Knucklehead On")
    end
end

---Banger: Makes Grunts explode after dying.
---@param restore boolean
function skullsManager.skullBanger(restore)
    for _, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        local findTags = engine.tag.findTags
        local plasmaExplosion = findTags("weapons\\plasma grenade\\effects\\explosion",
                                         engine.tag.classes.effect)[1]
        if tagEntry.path:includes("grunt") then
            if restore == true then
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold - 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = nullHandle
            else
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold + 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            end
        end
    end
    if restore == true then
        skullsManager.skulls.banger = false
        logger:debug("Banger Off")
    else
        skullsManager.skulls.banger = true
        logger:debug("Banger On")
    end
end

-- Double Down: Duplicates player's shields, but also it's recharging time.
---@param restore boolean
function skullsManager.skullDoubleDown(restore)
    local playerCollisionTagEntry = engine.tag.findTags("marine_mp",
                                                        engine.tag.classes.modelCollisionGeometry)
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
        skullsManager.skulls.dobledown = false
        logger:debug("Double Down Off")
    else
        skullsManager.skulls.dobledown = true
        logger:debug("Double Down On")
    end
end

-- We look for all weapons in the map.
function skullsManager.weaponsFiltered()
    local weaponTagEntries = engine.tag.findTags("", engine.tag.classes.weapon)
    assert(weaponTagEntries)
    return weaponTagEntries
end

-- Eye Patch: Eliminates weapons assistances & initial error.
---@param restore boolean
function skullsManager.skullEyePatch(restore)
    for _, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
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
        skullsManager.skulls.eyepatch = false
        logger:debug("Eye Patch Off")
    else
        skullsManager.skulls.eyepatch = true
        logger:debug("Eye Patch On")
    end
end

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
---@param restore boolean
function skullsManager.skullTriggerSwitch(restore)
    for _, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
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
        skullsManager.skulls.triggerswitch = false
        logger:debug("Trigger Switch Off")
    else
        skullsManager.skulls.triggerswitch = true
        logger:debug("Trigger Switch On")
    end
end

-- Slayer: Weapons shoot doble rounds and waste double ammo.
---@param restore boolean
function skullsManager.skullSlayer(restore)
    for _, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
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
    if restore == true then
        skullsManager.skulls.slayer = false
        logger:debug("Slayer Off")
    else
        skullsManager.skulls.slayer = true
        logger:debug("Slayer On")
    end
end

return skullsManager
