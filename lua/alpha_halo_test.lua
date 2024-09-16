local test = require "alpha_halo.test"
local blam = require "blam"
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
    test.AiCheck()
    if player.actionKey and player.crouchHold then
        test.AllegianceSet()
    end
end

--OnMapLoad()
set_callback("map load", "OnMapLoad")
set_callback("tick", "OnTick")