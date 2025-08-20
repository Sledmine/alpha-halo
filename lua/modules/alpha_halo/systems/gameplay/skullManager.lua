local blind = require "skulls.blind"
local fog = require "skulls.fog"

local skullManager = {}

function skullManager.eachTick()
    blind.onTick(false, skullManager.skulls)
    fog.onTick(false, skullManager.skulls)
end

-- Lista de calaveras registradas
skullManager.skulls = {
    blind = {
        name = "Blind",
        type = "golden",
        func = function(isActive)
            blind.set(isActive, skullManager.skulls)
        end,
        active = false
    },
    fog = {
        name = "Fog",
        type = "silver",
        func = function(isActive)
            fog.set(isActive, skullManager.skulls)
        end,
        active = false
    }
}

local goldenSkulls = {skullManager.skulls.blind}

local silverSkulls = {skullManager.skulls.fog}

-- Resto del código original para activar/desactivar calaveras (sin modificar)
-- lo copiamos desde el archivo original...
---Enable Specified Skull by type and name
---@param skullType string | "silver" | "golden"
---@param name string | "random" | "all"
function skullManager.enableSkull(skullType, name)
    local skullList = skullType == "silver" and silverSkulls or skullType == "golden" and
                          goldenSkulls or nil

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
                    logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper),
                                skull.name)
                else
                    logger:warning("{} skull '{}' is already active.",
                                   skullType:gsub("^%l", string.upper), skull.name)
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
        logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper),
                    randomSkull.name)
        return
    end

    -- Search by specific name
    for _, skull in ipairs(skullList) do
        if name:lower() == skull.name:lower() then
            if skull.active then
                logger:warning("{} skull '{}' is already active.",
                               skullType:gsub("^%l", string.upper), skull.name)
            else
                skull.func(true)
                skull.active = true
                logger:info("{} skull '{}' activated.", skullType:gsub("^%l", string.upper),
                            skull.name)
            end
            return
        end
    end

    logger:info("{} skull '{}' not found. Available: {}", skullType:gsub("^%l", string.upper), name,
                table.concat(table.map(skullList, function(s)
        return s.name:lower()
    end), ", "))
end

--------------------------------------------------Disable Skull--------------------------------------------------

---Disable specified Skull by type and name
---@param skullType string | "silver" | "golden"
---@param name string | "random" | "all" | "is_active"
function skullManager.disableSkull(skullType, name)
    -- Select the list of skulls by type
    local skullList = skullType == "silver" and silverSkulls or skullType == "golden" and
                          goldenSkulls or nil

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
                logger:info("{} skull: '{}' deactivated", skullType:gsub("^%l", string.upper),
                            skull.name)
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
            logger:warning("All {} skulls are already deactivated.",
                           skullType:gsub("^%l", string.upper))
            return
        end

        -- Choose a random active skull and deactivate it
        local randomSkull = activeSkulls[math.random(#activeSkulls)]
        randomSkull.func(false)
        randomSkull.active = false
        logger:info("{} skull: '{}' deactivated", skullType:gsub("^%l", string.upper),
                    randomSkull.name)
        return
    end

    -- Disable only the currently activated skulls of this type
    if name:lower() == "is_active" then
        local anyDeactivated = false
        for _, skull in ipairs(skullList) do
            if skull.active then
                skull.func(false)
                skull.active = false
                logger:info("{} Skull '{}' deactivated.", skullType:gsub("^%l", string.upper),
                            skull.name)
                anyDeactivated = true
            end
        end

        if not anyDeactivated then
            logger:warning("No {} skulls are currently activated.",
                           skullType:gsub("^%l", string.upper))
        end
        return
    end

    -- Search by specific name
    for _, skull in ipairs(skullList) do
        if name:lower() == skull.name:lower() then
            if not skull.active then
                logger:warning("{} Skull '{}' is already inactive.",
                               skullType:gsub("^%l", string.upper), skull.name)
            else
                skull.func(false)
                skull.active = false
                logger:info("{} Skull '{}' deactivated.", skullType:gsub("^%l", string.upper),
                            skull.name)
            end
            return
        end
    end

    -- If the name does not match any skull, show error
    logger:info("{} Skull '{}' not found. Available: {}", skullType:gsub("^%l", string.upper), name,
                table.concat(table.map(skullList, function(s)
        return s.name:lower()
    end), ", "))
end

return skullManager
