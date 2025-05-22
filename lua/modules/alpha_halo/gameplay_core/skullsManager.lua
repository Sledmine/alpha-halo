local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}
local inspect = require "inspect"
--local const = require "alpha_halo.constants" -- Podríamos limpiar el código pasando los filtros a constants.
--local firefightManager = require "alpha_halo.firefightManager"  -- Espera a la implementación de onFirstTick.

-- ACTUALMENTE NO HAY NADA HACIENDO COMPROBACIÓN DE QUE EL MAPA YA CARGÓ ANTES DE HACER TODO ESTO.
function skullsManager.silverSkulls()
    local selectedSkull = math.random(1, 8)
    -- Aquí debería enumerar las calaveras.
    -- Escoger una según lo que salgan en selected skull.
    skullsManager.skullAssasin()
    skullsManager.skullBerserk()
    skullsManager.skullKnucklehead()
    skullsManager.skullBanger()
    skullsManager.skullDoubleDown()
    skullsManager.skullEyePatch()
    skullsManager.skullTriggerSwitch()
    skullsManager.skullSlayer()
end

function skullsManager.resetSilverSkulls()
    skullsManager.skullAssasin(restore)
    skullsManager.skullBerserk(restore)
    skullsManager.skullKnucklehead(restore)
    skullsManager.skullBanger(restore)
    skullsManager.skullDoubleDown(restore)
    skullsManager.skullEyePatch(restore)
    skullsManager.skullTriggerSwitch(restore)
    skullsManager.skullSlayer(restore)
end

function skullsManager.goldenSkulls() -- Espera a la implementación de onFirstTick.
    --if firefightManager.currentSet == 2 then
    --    skullsManager.skullHunger()
    --elseif firefightManager.currentSet == 3 then
    --    skullsManager.skullMythic()
    --elseif firefightManager.currentSet == 4 then
    --    skullsManager.skullBlind()
    --end
    --skullsManager.skullCatch()
end

-- These flags indicate where a skull is On or Off.
skullsManager.skulls = {
    hunger = false,
    mythic = false,
    blind = false,
    --catch = false,
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
local keywords = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "odst"
}

-- We look for all actor_variants in the map.
function skullsManager.actorVariantsFiltered()
    local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
    assert(actorVariantTagEntries)
    local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function (tagEntry)
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
function skullsManager.skullBlind(restore)
    local hsc = require "hsc"
    if restore then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 0.5
        end
        hsc.showHud(1)
        skullsManager.skulls.blind = false
        engine.core.consolePrint("Blind Off")
    else
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            tagEntry.data.projectileError = tagEntry.data.projectileError * 2
        end
        hsc.showHud(0)
        skullsManager.skulls.blind = true
        engine.core.consolePrint("Blind On")
    end
end

