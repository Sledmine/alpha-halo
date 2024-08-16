local test = {}
local hsc = require "hsc"
local theyChill = false

--[[function test.AllegianceSetPlayer()
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
end]]

function test.AllegianceSet()
    if (theyChill == false) then
        hsc.aiState(2, "Covenant_Firing_Positions", 1)
        hsc.aiState(2, "UNSC_Firing_Positions", 1)
        hsc.aiState(2, "Sentinels_Firing_Positions", 1)
        hsc.aiState(2, "Flood_Firing_Positions", 1)
        theyChill = true
        console_out("STOOOOP FIGHTIIIIIIIING!!!")
    elseif (theyChill == true) then
        hsc.aiState(2, "Covenant_Firing_Positions", 2)
        hsc.aiState(2, "UNSC_Firing_Positions", 2)
        hsc.aiState(2, "Sentinels_Firing_Positions", 2)
        hsc.aiState(2, "Flood_Firing_Positions", 2)
        theyChill = false
    end
end

function test.AiCheck()
    local marine_living_count = hsc.aiLivingCount("UNSC_Firing_Positions", "marine_living_count")
    local sentinel_living_count = hsc.aiLivingCount("Sentinels_Firing_Positions", "sentinel_living_count")
    local flood_living_count = hsc.aiLivingCount("Flood_Firing_Positions", "flood_living_count")
    local covenant_living_count = hsc.aiLivingCount("Covenant_Firing_Positions", "covenant_living_count")

      if (marine_living_count <= 2) then
        hsc.aiSpawn(1, "UNSC_Firing_Positions")
      end
      if (sentinel_living_count <= 4) then
        hsc.aiSpawn(1, "Sentinels_Firing_Positions")
      end
      if (flood_living_count <= 8) then
        hsc.aiSpawn(1, "Flood_Firing_Positions")
      end
      if (covenant_living_count <= 5) then
        hsc.aiSpawn(1, "Covenant_Firing_Positions")
      end

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