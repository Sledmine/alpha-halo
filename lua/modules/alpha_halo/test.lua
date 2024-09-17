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
        hsc.aiState(2, "Covenant_Firing_Positions/platoon_a", 1)
        hsc.aiState(2, "UNSC_Firing_Positions/platoon_a", 1)
        hsc.aiState(2, "Sentinels_Firing_Positions/platoon_a", 1)
        hsc.aiState(2, "Flood_Firing_Positions/platoon_a", 1)
        hsc.aiState(2, "Covenant_Banshee/Covenant_Banshee", 1)
        theyChill = true
        console_out("STOOOOP FIGHTIIIIIIIING!!!")
    elseif (theyChill == true) then
        hsc.aiState(2, "Covenant_Firing_Positions/platoon_a", 2)
        hsc.aiState(2, "UNSC_Firing_Positions/platoon_a", 2)
        hsc.aiState(2, "Sentinels_Firing_Positions/platoon_a", 2)
        hsc.aiState(2, "Flood_Firing_Positions/platoon_a", 2)
        hsc.aiState(2, "Covenant_Banshee/Covenant_Banshee", 2)
        theyChill = false
    end
end

function test.AiCheck()
    local marine_living_count = hsc.aiLivingCount("UNSC_Firing_Positions/platoon_a", "marine_living_count")
    local sentinel_living_count = hsc.aiLivingCount("Sentinels_Firing_Positions/platoon_a", "sentinel_living_count")
    local flood_living_count = hsc.aiLivingCount("Flood_Firing_Positions/platoon_a", "flood_living_count")
    local covenant_living_count = hsc.aiLivingCount("Covenant_Firing_Positions/platoon_a", "covenant_living_count")

      if (marine_living_count <= 2) then
        hsc.aiSpawn(1, "UNSC_Firing_Positions/platoon_a")
      end
      if (sentinel_living_count <= 4) then
        hsc.aiSpawn(1, "Sentinels_Firing_Positions/platoon_a")
      end
      if (flood_living_count <= 8) then
        hsc.aiSpawn(1, "Flood_Firing_Positions/platoon_a")
      end
      if (covenant_living_count <= 5) then
        hsc.aiSpawn(1, "Covenant_Firing_Positions/platoon_a")
      end

      hsc.aiMagicallySee(1, "Covenant_Firing_Positions/platoon_a", "players")
      hsc.aiMagicallySee(1, "UNSC_Firing_Positions/platoon_a", "players")
      hsc.aiMagicallySee(1, "Sentinels_Firing_Positions/platoon_a", "players")
      hsc.aiMagicallySee(1, "Flood_Firing_Positions/platoon_a", "players")

      hsc.aiAction(1, "Covenant_Firing_Positions/platoon_a")
      hsc.aiAction(1, "UNSC_Firing_Positions/platoon_a")
      hsc.aiAction(1, "Sentinels_Firing_Positions/platoon_a")
      hsc.aiAction(1, "Flood_Firing_Positions/platoon_a")
end

return test