-- Mythic: AI gets double body & shield vitality, while player gets x1.5 boost.
function skullsManager.skullMythic(restore)
    for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if restore then
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 0.5
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 0.5
        else
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 2
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 2
        end
    end
    local playerCollisionTagEntry = engine.tag.findTags("marine_mp", engine.tag.classes.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for index, tagEntry in ipairs(playerCollisionTagEntry) do
        if restore then
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality / 1.5
            tagEntry.data.maximumBodyVitality = tagEntry.data.maximumBodyVitality / 1.5
        else
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 1.5
            tagEntry.data.maximumBodyVitality = tagEntry.data.maximumBodyVitality * 1.5
        end
    end
    if restore then
        skullsManager.skulls.mythic = false
        engine.core.consolePrint("Mythic Off")
    else
        skullsManager.skulls.mythic = true
        engine.core.consolePrint("Mythic On")
    end
end

-- Hunger: Makes the AI drop half the ammo.
function skullsManager.skullHunger(restore)
    for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if restore then
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
    if restore then
        skullsManager.skulls.hunger = false
        engine.core.consolePrint("Hunger Off")
    else
        skullsManager.skulls.hunger = true
        engine.core.consolePrint("Hunger On")
    end
end

-- Assasin: Makes the AI and player invisible. Reduces weapon's cammo recovery. Melee also damages cammo.
local activateOnTick
function skullsManager.skullAssasin(restore)
    if restore then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if not tagEntry.path:includes("stealth") then
                tagEntry.data.flags:activeCamouflage(false)
            end
        end
        for index, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 0.5
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 2
        end
        skullsManager.skulls.assasin = false
        engine.core.consolePrint("Assasin Off")
    else
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if not tagEntry.path:includes("stealth") then
                tagEntry.data.flags:activeCamouflage(true)
            end
        end
        for index, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
            tagEntry.data.activeCamoDing = tagEntry.data.activeCamoDing * 2
            tagEntry.data.activeCamoRegrowthRate = tagEntry.data.activeCamoRegrowthRate * 0.5
            --for i = 1, tagEntry.data.triggers.count do -- Need to find out how to access a child tag from a parent tag.
            --    local trigger = tagEntry.data.triggers.elements[i]
            --    trigger.projectile.impactDamage.damageActiveCamouflageDamage = wololooo
            --end
        end
        skullsManager.skulls.assasin = true
        activateOnTick = true
        engine.core.consolePrint("Assasin On")
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
                player.camoScale = player.camoScale - 0.5
            end
        else
            player.isCamoActive = false
            activateOnTick = false
        end
    end
end

---- Catch: Makes the AI launch grenades a fuck lot. CURRENTLY NOT WORKING.
--function skullsManager.skullCatch(restore)
--    if skullsManager.skulls.catch then
--        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
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
--                tagEntry.data.grenadeCheckTime = tagEntry.data.grenadeCheckTime / 10
--                tagEntry.data.encounterGrenadeTimeout = tagEntry.data.encounterGrenadeTimeout / 100
--                tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance / 10
--            end
--        end
--        engine.core.consolePrint("Catch On")
--    end
--end

-- We look for all actors in the map.
function skullsManager.actorsFiltered()
    local actorTagEntries = engine.tag.findTags("", engine.tag.classes.actor)
    assert(actorTagEntries)
    local actorEntriesFiltered = table.filter(actorTagEntries, function (tagEntry)
        for _, keyword in pairs(keywords) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    return actorEntriesFiltered
end

-- Berserk: Makes the AI enter in constant Berserk state.
function skullsManager.skullBerserk(restore)
    for index, tagEntry in ipairs(skullsManager.actorsFiltered()) do
        if tagEntry.path:includes("elite") or tagEntry.path:includes("hunter") then
            if restore then
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
    if restore then
        skullsManager.skulls.berserk = false
        engine.core.consolePrint("Berserk Off")
    else
        skullsManager.skulls.berserk = true
        engine.core.consolePrint("Berserk On")
    end
end

-- We look for all actors in the map.
function skullsManager.collisionsFiltered()
    local modelCollisionTagEntries = engine.tag.findTags("", engine.tag.classes.modelCollisionGeometry)
    assert(modelCollisionTagEntries)
    local modelCollisionEntriesFiltered = table.filter(modelCollisionTagEntries, function (tagEntry)
        for _, keyword in pairs(keywords) do
            if tagEntry.path:includes(keyword) then
                return true
            end
        end
        return false
    end)
    return modelCollisionEntriesFiltered
end

-- Knucklehead: Multiplies damage to the head x10. Divides damage to the body by /10.
function skullsManager.skullKnucklehead(restore)
    for index, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if not tagEntry.path:includes("hunter") then
                if restore then
                    if material.flags:head() then
                        shield = shield * 0.1
                        body = body * 0.1
                    else
                        shield = shield * 5
                        body = body * 5
                    end
                else
                    if material.flags:head() then
                        shield = shield * 10
                        body = body * 10
                    else
                        shield = shield * 0.2
                        body = body * 0.2
                    end
                end
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
    if restore then
        skullsManager.skulls.knuckehead = false
        engine.core.consolePrint("Knucklehead Off")
    else
        skullsManager.skulls.knuckehead = true
        engine.core.consolePrint("Knucklehead On")
    end
end

-- Banger: Makes Grunts explode after dying.
function skullsManager.skullBanger(restore)
    for index, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        local null
        local findTags = engine.tag.findTags
        local plasmaExplosion = findTags("weapons\\plasma grenade\\effects\\explosion", engine.tag.classes.effect)[1]
        if tagEntry.path:includes("grunt") then
            if restore then
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold - 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = null
            else
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold + 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
            end
        end
    end
    if restore then
        skullsManager.skulls.banger = false
        engine.core.consolePrint("Banger Off")
    else
        skullsManager.skulls.banger = true
        engine.core.consolePrint("Banger On")
    end
end

-- Double Down: Duplicates player's shields, but also it's recharging time.
function skullsManager.skullDoubleDown(restore)
    local playerCollisionTagEntry = engine.tag.findTags("marine_mp", engine.tag.classes.modelCollisionGeometry)
    assert(playerCollisionTagEntry) -- There must be a better way to do this ^^^.
    for index, tagEntry in ipairs(playerCollisionTagEntry) do
        if restore then
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 0.5
            tagEntry.data.stunTime = tagEntry.data.stunTime * 0.5
            tagEntry.data.rechargeTime = tagEntry.data.rechargeTime * 0.5
        else
            tagEntry.data.maximumShieldVitality = tagEntry.data.maximumShieldVitality * 2
            tagEntry.data.stunTime = tagEntry.data.stunTime * 2
            tagEntry.data.rechargeTime = tagEntry.data.rechargeTime * 2
        end
    end
    if restore then
        skullsManager.skulls.dobledown = false
        engine.core.consolePrint("Double Down Off")
    else
        skullsManager.skulls.dobledown = true
        engine.core.consolePrint("Double Down On")
    end
end

-- We look for all weapons in the map.
function skullsManager.weaponsFiltered()
    local weaponTagEntries = engine.tag.findTags("", engine.tag.classes.weapon)
    assert(weaponTagEntries)
    return weaponTagEntries
end

-- Eye Patch: Eliminates weapons assistances & initial error.
function skullsManager.skullEyePatch(restore)
    for index, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
        if restore then
            tagEntry.data.autoaimAngle = tagEntry.data.autoaimAngle * 100
            tagEntry.data.autoaimRange = tagEntry.data.autoaimRange * 100
            tagEntry.data.magnetismAngle = tagEntry.data.magnetismAngle * 100
            tagEntry.data.magnetismRange = tagEntry.data.magnetismRange * 100
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 100
                --trigger.errorAngle[2] = trigger.errorAngle[2] * 2
            end
        else
            tagEntry.data.autoaimAngle = tagEntry.data.autoaimAngle * 0.01
            tagEntry.data.autoaimRange = tagEntry.data.autoaimRange * 0.01
            tagEntry.data.magnetismAngle = tagEntry.data.magnetismAngle * 0.01
            tagEntry.data.magnetismRange = tagEntry.data.magnetismRange * 0.01
            for i = 1, tagEntry.data.triggers.count do
                local trigger = tagEntry.data.triggers.elements[i]
                trigger.errorAngle[1] = trigger.errorAngle[1] * 0.01
                --trigger.errorAngle[2] = trigger.errorAngle[2] * 0.5
            end
        end
    end
    if restore then
        skullsManager.skulls.eyepatch = false
        engine.core.consolePrint("Eye Patch Off")
    else
        skullsManager.skulls.eyepatch = true
        engine.core.consolePrint("Eye Patch On")
    end
end

-- Trigger Switch: Auto weapons became semi-auto and vice versa.
function skullsManager.skullTriggerSwitch(restore)
    for index, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
        if restore then
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
    if restore then
        skullsManager.skulls.triggerswitch = false
        engine.core.consolePrint("Trigger Switch Off")
    else
        skullsManager.skulls.triggerswitch = true
        engine.core.consolePrint("Trigger Switch On")
    end
end

-- Slayer: Weapons shoot doble rounds and waste double ammo.
function skullsManager.skullSlayer(restore)
    for index, tagEntry in ipairs(skullsManager.weaponsFiltered()) do
        if restore then
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
        engine.core.consolePrint("Slayer Off")
    else
        skullsManager.skulls.slayer = true
        engine.core.consolePrint("Slayer On")
    end
end


return skullsManager