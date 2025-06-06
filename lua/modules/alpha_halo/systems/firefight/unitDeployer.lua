-- 📁 modules/project_modules/systems/firefight/manager.lua
local balltze = Balltze
local engine = Engine
local eventsManager = require "alpha_halo.systems.firefight.events"
local announcer = require "alpha_halo.systems.combat.announcer"
local script = require "script"
local hsc = require "hsc"

local unitDeployer = {}

Deployer = {
    dropshipsAsigned = 3,
    dropshipsLeft = 0,
    randomDropship = 1,
    dropshipTemplate = "dropship_%s_%s",
}

local selectedDropship = Deployer.dropshipTemplate:format(Deployer.dropshipsLeft, Deployer.randomDropship)


---@Test Test function to deploy a wave
function unitDeployer.enemySpawner(call, sleep)
    hsc.garbage_collect_now()
    hsc.object_create_anew("dropship_1_1")
    hsc.vehicle_hover("dropship_1_1", true)
    --Deployer.dropshipsLeft = math.random(1, Deployer.dropshipsAsigned)
    --local randomTeamIndex = math.random(1)
    --local dropshipGunnerFormat = "Enemy_Team_%s/Spirit_Gunner"
    --local selectedDropshipGunner = dropshipGunnerFormat:format(randomTeamIndex)
    hsc.ai_place("Enemy_Team_1/Spirit_Gunner")
    hsc.vehicle_load_magic("dropship_1_1", "gunseat", hsc.ai_actors("Enemy_Team_1/Spirit_Gunner"))
    hsc.ai_migrate("Enemy_Team_1/Spirit_Gunner", "Covenant_Support")

    hsc.ai_place("test_encounter/test_squad")
    hsc.vehicle_load_magic("dropship_1_1", "passenger", hsc.ai_actors("test_encounter/test_squad"))
    hsc.custom_animation("dropship_1_1", "alpha_firefight\\vehicles\\c_dropship\\drop_enemies\\dropship_enemies", "dropship_2_1", false)
    hsc.ai_migrate("test_encounter/test_squad", "Covenant_Wave")
    sleep(700)
    hsc.ai_exit_vehicle("Covenant_Wave")
    --sleep(1200)
    --hsc.object_destroy_containing("dropship")
end

function unitDeployer.pelicanDeployer(call, sleep)
    hsc.garbage_collect_now()
    sleep(700)
    hsc.ai_place("Human_Team/ODSTs")
    hsc.ai_place("human_support/pelican_pilot")
    hsc.object_create_anew("foehammer_cliff")
    hsc.vehicle_load_magic("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs"))
    hsc.vehicle_load_magic("foehammer_cliff", "driver", hsc.ai_actors("human_support/pelican_pilot"))
    hsc.ai_magically_see_encounter("human_support", "Covenant_Wave")
    --sleep(30)
    hsc.unit_set_enterable_by_player("foehammer_cliff", false)
    hsc.unit_close("foehammer_cliff")
    hsc.object_teleport("foehammer_cliff", "foehammer_cliff_flag")
    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), true)
    hsc.recording_play_and_hover( "foehammer_cliff", "foehammer_cliff_in")
    sleep(1200)
    hsc.unit_open("foehammer_cliff")
    sleep(90)
    hsc.ai_braindead_by_unit(hsc.ai_actors("Human_Team"), false)
    hsc.vehicle_unload("foehammer_cliff", "rider")
    sleep(120)
    if not hsc.vehicle_test_seat_list("foehammer_cliff", "rider", hsc.ai_actors("Human_Team/ODSTs")) then
        hsc.unit_close("foehammer_cliff")
        sleep(120)
        hsc.vehicle_hover("foehammer_cliff", false)
        hsc.recording_play_and_delete("foehammer_cliff", "foehammer_cliff_out")
    end
end

return unitDeployer
