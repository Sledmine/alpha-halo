local engine = Engine
local balltze = Balltze

-------------------------------------------------------
-- Skulls Modules
-------------------------------------------------------
local famine = require "alpha_halo.systems.gameplay.skulls.famine"
local mythic = require "alpha_halo.systems.gameplay.skulls.mythic"
local blind = require "alpha_halo.systems.gameplay.skulls.blind"
local catch = require "alpha_halo.systems.gameplay.skulls.catch"
local berserk = require "alpha_halo.systems.gameplay.skulls.berserk"
local toughLuck = require "alpha_halo.systems.gameplay.skulls.toughLuck"
local fog = require "alpha_halo.systems.gameplay.skulls.fog"
local knucklehead = require "alpha_halo.systems.gameplay.skulls.knucklehead"
local cowbell = require "alpha_halo.systems.gameplay.skulls.cowbell"
local havok = require "alpha_halo.systems.gameplay.skulls.havok"
local newton = require "alpha_halo.systems.gameplay.skulls.newton"
local tilt = require "alpha_halo.systems.gameplay.skulls.tilt"
local banger = require "alpha_halo.systems.gameplay.skulls.banger"
local doubleDown = require "alpha_halo.systems.gameplay.skulls.doubleDown"
local eyePatch = require "alpha_halo.systems.gameplay.skulls.eyePatch"
local triggerSwitch = require "alpha_halo.systems.gameplay.skulls.triggerSwitch"
local slayer = require "alpha_halo.systems.gameplay.skulls.slayer"
local assassin = require "alpha_halo.systems.gameplay.skulls.assassin"

local skullsManager = {}

-- This function is called each tick and it's needed for some skulls.
function skullsManager.eachTick()
    -- skullsManager.skullFogOnTick()
    -- skullsManager.skullBlindOnTick()
    -- skullsManager.skullAssassinOnTick()
end

