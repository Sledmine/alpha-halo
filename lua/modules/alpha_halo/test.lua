local test = {}
local hsc = require "hsc"
local blam = require "blam"
local player = blam.biped(get_dynamic_player())
local theyChill = false

function test.AllegianceSet()
    if (player) then
        if (player.crouchHold) then
            if (player.actionKey) and (theyChill == false) then
                theyChill = true
                hsc.AllegianceSet(team2, team3)
                hsc.AllegianceSet(team2, team4)
                hsc.AllegianceSet(team2, team5)
                hsc.AllegianceSet(team3, team4)
                hsc.AllegianceSet(team3, team5)
                hsc.AllegianceSet(team4, team5)
            elseif (player.actionKey) and (theyChill == true) then
                theyChill = false
                hsc.AllegianceRemove(team2, team3)
                hsc.AllegianceRemove(team2, team4)
                hsc.AllegianceRemove(team2, team5)
                hsc.AllegianceRemove(team3, team4)
                hsc.AllegianceRemove(team3, team5)
                hsc.AllegianceRemove(team4, team5)
            end
        end
    end
end

return test