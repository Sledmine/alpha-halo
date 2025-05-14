local blam = require "blam"
local engine = Engine
local balltze = Balltze
local skullsManager = {}
local inspect = require "inspect"

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    mythic = false,
    assasin = false,
    hunger = false,
    catch = false
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

-- Mythic: Duplicates all AI body & shields vitality.
function skullsManager.skullMythic(restore)
    if skullsManager.skulls.mythic then
        local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
        local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function (tagEntry)
            for _, keyword in pairs(keywords) do
                if tagEntry.path:includes(keyword) then
                    return true
                end
            end
            return false
        end)
        for index, tagEntry in ipairs(actorVariantEntriesFiltered) do
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

-- Hunger: Makes the AT drop half the ammo.
function skullsManager.skullHunger(restore)
    if skullsManager.skulls.assasin then
        local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
        local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function (tagEntry)
            for _, keyword in pairs(keywords) do
                if tagEntry.path:includes(keyword) then
                    return true
                end
            end
            return false
        end)
        for index, tagEntry in ipairs(actorVariantEntriesFiltered) do
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
        local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
        local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function (tagEntry)
            for _, keyword in pairs(keywords) do
                if tagEntry.path:includes(keyword) then
                    return true
                end
            end
            return false
        end)
        for index, tagEntry in ipairs(actorVariantEntriesFiltered) do
            if restore then
                tagEntry.data.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.usNever
            else
                tagEntry.data.grenadeStimulus = engine.tag.actorVariantGrenadeStimulus.usVisibleTarget
                tagEntry.data.minimumEnemyCount = 1
                tagEntry.data.enemyRadius = 6
                tagEntry.data.grenadeVelocity = 5
                tagEntry.data.grenadeRanges[1] = 4.5
                tagEntry.data.grenadeRanges[2] = 14
                tagEntry.data.collateralDamageRadius = 1
                tagEntry.data.grenadeChance = 1
                tagEntry.data.grenadeCheckTime = 0.5
                tagEntry.data.encounterGrenadeTimeout = 0.5
            end
        end
        engine.core.consolePrint("Catch On")
    end
end

-- Assasin: Makes the AT invisible.
function skullsManager.skullAssasin(restore)
    if skullsManager.skulls.assasin then
        local actorVariantTagEntries = engine.tag.findTags("", engine.tag.classes.actorVariant)
        local actorVariantEntriesFiltered = table.filter(actorVariantTagEntries, function (tagEntry)
            for _, keyword in pairs(keywords) do
                if tagEntry.path:includes(keyword) then
                    return true
                end
            end
            return false
        end)
        for index, tagEntry in ipairs(actorVariantEntriesFiltered) do
            if restore then
                -- wololo
            else
                -- tagEntry.data.flags = MetaEngineTagDataActorVariantFlags.activeCamouflage
            end
        end
        engine.core.consolePrint("Assasin On")
    end
end

return skullsManager