skullsManager.skulls = {
    example = {
        name = "Example",
        motto = "This is an example skull.",
        description = "This skull does nothing.",
        effect = "skullFunctionReference",
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    -- Golden Skulls
    famine = {
        name = "Famine",
        motto = "Trust us, bring a magazine.",
        description = "Enemies dropped weapons with half ammo.",
        effect = famine.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    mythic = {
        name = "Mythic",
        motto = "Coverage under the Covenant Health Plan!",
        description = " Enemies have double health & shields, and player gets a x1.5 bonus of it.",
        effect = mythic.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    blind = {
        name = "Blind",
        motto = "Shoot from the hip.",
        description = "Players have the HUD disabled.",
        effect = blind.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false,
        onTick = function()
        end
    },
    catch = {
        name = "Catch",
        motto = "Pull pin. Count to three. Throw.",
        description = "Enemies launch grenades with more frequency, and throwing speed increases a little.",
        effect = catch.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    -- Silver Skulls
    berserk = {
        name = "Berserk",
        motto = "Reckless rage, poisonous pride.",
        description = "Enemies are in a berserker state.",
        effect = berserk.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    toughluck = {
        name = "Tough Luck",
        motto = "Your foes always make every saving throw.",
        description = "Enemies always evade danger",
        effect = toughLuck.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    fog = {
        name = "Fog",
        motto = "You will miss those eyes in the back of your head.",
        description = "Motion tracker is hidden.",
        effect = fog.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false,
        onTick = function()
        end
    },
    knucklehead = {
        name = "Knucklehead",
        motto = "All brawn and no brain...",
        description = "Body damage gets reduced to 1/5th, and head damage gets a 500% bonus.",
        effect = knucklehead.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    cowbell = {
        name = "Cowbell",
        motto = "More bang for your buck.",
        description = "Acceleration effects are duplicated.",
        effect = cowbell.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    havok = {
        name = "Havok",
        motto = "Deliver hope... and tactical warheads.",
        description = "Doubles explosions radius effect.",
        effect = havok.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = true,
        isEnabled = false,
        isPermanent = false
    },
    newton = {
        name = "Newton",
        motto = "That is... not how the 3rd law works.",
        description = "Melee hits now inflict knockback... To both ends.",
        effect = newton.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = true,
        isEnabled = false,
        isPermanent = false
    },
    tilt = {
        name = "Tilt",
        motto = "What was once resistance is now immunity.",
        description = "Material resistances and weakness are doubled.",
        effect = tilt.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    banger = {
        name = "Banger",
        motto = "Send me out, with a bang.",
        description = "Some enemies drop live grenades at death.",
        effect = banger.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    doubledown = {
        name = "Double Down",
        motto = "Do I feel lucky?",
        description = "Doubles your shield... As well as the stun & recovering time.",
        effect = doubleDown.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    eyepatch = {
        name = "Eye Patch",
        motto = "Like a mad dog.",
        description = "Aim assistance gets reduced to 0, but so is initial error for all weapons.",
        effect = eyePatch.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    triggerswitch = {
        name = "Trigger Switch",
        motto = "A change of pace.",
        description = "Full auto weapons become semi-auto and vice versa.",
        effect = triggerSwitch.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    slayer = {
        name = "Slayer",
        motto = "Double every shot by sheer will of rip & tear.",
        description = "Doubles projectiles per shot & spread cone size.",
        effect = slayer.skullEffect,
        state = {count = 0, max = 2, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false
    },
    assassin = {
        name = "Assassin",
        motto = "Your armor's system is not as... new as ours.",
        description = "Everyone gets active cammo... But yours fail from time to time.",
        effect = assassin.skullEffect,
        state = {count = 0, max = 1, multiplier = 1},
        allowedInRandom = true,
        enabledFromTheStart = false,
        isEnabled = false,
        isPermanent = false,
        onTick = function()
        end
    }
}

local skullList = {
    skullsManager.skulls.famine,
    skullsManager.skulls.mythic,
    --skullsManager.skulls.blind,
    --skullsManager.skulls.catch,
    skullsManager.skulls.berserk,
    skullsManager.skulls.toughluck,
    --skullsManager.skulls.fog,
    skullsManager.skulls.knucklehead,
    skullsManager.skulls.cowbell,
    skullsManager.skulls.havok,
    skullsManager.skulls.newton,
    skullsManager.skulls.tilt,
    skullsManager.skulls.banger,
    skullsManager.skulls.doubledown,
    skullsManager.skulls.eyepatch,
    skullsManager.skulls.triggerswitch,
    skullsManager.skulls.slayer,
    --skullsManager.skulls.assassin
}
skullsManager.skullList = skullList

-- Functions to enable/disable skulls --

local function revertAllSkullEffects()
    logger:debug("Reverting all Skull effects...")
    for _, skull in ipairs(skullList) do
        skull.effect(false)
    end
end

--- Initiate Skull Effect applying its function the number of times specified in its state.
local function initiateSkullEffect(skull)
    -- Apply the effect the number of times specified in its state
    local multiplier = (skull.state.multiplier or 1) * (skull.state.count)
    logger:debug("Initiating Skull effect: {} x{}", skull.name, skull.state.count)
    for i = 1, multiplier do
        skull.effect(true)
    end
    skull.isEnabled = true
end

local function reinitializeEnabledSkulls()
    for _, skull in ipairs(skullList) do
        if skull.isEnabled then
            initiateSkullEffect(skull)
        end
    end
end

local function spendSkull(skull)
    skull.state.count = skull.state.count + 1
    if skull.state.count > skull.state.max then
        skull.state.count = skull.state.max
        logger:warning("Skull '{}' has reached its maximum count of {}.", skull.name,
                        skull.state.max)
    end
    skull.isEnabled = true
end

local function restoreSkull(skull)
    skull.state.count = skull.state.count - 1
    if skull.state.count < 0 then
        skull.state.count = 0
        logger:warning("Skull '{}' is already at its minimum count of 0.", skull.name)
    end
    if skull.state.count == 0 then
        skull.isEnabled = false
        skull.effect(false)
    end
end

---Activate multiple Skulls at once with balancing
---@param skulls table List of skull names to enable
---@param useBalance? boolean Whether to use balancing or not
function skullsManager.enableSkulls(skulls, useBalance)
    -- Revert all skull effects
    revertAllSkullEffects()

    for _, skull in ipairs(skulls) do
        if useBalance then
            spendSkull(skull)
        elseif not useBalance then
            skull.isEnabled = true
        end
        logger:info("Enabling Skull: {} ({})", skull.name, skull.description)
    end

    -- Initiate the effect of the enabled skulls
    reinitializeEnabledSkulls()
end

---Deactive multiple Skulls at once with balancing
---@param skulls table List of skull names to disable
---@param useBalance? boolean Whether to use balancing or not
function skullsManager.disableSkulls(skulls, useBalance)
    -- Revert all skull effects
    revertAllSkullEffects()

    for _, skull in ipairs(skulls) do
        if not useBalance or (useBalance and skull.state.count > 0) then
            restoreSkull(skull)
        end
    end

    -- Re-initiate the effect of the still enabled skulls
    reinitializeEnabledSkulls()
end

---Activate Specified Skull by name
---@param name string | "random" | "all"
---@param multiplier? number
function skullsManager.enableSkull(name, multiplier)
    local name = name:lower()

    -- Revert all skull effects
    revertAllSkullEffects()

    if name == "random" then
        local randomIndex = math.random(1, #skullList)
        local randomSkull = skullList[randomIndex]
        randomSkull.isEnabled = true
        randomSkull.state.multiplier = multiplier or randomSkull.state.multiplier or 1
    else
        -- Enable desired skull
        for _, skull in ipairs(skullList) do
            if name == skull.name:lower() or name == "all" then
                skull.isEnabled = true
                skull.state.multiplier = multiplier or skull.state.multiplier or 1
            end
        end
    end

    -- Initiate the effect of the enabled skulls
    reinitializeEnabledSkulls()
end

---Deactivate specified Skull by type and name
---@param name string | "random" | "all"
function skullsManager.disableSkull(name)
    local name = name:lower()

    if name == "random" then
        local randomIndex = math.random(1, #skullList)
        skullList[randomIndex].isEnabled = false
    else
        -- Disable desired skull
        for _, skull in ipairs(skullList) do
            if name == skull.name:lower() or name == "all" then
                skull.isEnabled = false
            end
        end
    end

    -- Revert the effect of the disabled skulls
    for _, skull in ipairs(skullList) do
        if not skull.isEnabled then
            logger:info("Disabling Skull: {}", skull.name)
            skull.effect(false)
        end
    end
end

return skullsManager
