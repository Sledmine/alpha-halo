local test = {}
local hsc = require "hsc"
local theyChill = false

function test.AllegianceSet()
    if (theyChill == false) then
        console_out("They're chill")
        hsc.AllegianceSet("player", "covenant")
        hsc.AllegianceSet("player", "flood")
        hsc.AllegianceSet("player", "sentinel")
        hsc.AllegianceSet("human", "covenant")
        hsc.AllegianceSet("human", "flood")
        hsc.AllegianceSet("human", "sentinel")
        hsc.AllegianceSet("covenant", "flood")
        hsc.AllegianceSet("covenant", "sentinel")
        hsc.AllegianceSet("flood", "covenant")
        theyChill = true
    elseif (theyChill == true) then
        console_out("They're angry!")
        hsc.AllegianceRemove("player", "covenant")
        hsc.AllegianceRemove("player", "flood")
        hsc.AllegianceRemove("player", "sentinel")
        hsc.AllegianceRemove("human", "covenant")
        hsc.AllegianceRemove("human", "flood")
        hsc.AllegianceRemove("human", "sentinel")
        hsc.AllegianceRemove("covenant", "flood")
        hsc.AllegianceRemove("covenant", "sentinel")
        hsc.AllegianceRemove("flood", "covenant")
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