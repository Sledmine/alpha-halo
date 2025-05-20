local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}
local inspect = require "inspect"
--local const = require "alpha_halo.constants"

function skullsManager.turnOnSkulls()
    --skullsManager.skullMythic()
    --skullsManager.skullHunger()
    --skullsManager.skullCatch()
    --skullsManager.skullAssasin()
    --skullsManager.skullBerserk()
    --skullsManager.skullKnucklehead()
    skullsManager.skullBanger()
end

function skullsManager.turnOffSkulls()
    --skullsManager.skullMythic(restore)
    --skullsManager.skullHunger(restore)
    --skullsManager.skullCatch(restore)
    --skullsManager.skullAssasin(restore)
    --skullsManager.skullBerserk(restore)
    --skullsManager.skullKnucklehead(restore)
    --skullsManager.skullBanger(restore)
end

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    mythic = false,
    hunger = false,
    catch = false,
    assasin = false,
    berserk = false,
    knuckehead = false,
    banger = false
}

-- These keywords help separate the tags needed.
local keywords = {
    "flood",
    "elite",
    "grunt",
    "jackal",
    "hunter",
    "sentinel",
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

-- Mythic: Duplicates all AI body & shields vitality.
function skullsManager.skullMythic(restore) -- It works!
    for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if restore then
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality / 2
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality / 2
            skullsManager.skulls.mythic = false
            engine.core.consolePrint("Mythic Off")
        else
            tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 2
            tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 2
            skullsManager.skulls.mythic = true
            engine.core.consolePrint("Mythic On")
        end
    end
end

-- Hunger: Makes the AI drop half the ammo.
function skullsManager.skullHunger(restore) -- It works!
    for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if restore then
            tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] * 2
            tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] * 2
            tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] * 2
            tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] * 2
            skullsManager.skulls.hunger = false
            engine.core.consolePrint("Hunger Off")
        else
            tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] / 2
            tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] / 2
            tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] / 2
            tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] / 2
            skullsManager.skulls.hunger = true
            engine.core.consolePrint("Hunger On")
        end
    end
end

-- Assasin: Makes the AI invisible.
function skullsManager.skullAssasin(restore) -- It works!
    for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
        if not tagEntry.path:includes("stealth") then
            if restore then
                tagEntry.data.flags:activeCamouflage(false)
                skullsManager.skulls.assasin = false
                engine.core.consolePrint("Assasin Off")
            else
                tagEntry.data.flags:activeCamouflage(true)
                skullsManager.skulls.assasin = true
                engine.core.consolePrint("Assasin On")
            end
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
function skullsManager.skullBerserk(restore) -- It works!
    for index, tagEntry in ipairs(skullsManager.actorsFiltered()) do
        if tagEntry.path:includes("elite") or tagEntry.path:includes("hunter") then
            if restore then
                tagEntry.data.flags:alwaysChargeAtEnemies(false)
                tagEntry.data.flags:alwaysBerserkInAttackingMode(false)
                tagEntry.data.flags:alwaysChargeInAttackingMode(false)
                skullsManager.skulls.berserk = false
                engine.core.consolePrint("Berserk Off")
            else
                tagEntry.data.flags:alwaysChargeAtEnemies(true)
                tagEntry.data.flags:alwaysBerserkInAttackingMode(true)
                tagEntry.data.flags:alwaysChargeInAttackingMode(true)
                skullsManager.skulls.berserk = true
                engine.core.consolePrint("Berserk On")
            end
        end
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
function skullsManager.skullKnucklehead(restore) -- It works!
    for index, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        for i = 1, tagEntry.data.materials.count do
            local material = tagEntry.data.materials.elements[i]
            local shield = material.shieldDamageMultiplier
            local body = material.bodyDamageMultiplier
            if not tagEntry.path:includes("hunter") or not tagEntry.path:includes("sentinel") then
                if restore then
                    if material.flags:head() then
                        if shield > 0 then
                            shield = shield / 10
                        end
                        if body > 0 then
                            body = body / 10
                        end
                    else
                        shield = shield * 10
                        body = body * 10
                    end
                    skullsManager.skulls.knuckehead = false
                    engine.core.consolePrint("Kucklehead Off")
                else
                    if material.flags:head() then
                        shield = shield * 10
                        body = body * 10
                    else
                        if shield > 0 then
                            shield = shield / 10
                        end
                        if body > 0 then
                            body = body / 10
                        end
                    end
                    skullsManager.skulls.knuckehead = true
                    engine.core.consolePrint("Kucklehead On")
                end
            end
            material.shieldDamageMultiplier = shield
            material.bodyDamageMultiplier = body
        end
    end
end

-- Banger: Makes bipeds explode after dying.
function skullsManager.skullBanger(restore)
    for index, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
        local null
        local findTags = engine.tag.findTags
        local plasmaExplosion = findTags("weapons\\plasma grenade\\effects\\explosion", engine.tag.classes.effect)[1]
        if tagEntry.path:includes("grunt") then
            if restore then
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold - 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = null
                skullsManager.skulls.banger = false
                engine.core.consolePrint("Banger Off")
            else
                tagEntry.data.bodyDamagedThreshold = tagEntry.data.bodyDamagedThreshold + 0.1
                tagEntry.data.bodyDepletedEffect.tagHandle.value = plasmaExplosion.handle.value
                skullsManager.skulls.banger = true
                engine.core.consolePrint("Banger On")
            end
        end
    end
end

return skullsManager