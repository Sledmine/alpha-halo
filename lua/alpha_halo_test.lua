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
    waveManager.GameStart()
end

function OnTick()
    if not isLoaded then
        OnMapLoad()
        isLoaded = true
        return
    end

    waveManager.WaveManager()
    healthRegenAlly.regenerateHealth()
    healthRegenSP.regenerateHealth()
    --healthRegen.regenerateHealth()
    --test.AiCheck()
end

--OnMapLoad()
--set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")