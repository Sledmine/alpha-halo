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
    skullsManager.skulls.catch = true
    skullsManager.skullCatch()
    --skullsManager.skulls.assasin = true
    --skullsManager.skullAssasin()
end

-- These flags are the ones who turn on and off the skulls.
skullsManager.skulls = {
    mythic = false,
    hunger = false,
    catch = false,
    assasin = false
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
                -- Hay que encontrar la forma de almacenar la data de las casillas para poder revertir el valor.
            else
                --tagEntry.data.grenadeStimulus = 1
                --tagEntry.data.grenadeCount[1] = tagEntry.data.grenadeCount[1] + 100
                --tagEntry.data.grenadeCount[2] = tagEntry.data.grenadeCount[2] + 100
                tagEntry.data.minimumEnemyCount = 1
                tagEntry.data.enemyRadius = 6
                --tagEntry.data.grenadeVelocity = 5
                tagEntry.data.grenadeRanges[1] = 2.8
                tagEntry.data.grenadeRanges[2] = 12
                tagEntry.data.collateralDamageRadius = 2.5
                tagEntry.data.grenadeChance = 1
                tagEntry.data.grenadeCheckTime = 0.5
                tagEntry.data.encounterGrenadeTimeout = 1
                tagEntry.data.flags:hasUnlimitedGrenades(true)
            end
        end
        engine.core.consolePrint("Catch On")
    end
end

-- Assasin: Makes the AI invisible.
function skullsManager.skullAssasin(restore)
    if skullsManager.skulls.assasin then
        for index, tagEntry in ipairs(skullsManager.actorVariantsFiltered()) do
            if restore then
                tagEntry.data.flags:activeCamouflage(false)
            else
                tagEntry.data.flags:activeCamouflage(true)
            end
        end
        engine.core.consolePrint("Assasin On")
    end
end

return skullsManager