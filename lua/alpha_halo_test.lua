local blam = require "blam"
local test = require "alpha_halo.test"
local waveManager = require "alpha_halo.gameplay_core.waveManager"
--local healthRegen = require "alpha_halo.gameplay_core.healthRegen"
local healthRegenSP = require "alpha_halo.gameplay_core.healthRegenSP"
local healthRegenAlly = require "alpha_halo.gameplay_core.healthRegenAlly"
require "luna"

local isLoaded = false
clua_version = 2.056

function OnMapLoad()
    console_out("On map load...")
end

function OnTick()
    if not isLoaded then
        OnMapLoad()
        isLoaded = true
        return
    end

    --healthRegen.regenerateHealth()
    --healthRegenAlly.regenerateHealth()
    --healthRegenSP.regenerateHealth()
    --waveManager.WaveManager()
    --test.AiCheck()
end

--OnMapLoad()
--set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")