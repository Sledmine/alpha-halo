local test = {}
local hsc = require "hsc"
local theyChill = false

function test.AllegianceSet()
    local teams = {"player", "covenant", "sentinel", "flood"}
    if (theyChill == false) then
        for i = 1, #teams do
            for k = 1, #teams do
                hsc.AllegianceSet(teams[i], teams[k])
            end
        end
        theyChill = true
    elseif (theyChill == true) then
        for i = 1, #teams do
            for k = 1, #teams do
                hsc.AllegianceRemove(teams[i], teams[k])
            end
        end
        theyChill = false
    end
end

function test.AiCheck()
      hsc.aiMagicallySee(1, "Covenant_Firing_Positions", "players")
      hsc.aiMagicallySee(1, "UNSC_Firing_Positions", "players")
      hsc.aiMagicallySee(1, "Sentinels_Firing_Positions", "players")
      hsc.aiMagicallySee(1, "Flood_Firing_Positions", "players")
      hsc.aiAction(2, "Covenant_Firing_Positions")
      hsc.aiAction(2, "UNSC_Firing_Positions")
      hsc.aiAction(2, "Sentinels_Firing_Positions")
      hsc.aiAction(2, "Flood_Firing_Positions")
end

return test