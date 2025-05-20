local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}
local inspect = require "inspect"

function skullsManager.turnOnSkulls()
    --skullsManager.skulls.mythic = true
    --skullsManager.skullMythic()
    --skullsManager.skulls.hunger = true
    --skullsManager.skullHunger()
    --skullsManager.skulls.catch = true
    --skullsManager.skullCatch()
    --skullsManager.skulls.assasin = true
    --skullsManager.skullAssasin()
    --skullsManager.skulls.berserk = true
    --skullsManager.skullBerserk()
    skullsManager.skulls.knuckehead = true
    skullsManager.skullKnucklehead()
end

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    mythic = false,
    hunger = false,
    catch = false,
    assasin = false,
    berserk = false,
    knuckehead = false
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
    if skullsManager.skulls.mythic then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if restore then
                tagEntry.data.bodyVitality = tagEntry.data.bodyVitality / 2
                tagEntry.data.shieldVitality = tagEntry.data.shieldVitality / 2
            else
                tagEntry.data.bodyVitality = tagEntry.data.bodyVitality * 2
                tagEntry.data.shieldVitality = tagEntry.data.shieldVitality * 2
            end
        end
        engine.core.consolePrint("Mythic On")
    end
end

-- Hunger: Makes the AI drop half the ammo.
function skullsManager.skullHunger(restore) -- It works!
    if skullsManager.skulls.hunger then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if restore then
                tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] * 2
                tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] * 2
                tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] * 2
                tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] * 2
            else
                tagEntry.data.dropWeaponLoaded[1] = tagEntry.data.dropWeaponLoaded[1] / 2
                tagEntry.data.dropWeaponLoaded[2] = tagEntry.data.dropWeaponLoaded[2] / 2
                tagEntry.data.dropWeaponAmmo[1] = tagEntry.data.dropWeaponAmmo[1] / 2
                tagEntry.data.dropWeaponAmmo[2] = tagEntry.data.dropWeaponAmmo[2] / 2
            end
        end
        engine.core.consolePrint("Hunger On")
    end
end

-- Catch: Makes the AI launch grenades a fuck lot.
function skullsManager.skullCatch(restore)
    if skullsManager.skulls.catch then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if restore then
                tagEntry.data.flags:hasUnlimitedGrenades(false)
                --tagEntry.data.grenadeStimulus = 2
                tagEntry.data.grenadeChance = tagEntry.data.grenadeChance - 1
                tagEntry.data.grenadeCheckTime = tagEntry.data.grenadeCheckTime * 10
                tagEntry.data.encounterGrenadeTimeout = tagEntry.data.encounterGrenadeTimeout * 100
                tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance * 10
            else
                tagEntry.data.flags:hasUnlimitedGrenades(true)
                --tagEntry.data.grenadeStimulus = 1
                tagEntry.data.grenadeChance = tagEntry.data.grenadeChance + 1
                tagEntry.data.grenadeCheckTime = tagEntry.data.grenadeCheckTime / 10
                tagEntry.data.encounterGrenadeTimeout = tagEntry.data.encounterGrenadeTimeout / 100
                tagEntry.data.dontDropGrenadesChance = tagEntry.data.dontDropGrenadesChance / 10
            end
        end
        engine.core.consolePrint("Catch On")
    end
end

-- Assasin: Makes the AI invisible.
function skullsManager.skullAssasin(restore)
    if skullsManager.skulls.assasin then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if not tagEntry.path:includes("stealth") then
                if restore then
                    tagEntry.data.flags:activeCamouflage(false)
                else
                    tagEntry.data.flags:activeCamouflage(true)
                end
            end
        end
        engine.core.consolePrint("Assasin On")
    end
end

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
    if skullsManager.skulls.berserk then
        for index, tagEntry in ipairs(skullsManager.actorsFiltered()) do
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

function skullsManager.skullKnucklehead(restore)
    if skullsManager.skulls.knuckehead then
        for index, tagEntry in ipairs(skullsManager.collisionsFiltered()) do
            for i = 1, tagEntry.data.materials.count do
                local material = tagEntry.data.materials.elements[i]
                if restore then
                    if material.flags:head(true) then
                        material.shieldDamageMultiplier = material.shieldDamageMultiplier / 5
                        material.bodyDamageMultiplier = material.bodyDamageMultiplier / 5
                    else
                        material.shieldDamageMultiplier = material.shieldDamageMultiplier * 5
                        material.bodyDamageMultiplier = material.bodyDamageMultiplier * 5
                    end
                else
                    if material.flags:head(true) then
                        material.shieldDamageMultiplier = material.shieldDamageMultiplier * 5
                        material.bodyDamageMultiplier = material.bodyDamageMultiplier * 5
                    else
                        material.shieldDamageMultiplier = material.shieldDamageMultiplier / 5
                        material.bodyDamageMultiplier = material.bodyDamageMultiplier / 5
                    end
                end
            end
        end
        engine.core.consolePrint("Kucklehead On")
    end
end

return skullsManager