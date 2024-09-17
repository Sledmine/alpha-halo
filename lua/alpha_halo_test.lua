local blam = require "blam"
local test = require "alpha_halo.test"
local healthRegen = require "alpha_halo.gameplay_core.healthRegen"
local healthRegenSP = require "alpha_halo.gameplay_core.healthRegenSP"
local healthRegenAlly = require "alpha_halo.gameplay_core.healthRegenAlly"

local isLoaded = false

clua_version = 2.056

function OnMapLoad()
    console_out("Indeed, this IS working")
end

function OnTick()
    if not isLoaded then
        isLoaded = true
        return
    end

    local player = blam.biped(get_dynamic_player())
    if player.actionKey and player.crouchHold then
        test.AllegianceSet()
    end
    
    test.AiCheck()
    --healthRegen.regenerateHealth()
    healthRegenAlly.regenerateHealth()
    healthRegenSP.regenerateHealth()
end

--OnMapLoad()
set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")