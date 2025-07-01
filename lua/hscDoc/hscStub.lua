---@meta _
---@diagnostic disable: missing-return 
---@diagnostic disable: unused-local 
---@class hsc
hsc = {}

-----@param arg1 expressions
-----@return passthrough
-- function hsc.begin_random() end

-----@param arg1 boolean
-----@param arg2 then
-----@param arg3 else
-----@return passthrough
-- function hsc.if() end

-----@param arg1 boolean1
-----@param arg2 result1
-----@param arg3 boolean2
-----@param arg4 result2
-----@param arg5 ...
-----@return passthrough
-- function hsc.cond() end

------@param arg1 variable
------@param arg2 name
------@param arg3 expression
------@return passthrough
---function hsc.set()
---end

-----@param arg1 booleans
-----@return boolean
-- function hsc.and() end

-----@param arg1 booleans
-----@return boolean
-- function hsc.or() end

-----@param arg1 numbers
-----@return real
-- function hsc.min() end
--
-----@param arg1 numbers
-----@return real
-- function hsc.max() end
--
-----@param arg1 short
-----@param arg2 script
-- function hsc.sleep() end
--
-----@param arg1 boolean
-----@param arg2 short
-- function hsc.sleep_until() end
--
-----@param arg1 script
-----@param arg2 name
-- function hsc.wake() end
--
-----@param arg1 expression
-- function hsc.inspect() end

---Converts an object to a unit.
---@param unitObject object
---@return unit
function hsc.unit(unitObject)
end

---Suppresses (or stops suppressing) a set of AI communication types.
---@param arg1 strings -- <string(s)> ??
function hsc.ai_debug_communication_suppress(arg1)
end

---Ignores (or stops ignoring) a set of AI communication types when printing out communications.
---@param arg1 strings -- <string(s)> ??
function hsc.ai_debug_communication_ignore(arg1)
end

---Focuses (or stops focusing) a set of unit vocalization types.
---@param arg1 strings -- <string(s)> ??
function hsc.ai_debug_communication_focus(arg1)
end

-----@param arg1 boolean
-----@return boolean
-- function hsc.not() end

-----@param arg1 real
-----@param arg2 real
-----@param arg3 real
-----@return real
-- function hsc.pin() end
--
-----@param arg1 long
-----@return long
-- function hsc.abs_integer() end
--
-----@param arg1 real
-----@return real
-- function hsc.abs_real() end
--
-----@param arg1 long
-----@param arg2 long
-----@return long
-- function hsc.bitwise_and() end
--
-----@param arg1 long
-----@param arg2 long
-----@return long
-- function hsc.bitwise_or() end
--
-----@param arg1 long
-----@param arg2 long
-----@return long
-- function hsc.bitwise_xor() end
--
-----@param arg1 long
-----@param arg2 short
-----@return long
-- function hsc.bitwise_left_shift() end
--
-----@param arg1 long
-----@param arg2 short
-----@return long
-- function hsc.bitwise_right_shift() end
--
-----@param arg1 long
-----@param arg2 short
-----@return long
-- function hsc.bit_test() end
--
-----@param arg1 long
-----@param arg2 short
-----@param arg3 boolean
-----@return long
-- function hsc.bit_toggle() end

-----@param arg1 long
-----@param arg2 long
-----@param arg3 boolean
-----@return long
-- function hsc.bitwise_flags_toggle() end

-----@param arg1 string
-- function hsc.print() end

-----@param arg1 boolean
-----@param arg2 string
-- function hsc.print_if() end

-----@param arg1 string
-- function hsc.log_print() end

---@return object_list
function hsc.local_players()
end

---Returns a list of the living player units on the local machine
---@return object_list
function hsc.players()
end

---Returns a list of the living player units on the MP team
---@param team 0 | 1 Player team
---@return object_list
function hsc.players_on_multiplayer_team(team)
end

---Teleport all players that are not inside a given volume trigger to a specified flag
---@param triggerVolume trigger_volume Volume name used to check for players
---@param cutsceneFlag cutscene_flag Flag where players will get teleported to
function hsc.volume_teleport_players_not_inside(triggerVolume, cutsceneFlag)
end

---Returns true if the specified object is within the specified volume.
---@param triggerVolume trigger_volume Volume name to check
---@param objectName object Object to test against the given volume
---@return boolean
function hsc.volume_test_object(triggerVolume, objectName)
end

---Returns true if any of the specified objects are within the specified volume.
---@param triggerVolume trigger_volume Volume name to check
---@param objectList object_list List of objects to test against the given volume
---@return boolean
function hsc.volume_test_objects(triggerVolume, objectList)
end

---Returns true if any of the specified objects are within the specified volume.
---@param triggerVolume trigger_volume Volume name to check
---@param objectList object_list List of objects to test against the given volume
---@return boolean
function hsc.volume_test_objects_all(triggerVolume, objectList)
end

---Moves the specified object to the specified flag.
---@param objectName object Name of the object to move
---@param flagName cutscene_flag Name of the flag to move the object to
---Example: hsc.object_teleport("keyesa10", "keyes_pistol_basea10")  
function hsc.object_teleport(objectName, flagName)
end

---Turns the specified object in the direction of the specified flag.
---@param objectName object Name of the object to turn
---@param flagName cutscene_flag Name of the flag to turn the object towards
function hsc.object_set_facing(objectName, flagName)
end

---Sets the shield vitality of the specified object (between 0 and 1).
---@param objectName object Name of the object to set the shield vitality for
---@param shieldVitality real Shield vitality value between 0 and 1
function hsc.object_set_shield(objectName, shieldVitality)
end

---Sets the desired region (use "" for all regions) to the permutation with the given name.
---@param objectName object Name of the object to set the permutation for
---@param modelRegion string Name of the model region
---@param modelPermutation string Name of the model permutation
---Example: object_set_permutation("flood", "right arm", "~damaged")
function hsc.object_set_permutation(objectName, modelRegion, modelPermutation)
end

-- Creates an object from the scenario.
---@param string object_name Name of the object on "object names" (a block in the scenario tag).
-- Example: hsc.object_create("rock_2")
function hsc.object_create(string)
end

---Destroys an object by given name.
---@param objectName object_name Name of the object on "object names" (a block in the scenario tag).
---Example: hsc.object_destroy("door_1")
function hsc.object_destroy(objectName)
end

---Creates an object, destroying it first if it already exists.
---@param objectName object_name Name of the object on "object names" (a block in the scenario tag).
---Example: hsc.object_create("tree_1")
function hsc.object_create_anew(objectName)
end

---Creates all objects from the scenario whose names contain the given substring.
---@param objectName object_name Name of the object on "object names" (a block in the scenario tag).
---Example: hsc.object_create_anew_containing("trees_")
function hsc.object_create_containing(objectName)
end

---Creates anew all objects from the scenario whose names contain the given substring.
---@param objectName object_name Name of the object on "object names" (a block in the scenario tag).
---Example: hsc.object_create_anew_containing("trees_")
function hsc.object_create_anew_containing(objectName)
end

---Destroys all objects from the scenario whose names contain the given substring.
---@param objectName object_name Name of the object on "object names" (a block in the scenario tag).
---Example: hsc.object_create_anew_containing("rocks_")
function hsc.object_destroy_containing(objectName)
end

---Destroys all non player objects.
function hsc.object_destroy_all()
end

---Deletes all objects of type <definition>
---@param objDefinition object_definition
function hsc.objects_delete_by_definition(objDefinition)
end

---Returns an item in an object list.
---@param objectList object_list
---@param countValue short
---@return object
function hsc.list_get(objectList, countValue)
end

---Returns the number of objects in a list
---@param objectList object_list
---@return short
function hsc.list_count(objectList)
end

-----@param arg1 object_list
-----@return short
-- function hsc.list_count_not_dead() end

---Starts the specified effect at the specified flag.
---@param effectPath effect Path to the effect file (e.g., "effects\\\explosion\\\explosion")
---@param flagName cutscene_flag Name of the cutscene flag where the effect will be started
---Example: hsc.effect_new("effects\\\explosion\\\explosion", "boom_flag_7")
function hsc.effect_new(effectPath, flagName)
end

---Starts the specified effect on the specified object at the specified object marker.
---@param effectPath effect Path to the effect file
---@param objectName object Name of the object where the effect will be started
---@param markerName string Name of the marker on the object where the effect will be started
---Example: hsc.effect_new_on_object_marker("cinematics\\\effects\\\cyborg chip insertion", "chief", "left hand")
function hsc.effect_new_on_object_marker(effectPath, objectName, markerName)
end

---Causes the specified damage at the specified flag.
---@param damagePath damage Path to the damage effect tag
---@param flagName cutscene_flag Name of the cutscene flag where the damage will be applied
---Example hsc.damage_new("levels\\\a10\\\devices\\\shield charge\\\zapper" tutorial_zapper_flag)
function hsc.damage_new(damagePath, flagName)
end

---Causes the specified damage at the specified object.
---@param damagePath damage Path to the damage effect tag
---@param objectName object Name of the object where the damage will be applied
---Example hsc.damage_object("effects\\\damage effects\\\pulsegenerator" (player1))
function hsc.damage_object(damagePath, objectName)
end

---Returns true if any of the specified units are looking within the specified number of degrees of the object.
---@param objectList object_list List of objects to check
---@param objectName object Name of the object to check against
---@param degrees real Number of degrees to check for visibility
---@return boolean
---Example: hsc.objects_can_see_object("players", "first_contact_door_3", 25)
function hsc.objects_can_see_object(objectList, objectName, degrees)
end

---Returns true if any of the specified units are looking within the specified number of degrees of the flag.
---@param objectList object_list List of objects to check
---@param flagName cutscene_flag Name of the cutscene flag to check against
---@param degrees real Number of degrees to check for visibility
---@return boolean
---Example: hsc.objects_can_see_flag("players", "blam_burn_flag_3", 30)
function hsc.objects_can_see_flag(objectList, flagName, degrees)
end

---Not implemented yet.
-----@param arg1 object_list
-----@param arg2 object
-----@return real
-- function hsc.objects_distance_to_object() end

---Not implemented yet.
-----@param arg1 object_list
-----@param arg2 cutscene_flag
-----@return real
-- function hsc.objects_distance_to_flag() end

---Absolutely do not use this.
-----@param arg1 string
-----@param arg2 real
--function hsc.sound_set_gain()
--end

---Absolutely do not use this either.
-----@param arg1 string
-----@return real
--function hsc.sound_get_gain()
--end

---Recompiles scripts.
function hsc.script_recompile()
end

---Saves a file called hs_doc.txt with parameters for all script commands.
function hsc.script_doc()
end

---Prints a description of the named function.
---@param functionNAme string Name of the function to get help for
---Example: hsc.help("hsc.object_create")
function hsc.help(functionNAme)
end

---Returns a random value in the range [lower bound, upper bound)
---@param lowerBound short The lower bound of the range (inclusive)
---@param upperBound short The upper bound of the range (exclusive)
---@return short
---Example: hsc.random_range(1, 10) -- Returns a random number between 1 and 9
function hsc.random_range(lowerBound, upperBound)
end

--- Returns a random value in the range [lower bound, upper bound)
---@param lowerBound real The lower bound of the range (inclusive)
---@param upperBound real The upper bound of the range (exclusive)
---@return real
---Example: hsc.real_random_range(1.0, 10.0) -- Returns a random number between 1.0 and 9.999...
function hsc.real_random_range(lowerBound, upperBound)
end

-- function hsc.physics_constants_reset() end

-----@param arg1 real
-- function hsc.physics_set_gravity() end

-----@return real
-- function hsc.physics_get_gravity() end

---Set a numeric countdown timer.
---@param miliseconds long The duration of the countdown timer in milliseconds
---@param autoStart boolean If true, the timer starts immediately; if false, it must be started manually later
---Example: hsc.numeric_countdown_timer_set(60000, true) -- Sets a countdown timer for 60 seconds that starts immediately
function hsc.numeric_countdown_timer_set(miliseconds, autoStart)
end

---Gets the current value of a numeric countdown timer.
---@param digitIndex short The index of the digit to retrieve (0 for the first digit, 1 for the second, etc.)
---@return short
---Example: hsc.numeric_countdown_timer_get(0) -- Gets the current value of the first digit of the countdown timer.
function hsc.numeric_countdown_timer_get(digitIndex)
end

---Stops the numeric countdown timer.
function hsc.numeric_countdown_timer_stop()
end

---Resets the numeric countdown timer to its initial value.
function hsc.numeric_countdown_timer_restart()
end

---Enables or disables breakability of all breakable surfaces on level.
---@param isEnabled boolean True to enable breakability, false to disable
function hsc.breakable_surfaces_enable(isEnabled)
end

---@param arg1 unit
---@param arg2 cutscene_recording
---@return boolean
function hsc.recording_play()
end

---make the specified unit run the specified cutscene recording, deletes the unit when the animation finishes.
---@param unitName unit Name of a unit in "name objects" scenario tag block.
---@param recAnimsName cutscene_recording Name of a cutscene recording in "Recorded Animations" scenario tag block.
---@return boolean
---Example: hsc.recording_play_and_delete("foehammer_cliff", "foehammer_cliff_in")
function hsc.recording_play_and_delete(unitName, recAnimsName)
end

---Make the specified vehicle run the specified cutscene recording, hovers the vehicle when the animation finishes.
---@param vehicleName vehicle Name of a vehicle in "name objects" scenario tag block.
---@param recAnimsName cutscene_recording Name of a cutscene recording in "Recorded Animations" scenario tag block.
---@return boolean
---Example: hsc.recording_play_and_hover("foehammer_cliff", "foehammer_cliff_in")
function hsc.recording_play_and_hover(vehicleName, recAnimsName)
end

---@param arg1 unit
function hsc.recording_kill()
end

---@param arg1 unit
---@return short
function hsc.recording_time()
end

---@param arg1 object
---@param arg2 boolean
function hsc.object_set_ranged_attack_inhibited()
end

---@param arg1 object
---@param arg2 boolean
function hsc.object_set_melee_attack_inhibited()
end

function hsc.objects_dump_memory()
end

---@param arg1 object
---@param arg2 boolean
function hsc.object_set_collideable()
end

---@param arg1 object
---@param arg2 real
---@param arg3 short
function hsc.object_set_scale()
end

---@param arg1 object
---@param arg2 string
---@param arg3 object
---@param arg4 string
function hsc.objects_attach()
end

---@param arg1 object
---@param arg2 object
function hsc.objects_detach()
end

---Causes all garbage objects except those visible to a player to be collected immediately.
function hsc.garbage_collect_now()
end

---Prevents an object from taking damage.
---@param objectList object_list -- A list of objects (e.g., "players", "enemies", "allies") to prevent from taking damage.
---Example: hsc.object_cannot_take_damage("players") -- Prevents all players from taking damage.
function hsc.object_cannot_take_damage(objectList)
end

---@param arg1 object_list
function hsc.object_can_take_damage()
end

---@param arg1 object
---@param arg2 boolean
function hsc.object_beautify()
end

---@param arg1 object_list
function hsc.objects_predict()
end

---@param arg1 object_definition
function hsc.object_type_predict()
end

---@param arg1 object
function hsc.object_pvs_activate()
end

---@param arg1 object
function hsc.object_pvs_set_object()
end

---@param arg1 cutscene_camera_point
function hsc.object_pvs_set_camera()
end

function hsc.object_pvs_clear()
end

---@param arg1 boolean
---@return boolean
function hsc.render_lights()
end

---@param arg1 scenery
---@return short
function hsc.scenery_get_animation_time()
end

---@param arg1 scenery
---@param arg2 animation_graph
---@param arg3 string
function hsc.scenery_animation_start()
end

---@param arg1 scenery
---@param arg2 animation_graph
---@param arg3 string
---@param arg4 short
function hsc.scenery_animation_start_at_frame()
end

---@param arg1 boolean
function hsc.render_effects()
end

---@param arg1 unit
---@param arg2 boolean
function hsc.unit_can_blink()
end

---Opens the hatches on the given unit.
---@param unitName unit
---Example: hsc.unit_open("pelican_2") -- Opens the hatches on the unit named "pelican_2".
function hsc.unit_open(unitName)
end

---Closes the hatches on a given unit.
---@param unitName unit
---Example: hsc.unit_close("pelican_2") -- Closes the hatches on the unit named "pelican_2".
function hsc.unit_close(unitName)
end

---@param arg1 unit
function hsc.unit_kill()
end

---@param arg1 unit
function hsc.unit_kill_silent()
end

---@param arg1 unit
---@return short
function hsc.unit_get_custom_animation_time()
end

---@param arg1 unit
function hsc.unit_stop_custom_animation()
end

---@param arg1 unit
---@param arg2 animation_graph
---@param arg3 string
---@param arg4 boolean
---@param arg5 short
---@return boolean
function hsc.unit_custom_animation_at_frame()
end

---Starts a custom animation playing on a unit (interpolates into animation if last parameter is TRUE).
---@param unitName unit -- Name of a unit in "name objects" scenario tag block.
---@param animPath animation_graph -- Path to the animation tag
---@param animationName string -- Name of the animation to play inside animation tag (e.g., "walk")
---@param interpolate boolean -- If true, the animation will interpolate from the current state to the new animation; if false, it will snap to the new animation immediately.
---@return boolean
---Example: hsc.custom_animation("marine_1", "characters\\\marine\\\marine", "walk", true)
function hsc.custom_animation(unitName, animPath, animationName, interpolate)
end

---Starts a custom animation playing on a unit list (interpolates into animation if last parameter is TRUE).
---@param objectList object_list A list of objects (units) to play the animation on.
---@param animPath animation_graph Path to the animation tag
---@param animationName string Name of the animation to play inside animation tag
---@param interpolate boolean
---@return boolean
---Example: hsc.custom_animation_list("players", "characters\\\cinematic\\\stage2", "battle", false)
function hsc.custom_animation_list(objectList, animPath, animationName, interpolate)
end

---Returns TRUE if the given unit is still playing a custom animation
---@param unitName unit
---@return boolean
---Example: hsc.unit_is_playing_custom_animation("cyborg")
function hsc.unit_is_playing_custom_animation(unitName)
end

---Allows a unit to aim in place without turning.
---@param unitName unit
---@param isEnabled boolean
function hsc.unit_aim_without_turning(unitName, isEnabled)
end

---Sets a unit's facial expression (-1 is none, other values depend on unit).
---@param unitName unit Name of a unit in scenario tag.
---@param facialExpIndex short Index of the facial expression to set (0-6 for most units, 0-5 for some).
---Example: hsc.unit_set_emotion("cortana", 6) -- Sets Cortana's facial expression to index 6.
function hsc.unit_set_emotion(unitName, facialExpIndex)
end

---Can be used to prevent the player from entering a vehicle
---@param unitName unit Name of a unit in scenario tag.
---@param isEnterable boolean True to allow the player to enter the vehicle, false to prevent it.
function hsc.unit_set_enterable_by_player(unitName, isEnterable)
end

---@param unitName unit
---@param vehicleName vehicle
---@param seatName string
function hsc.unit_enter_vehicle(unitName, vehicleName, seatName)
end

---Tests whether the named seat has an object in the object list
---@param vehicleName vehicle
---@param seatName string
---@param objectList object_list
---@return boolean
function hsc.vehicle_test_seat_list(vehicleName, seatName, objectList)
end

---@param arg1 vehicle
---@param arg2 string
---@param arg3 unit
---@return boolean
function hsc.vehicle_test_seat()
end

---@param arg1 unit
---@param arg2 string
function hsc.unit_set_emotion_animation()
end

---@param unitName unit
function hsc.unit_exit_vehicle(unitName)
end

---@param arg1 unit
---@param arg2 real
---@param arg3 real
function hsc.unit_set_maximum_vitality()
end

---@param arg1 object_list
---@param arg2 real
---@param arg3 real
function hsc.units_set_maximum_vitality()
end

---@param arg1 unit
---@param arg2 real
---@param arg3 real
function hsc.unit_set_current_vitality()
end

---@param arg1 object_list
---@param arg2 real
---@param arg3 real
function hsc.units_set_current_vitality()
end

---Makes a list of units (named or by encounter) magically get into a vehicle, in the substring-specified seats.
---@param unitName unit Name of a unit in scenario tag.
---@param seatName string Name of the seat in the vehicle. Use "" to match all seats.
---@param objectList object_list A list of objects (units) to load into the vehicle.
---@return short
---Example1: hsc.vehicle_load_magic("dropship", "CD-passenger", "players") | 
---Example2: hsc.vehicle_load_magic("pelican_2", "P-passenger", hsc.ai_actors("pelican_2/pelican_2_troopers"))
function hsc.vehicle_load_magic(unitName, seatName, objectList)
end

---Makes units get out of a vehicle from the substring-specified seats (e.g. CD-passenger... empty string matches all seats)
---@param unitName unit Name of a unit in scenario tag.
---@param seatName string Name of the seat in the vehicle. Use "" to match all seats.
---@return short
---Example: hsc.vehicle_unload("passenger") | hsc.vehicle_unload("")
function hsc.vehicle_unload(unitName, seatName)
end

---@param seatName string 
function hsc.magic_seat_name(seatName)
end

---@param arg1 unit @Name of a unit in scenario tag.
---@param arg2 string
function hsc.unit_set_seat()
end

function hsc.magic_melee_attack()
end

-- Returns a list of all riders in a vehicle.
---@param unitName unit @Name of a unit in scenario tag.
---@return object_list vehicle_riders
-- Example: hsc.vehicle_riders("pelican_3")
function hsc.vehicle_riders(unitName)
end

---@param arg1 unit
---@return unit
function hsc.vehicle_driver()
end

---@param arg1 unit
---@return unit
function hsc.vehicle_gunner()
end

---@param arg1 unit
---@return real
function hsc.unit_get_health()
end

---@param arg1 unit
---@return real
function hsc.unit_get_shield()
end

---@param arg1 unit
---@return short
function hsc.unit_get_total_grenade_count()
end

---@param arg1 unit
---@param arg2 object_definition
---@return boolean
function hsc.unit_has_weapon()
end

---@param arg1 unit
---@param arg2 object_definition
---@return boolean
function hsc.unit_has_weapon_readied()
end

---@param arg1 object_list
function hsc.unit_doesnt_drop_items()
end

---@param arg1 object_list
---@param arg2 boolean
function hsc.unit_impervious()
end

---@param arg1 unit
---@param arg2 boolean
function hsc.unit_suspended()
end

---@return boolean
function hsc.unit_solo_player_integrated_night_vision_is_active()
end

---@param arg1 object_list
---@param arg2 boolean
function hsc.units_set_desired_flashlight_state()
end

---@param arg1 unit
---@param arg2 boolean
function hsc.unit_set_desired_flashlight_state()
end

---@param arg1 unit
---@return boolean
function hsc.unit_get_current_flashlight_state()
end

---@param arg1 device
---@param arg2 boolean
function hsc.device_set_never_appears_locked()
end

---@param arg1 device
---@return real
function hsc.device_get_power()
end

---@param arg1 device
---@param arg2 real
function hsc.device_set_power()
end

---@param arg1 device
---@param arg2 real
---@return boolean
function hsc.device_set_position()
end

---@param arg1 device
---@return real
function hsc.device_get_position()
end

---@param arg1 device
---@param arg2 real
function hsc.device_set_position_immediate()
end

---@param arg1 device_group
---@return real
function hsc.device_group_get()
end

---@param arg1 device_group
---@param arg2 real
---@return boolean
function hsc.device_group_set()
end

---@param arg1 device_group
---@param arg2 real
function hsc.device_group_set_immediate()
end

---@param arg1 device
---@param arg2 boolean
function hsc.device_one_sided_set()
end

---@param arg1 device
---@param arg2 boolean
function hsc.device_operates_automatically_set()
end

---@param arg1 device_group
---@param arg2 boolean
function hsc.device_group_change_only_once_more_set()
end

function hsc.breakable_surfaces_reset()
end

function hsc.cheat_all_powerups()
end

function hsc.cheat_all_weapons()
end

function hsc.cheat_spawn_warthog()
end

function hsc.cheat_all_vehicles()
end

function hsc.cheat_teleport_to_camera()
end

function hsc.cheat_active_camouflage()
end

---@param arg1 short
function hsc.cheat_active_camouflage_local_player()
end

function hsc.cheats_load()
end

-- Removes a group of actors from their encounter and sets them free
---@param encounterName ai
function hsc.ai_free(encounterName)
end

---Removes a set of units from their encounter (if any) and sets them free
---@param objectList object_list An object list | After choose one, concatenate the target name in each case.
---@return nil
---@see hsc.vehicle_riders Go to reference
---@see hsc.ai_actors Go to reference
---Example 1: hsc.ai_free_units("vehicle_riders jeep") | Example 2: hsc.ai_free_units("ai_actors first_wave/wave_2_lz_toon")
function hsc.ai_free_units(objectList)
end

-- Attaches the specified unit to the specified encounter.
---@param unitName unit @Name of a unit in the scenario.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_attach("marine_1", "control_room/marines2")
function hsc.ai_attach(unitName, encounterName)
end

-- Attaches a unit to a newly created free actor of the specified type.
---@param unitName unit @Name of a unit in the scenario.
---@param tagPath actor_variant Actor Variant Tag Path
---@return nil
-- Example: hsc.ai_attach_free("bridge_sentinel_3", "characters\monitor\monitor")
function hsc.ai_attach_free(unitName, tagPath)
end

-- Detaches the specified unit from all AI.
---@param unitName unit
---@return nil
-- Example: hsc.ai_detach("marine_1")
function hsc.ai_detach(unitName)
end

-- Places the specified encounter and/or squad on the map.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_place("rocks/elites_2")
function hsc.ai_place(encounterName)
end

-- Instantly kills the specified encounter and/or squad.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_kill("woods/grunts1")
function hsc.ai_kill(encounterName)
end

-- Instantly kills the specified encounter and/or squad without any sound and death animation.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_kill_silent("woods/grunts1")
function hsc.ai_kill_silent(encounterName)
end

-- Erases the specified encounter and/or squad.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_erase("myEncounter/mySquad")
function hsc.ai_erase(encounterName)
end

-- Erases all AI.
---@return nil
function hsc.ai_erase_all()
end

-- Selects the specified encounter.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_select("control_room/marines2")
function hsc.ai_select(encounterName)
end

-- function hsc.ai_deselect() end

-- Spawns an actor in the specified encounter and/or squad.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_spawn_actor("enc2_7/leapers")
function hsc.ai_spawn_actor(encounterName)
end

-- Enables or disables respawning in the specified encounter.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param isEnabled boolean True to enable respawning, false to disable.
-- Example: hsc.ai_set_respawn("encounter_name/squad_name", true)
function hsc.ai_set_respawn(encounterName, isEnabled)
end

-- Enables or disables hearing for actors in the specified encounter.
---@param encountrName ai An "Encounters" name value (a block in the scenario tag).
---@param bool boolean @True to enable hearing, false to disable.
---@return nil
-- Example: hsc.ai_set_deaf("encounter_name/squad_name", false)
function hsc.ai_set_deaf(encountrName, bool)
end

-- Enables or disables sight for actors in the specified encounter.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param bool boolean @True to enable sight, false to disable.
---@return nil
-- Example: hsc.ai_set_blind("encounter_name/squad_name", true)
function hsc.ai_set_blind(encounterName, bool)
end

-- Makes encounter 1 magically aware of encounter 2.
---@param encounter1 ai An "Encounters" name value (a block in the scenario tag).
---@param encounter2 ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_magically_see_encounter("first_marine", "first_wave")
function hsc.ai_magically_see_encounter(encounter1, encounter2)
end

-- Makes an encounter magically aware of nearby players.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_magically_see_players("jackals_lz")
function hsc.ai_magically_see_players(encounterName)
end

-- Makes an encounter magically aware of the specified unit.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param unitName unit A "Unit" name from the scenario.
---@return nil
-- Example: hsc.ai_magically_see_unit("control_room/elites_2", "marines_support")
function hsc.ai_magically_see_unit(encounterName, unitName)
end

---@param arg1 ai
function hsc.ai_timer_start()
end

---@param arg1 ai
function hsc.ai_timer_expire()
end

---@param arg1 ai
function hsc.ai_attack()
end

---@param arg1 ai
function hsc.ai_defend()
end

---@param arg1 ai
function hsc.ai_retreat()
end

---@param arg1 ai
function hsc.ai_maneuver()
end

---@param arg1 ai
---@param arg2 boolean
function hsc.ai_maneuver_enable()
end

-- Makes a named vehicle or group of units move from one encounter to another.
---@param encounter1 ai An "Encounters" name value (a block in the scenario tag).
---@param encounter2 ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_migrate(airlock_1/main airlock_1/advance). | Note: *Also you can type just the encounter name and migrate all inside it.
function hsc.ai_migrate(encounter1, encounter2)
end

---@param arg1 ai
---@param arg2 ai
---@param arg3 string
function hsc.ai_migrate_and_speak()
end

---@param arg1 object_list
---@param arg2 ai
function hsc.ai_migrate_by_unit()
end

---@param arg1 team
---@param arg2 team
function hsc.ai_allegiance()
end

---@param arg1 team
---@param arg2 team
function hsc.ai_allegiance_remove()
end

-- Return the number of living actors in the specified encounter and/or squad.
---@param string ai An "Encounters" value (a block in the scenario tag)
---@return short
---@see using_ai_living_count Ussage example in context
-- Example: hsc.ai_living_count("first_marine")
function hsc.ai_living_count(string)
end

---@param arg1 ai
---@return real
function hsc.ai_living_fraction()
end

---@param arg1 ai
---@return real
function hsc.ai_strength()
end

---@param arg1 ai
---@return short
function hsc.ai_swarm_count()
end

---@param arg1 ai
---@return short
function hsc.ai_nonswarm_count()
end

-- Converts an encounter and/or squad reference to an object list.
---@param encounter ai An "Encounters" name value (a block in the scenario tag)
---@return object_list ai_actors
-- Example: hsc.ai_actors("ext_c_cov/ghost_a")
function hsc.ai_actors(encounter)
end

---@param arg1 ai
---@param arg2 unit
---@param arg3 string
function hsc.ai_go_to_vehicle()
end

---@param arg1 ai
---@param arg2 unit
---@param arg3 string
function hsc.ai_go_to_vehicle_override()
end

---@param arg1 unit
---@return short
function hsc.ai_going_to_vehicle()
end

-- Tells a group of actors from encounter/squad? to get out of any vehicles that they are in. 
---@param encounterName ai @Name of the encounter and/or squad, such as "ext_c_cov/ghost_a"
-- Example: hsc.ai_exit_vehicle("ext_c_cov/ghost_a ") | hsc.ai_exit_vehicle("ext_c_cov")
function hsc.ai_exit_vehicle(encounterName)
end

---@param encounterName ai
---@param boolean boolean
function hsc.ai_braindead(encounterName, boolean)
end

---makes a list of objects braindead, or restores them to life. if you pass in a vehicle index, it makes all actors in that vehicle braindead (including any built-in guns).
---@param objectList object_list
---@param isBraindead boolean
---Example: hsc.ai_braindead_by_unit("encounter", true) -- Makes encounter braindead.
function hsc.ai_braindead_by_unit(objectList, isBraindead)
end

---@param arg1 object_list
---@param arg2 boolean
function hsc.ai_disregard()
end

---@param arg1 object_list
---@param arg2 boolean
function hsc.ai_prefer_target()
end

---@param arg1 ai
function hsc.ai_teleport_to_starting_location()
end

---@param arg1 ai
function hsc.ai_teleport_to_starting_location_if_unsupported()
end

---@param arg1 ai
function hsc.ai_renew()
end

---@param arg1 ai
function hsc.ai_try_to_fight_nothing()
end

---@param arg1 ai
---@param arg2 ai
function hsc.ai_try_to_fight()
end

---@param arg1 ai
function hsc.ai_try_to_fight_player()
end

---@param arg1 ai
---@param arg2 ai_command_list
function hsc.ai_command_list()
end

---@param arg1 unit
---@param arg2 ai_command_list
function hsc.ai_command_list_by_unit()
end

---@param arg1 ai
function hsc.ai_command_list_advance()
end

---@param arg1 unit
function hsc.ai_command_list_advance_by_unit()
end

---@param arg1 object_list
---@return short
function hsc.ai_command_list_status()
end

---@param arg1 ai
---@return boolean
function hsc.ai_is_attacking()
end

---@param arg1 ai
---@param arg2 boolean
function hsc.ai_force_active()
end

---@param arg1 unit
---@param arg2 boolean
function hsc.ai_force_active_by_unit()
end

---Sets the state that a group of actors will return to when they have nothing to do
---@param encounterName ai
---@param state ai_default_state
function hsc.ai_set_return_state(encounterName, state)
end

---Sets the current state of a group of actors. WARNING: may have unpredictable results on actors that are in combat
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param aiDefaultState ai_default_state An "AI Default State" value (a block in the scenario tag).
function hsc.ai_set_current_state(encounterName, aiDefaultState)
end

---Sets an encounter to be playfighting or not.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param bool boolean @True to enable playfighting, false to disable.
---@return nil
-- Example: hsc.ai_playfight("crossfire_anti", true)
function hsc.ai_playfight(encounterName, bool)
end

-- Returns the most severe combat status of a group of actors | 0 = inactive | 1 = noncombat | 2 = guarding | 3 = search/suspicious | 4 = definite enemy(heard or magic awareness) | 5 = visible enemy | 6 = engaging in combat.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return short
---@see using_ai_status Usage example in context
-- Example: hsc.ai_status("ext_c_cov/ghost_a")
function hsc.ai_status(encounterName)
end

-- Reconnects all AI information to the current structure bsp (use this after you create encounters or command lists in sapien, or place new firing points or command list points).
---@return nil
-- Note: Use after "ai_erase_all" and before "garbage_collect_now" functions.
function hsc.ai_reconnect()
end

-- Sets a vehicle to 'belong' to a particular encounter/squad. any actors who get into the vehicle will be placed in this squad. NB: vehicles potentially drivable by multiple teams need their own encounter!.
---@param unitName unit @Name of a unit in the scenario.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_vehicle_encounter("ext_a_dropship_wraith_a" "ext_a_area_a_wraith/squad_i")
function hsc.ai_vehicle_encounter(unitName, encounterName)
end

---Sets a vehicle as being impulsively enterable for actors within a certain distance. 
---@param unitName unit Name of the unit in the scenario.
---@param distance real The distance in world units within which actors can enter the vehicle.
---Example: hsc.ai_vehicle_enterable_distance("warthog_1", 10.0)
function hsc.ai_vehicle_enterable_distance(unitName, distance)
end

-- Sets a vehicle as being impulsively enterable for actors of a certain team.
---@param unitName unit @Name of a unit in the scenario.
---@param teamIndex team An "Encounters" enum value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_vehicle_enterable_team("warthog_1", "human")
function hsc.ai_vehicle_enterable_team(unitName, teamIndex)
end

-- Sets a vehicle as being impulsively enterable for actors of a certain type (grunt, elite, marine etc).
---@param unitName unit @Name of a unit in the scenario.
---@param actorType actor_type @Enum value in actor tag (e.g. "marine", "elite", "grunt", etc).
---@return nil
-- Example: hsc.ai_vehicle_enterable_actor_type("warthog_1", "marine")
function hsc.ai_vehicle_enterable_actor_type(unitName, actorType)
end

-- sets a vehicle as being impulsively enterable for a certain encounter/squad of actors.
---@param unitName unit @Name of a unit in the scenario.
---@param squadName ai An "Encounters" name value (a block in the scenario tag).
---@return nil
-- Example: hsc.ai_vehicle_enterable_actors("warthog_1", "encounter_name/squad_name")
function hsc.ai_vehicle_enterable_actors(unitName, squadName)
end

-- Disables actors from impulsively getting into a vehicle (this is the default state for newly placed vehicles).
---@param unitName unit @Name of a unit in the scenario.
---@return nil
-- Example: hsc.ai_vehicle_enterable_disable("cyborg_4")
function hsc.ai_vehicle_enterable_disable(unitName)
end

-- Makes the specified unit look at the specified object.
---@param unitName unit @Name of a unit in the scenario.
---@param objectName object @Name of an object in the scenario.
---@return nil
-- Example: hsc.ai_look_at_object("marine_1", "ghost_1")
function hsc.ai_look_at_object(unitName, objectName)
end

-- Stops the specified unit from looking at anything.
---@param unitName unit
---@return nil
-- Example: hsc.ai_stop_looking("marine_1")
function hsc.ai_stop_looking(unitName)
end

-- Enables or disables a squad as being an automatic migration target.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param bool boolean @True to enable automatic migration, false to disable.
---@return nil
-- Example: hsc.ai_automatic_migration_target("encounter_name/squad_name", true)
function hsc.ai_automatic_migration_target(encounterName, bool)
end

-- Turns off following for an encounter
---@param string ai An "Encounters" value (a block in the scenario tag)
---@return nil
-- Example: hsc.ai_follow_target_disable("cliff_marine")
function hsc.ai_follow_target_disable(string)
end

-- Sets the follow target for an encounter to be the closest player
---@param string ai An "Encounters" value (a block in the scenario tag)
---@return nil
-- Example: hsc.ai_follow_target_players("cliff_marine")
function hsc.ai_follow_target_players(string)
end

---@param arg1 ai
---@param arg2 unit
function hsc.ai_follow_target_unit()
end

---@param arg1 ai
---@param arg2 ai
function hsc.ai_follow_target_ai()
end

---@param arg1 ai
---@param arg2 real
function hsc.ai_follow_distance()
end

---@param arg1 conversation
---@return boolean
function hsc.ai_conversation()
end

---@param arg1 conversation
function hsc.ai_conversation_stop()
end

---@param arg1 conversation
function hsc.ai_conversation_advance()
end

---@param arg1 conversation
---@return short
function hsc.ai_conversation_line()
end

---@param arg1 conversation
---@return short
function hsc.ai_conversation_status()
end

---@param arg1 ai
---@param arg2 ai
function hsc.ai_link_activation()
end

---@param arg1 ai
---@param arg2 boolean
function hsc.ai_berserk()
end

---@param arg1 ai
---@param arg2 team
function hsc.ai_set_team()
end

---@param arg1 ai
---@param arg2 boolean
function hsc.ai_allow_charge()
end

---@param arg1 ai
---@param arg2 boolean
function hsc.ai_allow_dormant()
end

---@param arg1 team
---@param arg2 team
---@return boolean
function hsc.ai_allegiance_broken()
end

---@param arg1 boolean
function hsc.camera_control()
end

---@param arg1 cutscene_camera_point
---@param arg2 short
function hsc.camera_set()
end

---@param arg1 cutscene_camera_point
---@param arg2 short
---@param arg3 object
function hsc.camera_set_relative()
end

---@param arg1 animation_graph
---@param arg2 string
function hsc.camera_set_animation()
end

---@param arg1 unit
function hsc.camera_set_first_person()
end

---@param arg1 unit
function hsc.camera_set_dead()
end

---@return short
function hsc.camera_time()
end

function hsc.debug_camera_load()
end

function hsc.debug_camera_save()
end

-----@param name string
-- function hsc.debug_camera_save_name(name) end

-----@param arg1 string
-- function hsc.debug_camera_load_name() end

-----@param arg1 string
-- function hsc.debug_camera_save_simple_name() end

-----@param arg1 string
-- function hsc.debug_camera_load_simple_name() end

-----@param arg1 string
-- function hsc.debug_camera_load_text() end

---@param arg1 real
function hsc.game_speed()
end

---@return long
function hsc.game_time()
end

---@param arg1 string
function hsc.game_variant()
end

-----@return game_difficulty
-- function hsc.game_difficulty_get() end

-----@return game_difficulty
-- function hsc.game_difficulty_get_real() end

function hsc.map_reset()
end

---@param arg1 string
function hsc.map_name()
end

---@param arg1 string
function hsc.multiplayer_map_name()
end

---@param arg1 game_difficulty
function hsc.game_difficulty_set()
end

---@param arg1 string
function hsc.crash()
end

---@param arg1 short
function hsc.switch_bsp()
end

---@return short
function hsc.structure_bsp_index()
end

function hsc.version()
end

function hsc.playback()
end

function hsc.quit()
end

function hsc.texture_cache_flush()
end

function hsc.sound_cache_flush()
end

function hsc.sound_cache_dump_to_file()
end

function hsc.debug_tags()
end

function hsc.profile_reset()
end

---@param arg1 string
function hsc.profile_dump()
end

---@param arg1 string
function hsc.profile_activate()
end

---@param arg1 string
function hsc.profile_deactivate()
end

---@param arg1 string
function hsc.profile_graph_toggle()
end

---@param arg1 boolean
function hsc.debug_pvs()
end

function hsc.radiosity_start()
end

function hsc.radiosity_save()
end

function hsc.radiosity_debug_point()
end

---@param arg1 boolean
function hsc.ai()
end

---@param arg1 boolean
function hsc.ai_dialogue_triggers()
end

---@param arg1 boolean
function hsc.ai_grenades()
end

function hsc.ai_lines()
end

function hsc.ai_debug_sound_point_set()
end

---@param arg1 string
---@param arg2 string
function hsc.ai_debug_vocalize()
end

---@param arg1 ai
function hsc.ai_debug_teleport_to()
end

---@param arg1 string
function hsc.ai_debug_speak()
end

---@param arg1 string
function hsc.ai_debug_speak_list()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
---@param arg4 short
function hsc.fade_in()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
---@param arg4 short
function hsc.fade_out()
end

function hsc.cinematic_start()
end

function hsc.cinematic_stop()
end

function hsc.cinematic_abort()
end

-- function hsc.cinematic_skip_start_internal() end

-- function hsc.cinematic_skip_stop_internal() end

---@param arg1 boolean
function hsc.cinematic_show_letterbox()
end

---@param arg1 cutscene_title
function hsc.cinematic_set_title()
end

---@param arg1 cutscene_title
---@param arg2 real
function hsc.cinematic_set_title_delayed()
end

---@param arg1 boolean
function hsc.cinematic_suppress_bsp_object_creation()
end

-- function hsc.game_won() end

function hsc.game_lost()
end

---@return boolean
function hsc.game_safe_to_save()
end

---@return boolean
function hsc.game_all_quiet()
end

---@return boolean
function hsc.game_safe_to_speak()
end

-----@return boolean
-- function hsc.game_is_cooperative() end

---@return boolean
function hsc.game_is_authoritative()
end

-- function hsc.game_save() end

function hsc.game_save_cancel()
end

-- function hsc.game_save_no_timeout() end

-- function hsc.game_save_totally_unsafe() end

---@return boolean
function hsc.game_saving()
end

function hsc.game_revert()
end

---@return boolean
function hsc.game_reverted()
end

function hsc.core_save()
end

---@param arg1 string
---@return boolean
function hsc.core_save_name()
end

function hsc.core_load()
end

function hsc.core_load_at_startup()
end

---@param arg1 string
function hsc.core_load_name()
end

---@param arg1 string
function hsc.core_load_name_at_startup()
end

---@param arg1 string
---@return boolean
function hsc.mcc_mission_segment()
end

---@param arg1 short
function hsc.game_skip_ticks()
end

---@param arg1 sound
---@param arg2 boolean
function hsc.sound_impulse_predict()
end

---@param arg1 sound
---@param arg2 object
---@param arg3 real
function hsc.sound_impulse_start()
end

---@param arg1 sound
---@return long
function hsc.sound_impulse_time()
end

---@param arg1 sound
function hsc.sound_impulse_stop()
end

---@param arg1 looping_sound
function hsc.sound_looping_predict()
end

---@param arg1 looping_sound
---@param arg2 object
---@param arg3 real
function hsc.sound_looping_start()
end

---@param arg1 looping_sound
function hsc.sound_looping_stop()
end

---@param arg1 looping_sound
---@param arg2 real
function hsc.sound_looping_set_scale()
end

---@param arg1 looping_sound
---@param arg2 boolean
function hsc.sound_looping_set_alternate()
end

---@param arg1 string
---@param arg2 boolean
function hsc.debug_sounds_enable()
end

---@param arg1 boolean
function hsc.sound_enable()
end

---@param arg1 real
function hsc.sound_set_master_gain()
end

---@return real
function hsc.sound_get_master_gain()
end

---@param arg1 real
function hsc.sound_set_music_gain()
end

---@return real
function hsc.sound_get_music_gain()
end

---@param arg1 real
function hsc.sound_set_effects_gain()
end

---@return real
function hsc.sound_get_effects_gain()
end

---@param arg1 string
---@param arg2 real
---@param arg3 short
function hsc.sound_class_set_gain()
end

---Stops the vehicle from running real physics and runs fake hovering physics instead.
---@param vehicleName vehicle Name of a vehicle in scenario tag.
---@param isHovering boolean True to enable fake hovering physics, false to disable.
---Example: hsc.vehicle_hover("pelican_1", true)
function hsc.vehicle_hover(vehicleName, isHovering)
end

function hsc.players_unzoom_all()
end

---@param arg1 boolean
function hsc.player_enable_input()
end

---@param arg1 boolean
---@return boolean
function hsc.player_camera_control()
end

function hsc.player_action_test_reset()
end

---@return boolean
function hsc.player_action_test_jump()
end

---@return boolean
function hsc.player_action_test_primary_trigger()
end

---@return boolean
function hsc.player_action_test_grenade_trigger()
end

---@return boolean
function hsc.player_action_test_zoom()
end

---@return boolean
function hsc.player_action_test_action()
end

---@return boolean
function hsc.player_action_test_accept()
end

---@return boolean
function hsc.player_action_test_back()
end

---@return boolean
function hsc.player_action_test_look_relative_up()
end

---@return boolean
function hsc.player_action_test_look_relative_down()
end

---@return boolean
function hsc.player_action_test_look_relative_left()
end

---@return boolean
function hsc.player_action_test_look_relative_right()
end

---@return boolean
function hsc.player_action_test_look_relative_all_directions()
end

---@return boolean
function hsc.player_action_test_move_relative_all_directions()
end

---@param arg1 unit
---@param arg2 starting_profile
---@param arg3 boolean
function hsc.player_add_equipment()
end

---@param arg1 short
---@param arg2 short
function hsc.debug_teleport_player()
end

---@param arg1 boolean
---@return boolean
function hsc.show_hud()
end

---@param arg1 boolean
---@return boolean
function hsc.show_hud_help_text()
end

---@param arg1 boolean
function hsc.enable_hud_help_flash()
end

function hsc.hud_help_flash_restart()
end

---@param navNave navpoint
---@param arg2 unit
---@param arg3 cutscene_flag
---@param arg4 real
function hsc.activate_nav_point_flag()
end

---Activates a nav point type <string> attached to (local) player <unit> anchored to an object with a vertical offset <real>. If the player is not local to the machine, this will fail
---@param navName navpoint
---@param unitName unit
---@param objectName object
---@param zOffset real
function hsc.activate_nav_point_object(navName, unitName, objectName, zOffset)
end

---@param arg1 navpoint
---@param arg2 team
---@param arg3 cutscene_flag
---@param arg4 real
function hsc.activate_team_nav_point_flag()
end

---@param arg1 navpoint
---@param arg2 team
---@param arg3 object
---@param arg4 real
function hsc.activate_team_nav_point_object()
end

---@param arg1 unit
---@param arg2 cutscene_flag
function hsc.deactivate_nav_point_flag()
end

---@param arg1 unit
---@param arg2 object
function hsc.deactivate_nav_point_object()
end

---@param arg1 team
---@param arg2 cutscene_flag
function hsc.deactivate_team_nav_point_flag()
end

---@param arg1 team
---@param arg2 object
function hsc.deactivate_team_nav_point_object()
end

function hsc.cls()
end

---@param arg1 boolean
function hsc.error_overflow_suppression()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
function hsc.player_effect_set_max_translation()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
function hsc.player_effect_set_max_rotation()
end

---@param arg1 real
---@param arg2 real
function hsc.player_effect_set_max_vibrate()
end

---@param arg1 real
---@param arg2 real
function hsc.player_effect_set_max_rumble()
end

---@param arg1 real
---@param arg2 real
function hsc.player_effect_start()
end

---@param arg1 real
function hsc.player_effect_stop()
end

---@param arg1 boolean
function hsc.hud_show_health()
end

---@param arg1 boolean
function hsc.hud_blink_health()
end

---@param arg1 boolean
function hsc.hud_show_shield()
end

---@param arg1 boolean
function hsc.hud_blink_shield()
end

---@param arg1 boolean
function hsc.hud_show_motion_sensor()
end

---@param arg1 boolean
function hsc.hud_blink_motion_sensor()
end

---@param arg1 boolean
function hsc.hud_show_crosshair()
end

function hsc.hud_clear_messages()
end

---@param arg1 hud_message
function hsc.hud_set_help_text()
end

---@param arg1 hud_message
function hsc.hud_set_objective_text()
end

---@param arg1 short
---@param arg2 short
function hsc.hud_set_timer_time()
end

---@param arg1 short
---@param arg2 short
function hsc.hud_set_timer_warning_time()
end

---@param arg1 short
---@param arg2 short
---@param arg3 hud_corner
function hsc.hud_set_timer_position()
end

---@param arg1 boolean
function hsc.show_hud_timer()
end

---@param arg1 boolean
function hsc.pause_hud_timer()
end

---@return short
function hsc.hud_get_timer_ticks()
end

---@param arg1 boolean
function hsc.time_code_show()
end

---@param arg1 boolean
function hsc.time_code_start()
end

function hsc.time_code_reset()
end

function hsc.reload_shader_transparent_chicago()
end

function hsc.rasterizer_reload_effects()
end

function hsc.rasterizer_decals_flush()
end

function hsc.rasterizer_fps_accumulate()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
---@param arg4 real
function hsc.rasterizer_model_ambient_reflection_tint()
end

function hsc.rasterizer_lights_reset_for_new_map()
end

---@param arg1 short
---@param arg2 real
function hsc.script_screen_effect_set_value()
end

---@param arg1 boolean
function hsc.cinematic_screen_effect_start()
end

---@param arg1 short
---@param arg2 short
---@param arg3 real
---@param arg4 real
---@param arg5 real
function hsc.cinematic_screen_effect_set_convolution()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
---@param arg4 real
---@param arg5 boolean
---@param arg6 real
function hsc.cinematic_screen_effect_set_filter()
end

---@param arg1 real
---@param arg2 real
---@param arg3 real
function hsc.cinematic_screen_effect_set_filter_desaturation_tint()
end

---@param arg1 short
---@param arg2 real
function hsc.cinematic_screen_effect_set_video()
end

function hsc.cinematic_screen_effect_stop()
end

---@param arg1 real
function hsc.cinematic_set_near_clip_distance()
end

---@param arg1 boolean
function hsc.player0_look_invert_pitch()
end

---@return boolean
function hsc.player0_look_pitch_is_inverted()
end

---@return boolean
function hsc.player0_joystick_set_is_normal()
end

---@param arg1 boolean
function hsc.ui_widget_show_path()
end

---@param arg1 short
function hsc.display_scenario_help()
end

---@param arg1 boolean
function hsc.sound_enable_eax()
end

---@return boolean
function hsc.sound_eax_enabled()
end

---@param arg1 short
function hsc.sound_set_env()
end

---@param arg1 boolean
---@param arg2 boolean
function hsc.sound_enable_hardware()
end

---@param arg1 short
---@param arg2 boolean
function hsc.sound_set_supplementary_buffers()
end

---@return short
function hsc.sound_get_supplementary_buffers()
end

---@param arg1 real
function hsc.sound_set_rolloff()
end

---@param arg1 real
function hsc.sound_set_factor()
end

---@param arg1 short
---@return real
function hsc.get_yaw_rate()
end

---@param arg1 short
---@return real
function hsc.get_pitch_rate()
end

---@param arg1 short
---@param arg2 real
function hsc.set_yaw_rate()
end

---@param arg1 short
---@param arg2 real
function hsc.set_pitch_rate()
end

---@param arg1 string
---@param arg2 string
---@param arg3 string
function hsc.bind()
end

---@param arg1 string
---@param arg2 string
function hsc.unbind()
end

function hsc.print_binds()
end

---@param arg1 string
---@param arg2 string
function hsc.sv_map()
end

---@param arg1 string
function hsc.profile_load()
end

function hsc.checkpoint_save()
end

---@param arg1 string
function hsc.checkpoint_load()
end

---@param arg1 string
---@param arg2 boolean
function hsc.TestPrintBool()
end

---@param arg1 string
---@param arg2 real
function hsc.TestPrintReal()
end

function hsc.structure_lens_flares_place()
end

---@return real
function hsc.rasterizer_near_clip_distance()
end

---@return real
function hsc.rasterizer_far_clip_distance()
end

---@return real
function hsc.rasterizer_first_person_weapon_near_clip_distance()
end

---@return real
function hsc.rasterizer_first_person_weapon_far_clip_distance()
end

---@return boolean
function hsc.rasterizer_floating_point_zbuffer()
end

---@return boolean
function hsc.rasterizer_framerate_throttle()
end

---@return boolean
function hsc.rasterizer_framerate_stabilization()
end

---@return short
function hsc.rasterizer_refresh_rate()
end

---@return short
function hsc.rasterizer_frame_bounds_left()
end

---@return short
function hsc.rasterizer_frame_bounds_right()
end

---@return short
function hsc.rasterizer_frame_bounds_top()
end

---@return short
function hsc.rasterizer_frame_bounds_bottom()
end

---@return short
function hsc.rasterizer_stats()
end

---@return short
function hsc.rasterizer_mode()
end

---@return boolean
function hsc.rasterizer_wireframe()
end

---@return boolean
function hsc.rasterizer_smart()
end

---@return boolean
function hsc.rasterizer_debug_model_vertices()
end

---@return short
function hsc.rasterizer_debug_model_lod()
end

---@return boolean
function hsc.rasterizer_debug_transparents()
end

---@return boolean
function hsc.rasterizer_debug_meter_shader()
end

---@return boolean
function hsc.rasterizer_models()
end

---@return boolean
function hsc.rasterizer_model_transparents()
end

---@return boolean
function hsc.rasterizer_draw_first_person_weapon_first()
end

---@return boolean
function hsc.rasterizer_stencil_mask()
end

---@return boolean
function hsc.rasterizer_environment()
end

---@return boolean
function hsc.rasterizer_environment_lightmaps()
end

---@return boolean
function hsc.rasterizer_environment_shadows()
end

---@return boolean
function hsc.rasterizer_environment_diffuse_lights()
end

---@return boolean
function hsc.rasterizer_environment_diffuse_textures()
end

---@return boolean
function hsc.rasterizer_environment_decals()
end

---@return boolean
function hsc.rasterizer_environment_specular_lights()
end

---@return boolean
function hsc.rasterizer_environment_specular_lightmaps()
end

---@return boolean
function hsc.rasterizer_environment_reflection_lightmap_mask()
end

---@return boolean
function hsc.rasterizer_environment_reflection_mirrors()
end

---@return boolean
function hsc.rasterizer_environment_reflections()
end

---@return boolean
function hsc.rasterizer_environment_transparents()
end

---@return boolean
function hsc.rasterizer_environment_fog()
end

---@return boolean
function hsc.rasterizer_environment_fog_screen()
end

---@return boolean
function hsc.rasterizer_water()
end

---@return boolean
function hsc.rasterizer_lens_flares()
end

---@return boolean
function hsc.rasterizer_dynamic_unlit_geometry()
end

---@return boolean
function hsc.rasterizer_dynamic_lit_geometry()
end

---@return boolean
function hsc.rasterizer_dynamic_screen_geometry()
end

---@return boolean
function hsc.rasterizer_hud_motion_sensor()
end

---@return boolean
function hsc.rasterizer_detail_objects()
end

---@return boolean
function hsc.rasterizer_debug_geometry()
end

---@return boolean
function hsc.rasterizer_debug_geometry_multipass()
end

---@return boolean
function hsc.rasterizer_fog_atmosphere()
end

---@return boolean
function hsc.rasterizer_fog_plane()
end

---@return boolean
function hsc.rasterizer_bump_mapping()
end

---@return real
function hsc.rasterizer_lightmap_ambient()
end

---@return short
function hsc.rasterizer_lightmap_mode()
end

---@return boolean
function hsc.rasterizer_lightmaps_incident_radiosity()
end

---@return boolean
function hsc.rasterizer_lightmaps_filtering()
end

---@return real
function hsc.rasterizer_model_lighting_ambient()
end

---@return boolean
function hsc.rasterizer_environment_alpha_testing()
end

---@return boolean
function hsc.rasterizer_environment_specular_mask()
end

---@return boolean
function hsc.rasterizer_shadows_convolution()
end

---@return boolean
function hsc.rasterizer_shadows_debug()
end

---@return boolean
function hsc.rasterizer_water_mipmapping()
end

---@return boolean
function hsc.rasterizer_active_camouflage()
end

---@return boolean
function hsc.rasterizer_active_camouflage_multipass()
end

---@return boolean
function hsc.rasterizer_plasma_energy()
end

---@return boolean
function hsc.rasterizer_lens_flares_occlusion()
end

---@return boolean
function hsc.rasterizer_lens_flares_occlusion_debug()
end

---@return boolean
function hsc.rasterizer_ray_of_buddha()
end

---@return boolean
function hsc.rasterizer_screen_flashes()
end

---@return boolean
function hsc.rasterizer_screen_effects()
end

---@return boolean
function hsc.rasterizer_profile_log()
end

---@return real
function hsc.rasterizer_detail_objects_offset_multiplier()
end

---@return real
function hsc.rasterizer_zbias()
end

---@return real
function hsc.rasterizer_zoffset()
end

---@return boolean
function hsc.force_all_player_views_to_default_player()
end

---@return boolean
function hsc.rasterizer_safe_frame_bounds()
end

---@return short
function hsc.freeze_flying_camera()
end

---@return boolean
function hsc.rasterizer_zsprites()
end

---@return boolean
function hsc.rasterizer_filthy_decal_fog_hack()
end

---@return short
function hsc.pad3()
end

---@return real
function hsc.pad3_scale()
end

---@return real
function hsc.f0()
end

---@return real
function hsc.f1()
end

---@return real
function hsc.f2()
end

---@return real
function hsc.f3()
end

---@return real
function hsc.f4()
end

---@return real
function hsc.f5()
end

---@return short
function hsc.rasterizer_effects_level()
end

---@return boolean
function hsc.rasterizer_fps()
end

---@return boolean
function hsc.debug_no_frustum_clip()
end

---@return boolean
function hsc.debug_frustum()
end

---@return short
function hsc.screenshot_size()
end

---@return short
function hsc.screenshot_count()
end

---@return boolean
function hsc.terminal_render()
end

---@return short
function hsc.player_spawn_count()
end

---@return boolean
function hsc.debug_object_garbage_collection()
end

---@return boolean
function hsc.debug_render_freeze()
end

---@return boolean
function hsc.temporary_hud()
end

---@return long
function hsc.debug_leaf_index()
end

---@return long
function hsc.debug_leaf_portal_index()
end

---@return boolean
function hsc.debug_leaf_portals()
end

---@return boolean
function hsc.debug_unit_all_animations()
end

---@return boolean
function hsc.debug_unit_animations()
end

---@return boolean
function hsc.debug_damage_taken()
end

---@return boolean
function hsc.cheat_deathless_player()
end

---@return boolean
function hsc.cheat_jetpack()
end

---@return boolean
function hsc.cheat_infinite_ammo()
end

---@return boolean
function hsc.cheat_bottomless_clip()
end

---@return boolean
function hsc.cheat_bump_possession()
end

---@return boolean
function hsc.cheat_super_jump()
end

---@return boolean
function hsc.cheat_reflexive_damage_effects()
end

---@return boolean
function hsc.cheat_medusa()
end

---@return boolean
function hsc.cheat_omnipotent()
end

---@return boolean
function hsc.cheat_controller()
end

---@return boolean
function hsc.effects_corpse_nonviolent()
end

---@return boolean
function hsc.debug_sound_cache()
end

---@return boolean
function hsc.debug_sound_cache_graph()
end

---@return real
function hsc.sound_obstruction_ratio()
end

---@return boolean
function hsc.debug_sound()
end

---@return boolean
function hsc.debug_looping_sound()
end

---@return boolean
function hsc.debug_sound_channels()
end

---@return boolean
function hsc.debug_sound_channels_detail()
end

---@return boolean
function hsc.debug_sound_hardware()
end

---@return boolean
function hsc.loud_dialog_hack()
end

---@return real
function hsc.sound_gain_under_dialog()
end

---@return real
function hsc.object_light_ambient_base()
end

---@return real
function hsc.object_light_ambient_scale()
end

---@return real
function hsc.object_light_secondary_scale()
end

---@return boolean
function hsc.object_light_interpolate()
end

---@return boolean
function hsc.model_animation_compression()
end

---@return long
function hsc.model_animation_data_compressed_size()
end

---@return long
function hsc.model_animation_data_uncompressed_size()
end

---@return long
function hsc.model_animation_data_compression_savings_in_bytes()
end

---@return long
function hsc.model_animation_data_compression_savings_in_bytes_at_import()
end

---@return real
function hsc.model_animation_data_compression_savings_in_percent()
end

---@return long
function hsc.model_animation_bullshit0()
end

---@return long
function hsc.model_animation_bullshit1()
end

---@return long
function hsc.model_animation_bullshit2()
end

---@return long
function hsc.model_animation_bullshit3()
end

---@return boolean
function hsc.rider_ejection()
end

---@return boolean
function hsc.stun_enable()
end

---@return boolean
function hsc.debug_sprites()
end

---@return boolean
function hsc.debug_portals()
end

---@return boolean
function hsc.debug_inactive_objects()
end

---@return boolean
function hsc.render_contrails()
end

---@return boolean
function hsc.render_particles()
end

---@return boolean
function hsc.render_psystems()
end

---@return boolean
function hsc.render_wsystems()
end

---@return boolean
function hsc.debug_objects()
end

---@return boolean
function hsc.debug_objects_position_velocity()
end

---@return boolean
function hsc.debug_objects_root_node()
end

---@return boolean
function hsc.debug_objects_bounding_spheres()
end

---@return boolean
function hsc.debug_objects_collision_models()
end

---@return boolean
function hsc.debug_objects_physics()
end

---@return boolean
function hsc.debug_objects_names()
end

---@return boolean
function hsc.debug_objects_pathfinding_spheres()
end

---@return boolean
function hsc.debug_objects_unit_vectors()
end

---@return boolean
function hsc.debug_objects_unit_seats()
end

---@return boolean
function hsc.debug_objects_unit_mouth_apeture()
end

---@return boolean
function hsc.debug_objects_biped_physics_pills()
end

---@return boolean
function hsc.debug_objects_biped_autoaim_pills()
end

---@return boolean
function hsc.debug_objects_vehicle_powered_mass_points()
end

---@return boolean
function hsc.debug_objects_devices()
end

---@return boolean
function hsc.render_model_nodes()
end

---@return boolean
function hsc.render_model_vertex_counts()
end

---@return boolean
function hsc.render_model_index_counts()
end

---@return boolean
function hsc.render_model_markers()
end

---@return boolean
function hsc.render_model_no_geometry()
end

---@return boolean
function hsc.render_shadows()
end

---@return boolean
function hsc.debug_damage()
end

---@return boolean
function hsc.debug_scripting()
end

---@return boolean
function hsc.debug_trigger_volumes()
end

---@return boolean
function hsc.debug_point_physics()
end

---@return boolean
function hsc.debug_physics_disable_penetration_freeze()
end

---@return boolean
function hsc.debug_motion_sensor_draw_all_units()
end

---@return boolean
function hsc.collision_debug()
end

---@return boolean
function hsc.collision_debug_spray()
end

---@return boolean
function hsc.collision_debug_features()
end

---@return boolean
function hsc.collision_debug_repeat()
end

---@return boolean
function hsc.collision_debug_flag_front_facing_surfaces()
end

---@return boolean
function hsc.collision_debug_flag_back_facing_surfaces()
end

---@return boolean
function hsc.collision_debug_flag_ignore_two_sided_surfaces()
end

---@return boolean
function hsc.collision_debug_flag_ignore_invisible_surfaces()
end

---@return boolean
function hsc.collision_debug_flag_ignore_breakable_surfaces()
end

---@return boolean
function hsc.collision_debug_flag_structure()
end

---@return boolean
function hsc.collision_debug_flag_media()
end

---@return boolean
function hsc.collision_debug_flag_objects()
end

---@return boolean
function hsc.collision_debug_flag_objects_bipeds()
end

---@return boolean
function hsc.collision_debug_flag_objects_vehicles()
end

---@return boolean
function hsc.collision_debug_flag_objects_weapons()
end

---@return boolean
function hsc.collision_debug_flag_objects_equipment()
end

---@return boolean
function hsc.collision_debug_flag_objects_projectiles()
end

---@return boolean
function hsc.collision_debug_flag_objects_scenery()
end

---@return boolean
function hsc.collision_debug_flag_objects_machines()
end

---@return boolean
function hsc.collision_debug_flag_objects_controls()
end

---@return boolean
function hsc.collision_debug_flag_objects_light_fixtures()
end

---@return boolean
function hsc.collision_debug_flag_objects_placeholders()
end

---@return boolean
function hsc.collision_debug_flag_try_to_keep_location_valid()
end

---@return boolean
function hsc.collision_debug_flag_skip_passthrough_bipeds()
end

---@return boolean
function hsc.collision_debug_flag_use_vehicle_physics()
end

---@return real
function hsc.collision_debug_point_x()
end

---@return real
function hsc.collision_debug_point_y()
end

---@return real
function hsc.collision_debug_point_z()
end

---@return real
function hsc.collision_debug_vector_i()
end

---@return real
function hsc.collision_debug_vector_j()
end

---@return real
function hsc.collision_debug_vector_k()
end

---@return real
function hsc.collision_debug_length()
end

---@return real
function hsc.collision_debug_width()
end

---@return real
function hsc.collision_debug_height()
end

---@return boolean
function hsc.collision_debug_phantom_bsp()
end

---@return boolean
function hsc.collision_log_render()
end

---@return boolean
function hsc.collision_log_detailed()
end

---@return boolean
function hsc.collision_log_extended()
end

---@return boolean
function hsc.collision_log_totals_only()
end

---@return boolean
function hsc.collision_log_time()
end

---@return boolean
function hsc.debug_obstacle_path()
end

---@return boolean
function hsc.debug_obstacle_path_on_failure()
end

---@return real
function hsc.debug_obstacle_path_start_point_x()
end

---@return real
function hsc.debug_obstacle_path_start_point_y()
end

---@return long
function hsc.debug_obstacle_path_start_surface_index()
end

---@return real
function hsc.debug_obstacle_path_goal_point_x()
end

---@return real
function hsc.debug_obstacle_path_goal_point_y()
end

---@return long
function hsc.debug_obstacle_path_goal_surface_index()
end

---@return boolean
function hsc.debug_camera()
end

---@return boolean
function hsc.debug_player()
end

---@return boolean
function hsc.debug_structure()
end

---@return boolean
function hsc.debug_structure_automatic()
end

---@return boolean
function hsc.debug_bsp()
end

---@return boolean
function hsc.debug_input()
end

---@return boolean
function hsc.debug_permanent_decals()
end

---@return boolean
function hsc.debug_fog_planes()
end

---@return boolean
function hsc.decals()
end

---@return boolean
function hsc.debug_decals()
end

---@return boolean
function hsc.debug_object_lights()
end

---@return boolean
function hsc.debug_lights()
end

---@return boolean
function hsc.debug_biped_physics()
end

---@return boolean
function hsc.debug_biped_skip_update()
end

---@return boolean
function hsc.debug_biped_skip_collision()
end

---@return boolean
function hsc.debug_biped_limp_body_disable()
end

---@return boolean
function hsc.debug_collision_skip_objects()
end

---@return boolean
function hsc.debug_collision_skip_vectors()
end

---@return boolean
function hsc.debug_material_effects()
end

---@return boolean
function hsc.weather()
end

---@return boolean
function hsc.breakable_surfaces()
end

---@return boolean
function hsc.profile_graph()
end

---@return boolean
function hsc.profile_display()
end

---@return boolean
function hsc.profile_timebase_ticks()
end

---@return boolean
function hsc.profile_dump_frames()
end

---@return boolean
function hsc.profile_dump_lost_frames()
end

---@return boolean
function hsc.recover_saved_games_hack()
end

---@return short
function hsc.radiosity_quality()
end

---@return short
function hsc.radiosity_step_count()
end

---@return boolean
function hsc.radiosity_lines()
end

---@return boolean
function hsc.radiosity_normals()
end

---@return boolean
function hsc.structures_use_pvs_for_vs()
end

---@return boolean
function hsc.debug_texture_cache()
end

---@return boolean
function hsc.debug_detail_objects()
end

---@return boolean
function hsc.ai_render()
end

---@return boolean
function hsc.ai_render_all_actors()
end

---@return boolean
function hsc.ai_render_inactive_actors()
end

---@return boolean
function hsc.ai_render_lineoffire_crouching()
end

---@return boolean
function hsc.ai_render_lineoffire()
end

---@return boolean
function hsc.ai_render_lineofsight()
end

---@return boolean
function hsc.ai_render_ballistic_lineoffire()
end

---@return boolean
function hsc.ai_render_encounter_activeregion()
end

---@return boolean
function hsc.ai_render_vision_cones()
end

---@return boolean
function hsc.ai_render_current_state()
end

---@return boolean
function hsc.ai_render_detailed_state()
end

---@return boolean
function hsc.ai_render_props()
end

---@return boolean
function hsc.ai_render_props_web()
end

---@return boolean
function hsc.ai_render_props_no_friends()
end

---@return boolean
function hsc.ai_render_props_target_weight()
end

---@return boolean
function hsc.ai_render_props_unreachable()
end

---@return boolean
function hsc.ai_render_props_unopposable()
end

---@return boolean
function hsc.ai_render_idle_look()
end

---@return boolean
function hsc.ai_render_support_surfaces()
end

---@return boolean
function hsc.ai_render_recent_damage()
end

---@return boolean
function hsc.ai_render_threats()
end

---@return boolean
function hsc.ai_render_emotions()
end

---@return boolean
function hsc.ai_render_audibility()
end

---@return boolean
function hsc.ai_render_aiming_vectors()
end

---@return boolean
function hsc.ai_render_secondary_looking()
end

---@return boolean
function hsc.ai_render_targets()
end

---@return boolean
function hsc.ai_render_targets_last_visible()
end

---@return boolean
function hsc.ai_render_states()
end

---@return boolean
function hsc.ai_render_vitality()
end

---@return boolean
function hsc.ai_render_active_cover_seeking()
end

---@return boolean
function hsc.ai_render_evaluations()
end

---@return boolean
function hsc.ai_render_pursuit()
end

---@return boolean
function hsc.ai_render_shooting()
end

---@return boolean
function hsc.ai_render_trigger()
end

---@return boolean
function hsc.ai_render_projectile_aiming()
end

---@return boolean
function hsc.ai_render_aiming_validity()
end

---@return boolean
function hsc.ai_render_speech()
end

---@return boolean
function hsc.ai_render_teams()
end

---@return boolean
function hsc.ai_render_player_ratings()
end

---@return boolean
function hsc.ai_render_spatial_effects()
end

---@return boolean
function hsc.ai_render_firing_positions()
end

---@return boolean
function hsc.ai_render_gun_positions()
end

---@return boolean
function hsc.ai_render_burst_geometry()
end

---@return boolean
function hsc.ai_render_vehicle_anilance()
end

---@return boolean
function hsc.ai_render_vehicles_enterable()
end

---@return boolean
function hsc.ai_render_melee_check()
end

---@return boolean
function hsc.ai_render_dialogue_variants()
end

---@return boolean
function hsc.ai_render_grenade_decisions()
end

---@return boolean
function hsc.ai_render_danger_zones()
end

---@return boolean
function hsc.ai_render_charge_decisions()
end

---@return boolean
function hsc.ai_render_control()
end

---@return boolean
function hsc.ai_render_activation()
end

---@return boolean
function hsc.ai_render_paths()
end

---@return boolean
function hsc.ai_render_paths_selected_only()
end

---@return boolean
function hsc.ai_render_paths_destination()
end

---@return boolean
function hsc.ai_render_paths_current()
end

---@return boolean
function hsc.ai_render_paths_failed()
end

---@return boolean
function hsc.ai_render_paths_raw()
end

---@return boolean
function hsc.ai_render_paths_smoothed()
end

---@return boolean
function hsc.ai_render_paths_aniled()
end

---@return short
function hsc.ai_render_paths_anilance_segment()
end

---@return boolean
function hsc.ai_render_paths_anilance_obstacles()
end

---@return boolean
function hsc.ai_render_paths_anilance_search()
end

---@return boolean
function hsc.ai_render_paths_nodes()
end

---@return boolean
function hsc.ai_render_paths_nodes_all()
end

---@return boolean
function hsc.ai_render_paths_nodes_polygons()
end

---@return boolean
function hsc.ai_render_paths_nodes_costs()
end

---@return boolean
function hsc.ai_render_paths_nodes_closest()
end

---@return boolean
function hsc.ai_render_player_aiming_blocked()
end

---@return boolean
function hsc.ai_render_vector_anilance()
end

---@return boolean
function hsc.ai_render_vector_anilance_rays()
end

---@return boolean
function hsc.ai_render_vector_anilance_sense_t()
end

---@return boolean
function hsc.ai_render_vector_anilance_anil_t()
end

---@return boolean
function hsc.ai_render_vector_anilance_clear_time()
end

---@return boolean
function hsc.ai_render_vector_anilance_weights()
end

---@return boolean
function hsc.ai_render_vector_anilance_objects()
end

---@return boolean
function hsc.ai_render_vector_anilance_intermediate()
end

---@return boolean
function hsc.ai_render_postcombat()
end

---@return boolean
function hsc.ai_print_pursuit_checks()
end

---@return boolean
function hsc.ai_print_rules()
end

---@return boolean
function hsc.ai_print_rule_values()
end

---@return boolean
function hsc.ai_print_major_upgrade()
end

---@return boolean
function hsc.ai_print_respawn()
end

---@return boolean
function hsc.ai_print_evaluation_statistics()
end

---@return boolean
function hsc.ai_print_communication()
end

---@return boolean
function hsc.ai_print_communication_player()
end

---@return boolean
function hsc.ai_print_vocalizations()
end

---@return boolean
function hsc.ai_print_placement()
end

---@return boolean
function hsc.ai_print_speech()
end

---@return boolean
function hsc.ai_print_speech_timers()
end

---@return boolean
function hsc.ai_print_allegiance()
end

---@return boolean
function hsc.ai_print_lost_speech()
end

---@return boolean
function hsc.ai_print_migration()
end

---@return boolean
function hsc.ai_print_automatic_migration()
end

---@return boolean
function hsc.ai_print_scripting()
end

---@return boolean
function hsc.ai_print_surprise()
end

---@return boolean
function hsc.ai_print_command_lists()
end

---@return boolean
function hsc.ai_print_damage_modifiers()
end

---@return boolean
function hsc.ai_print_secondary_looking()
end

---@return boolean
function hsc.ai_print_oversteer()
end

---@return boolean
function hsc.ai_print_conversations()
end

---@return boolean
function hsc.ai_print_killing_sprees()
end

---@return boolean
function hsc.ai_print_acknowledgement()
end

---@return boolean
function hsc.ai_print_unfinished_paths()
end

---@return boolean
function hsc.ai_print_bsp_transition()
end

---@return boolean
function hsc.ai_print_uncovering()
end

---@return boolean
function hsc.ai_profile_disable()
end

---@return boolean
function hsc.ai_profile_random()
end

---@return boolean
function hsc.ai_show()
end

---@return boolean
function hsc.ai_show_stats()
end

---@return boolean
function hsc.ai_show_actors()
end

---@return boolean
function hsc.ai_show_swarms()
end

---@return boolean
function hsc.ai_show_paths()
end

---@return boolean
function hsc.ai_show_line_of_sight()
end

---@return boolean
function hsc.ai_show_prop_types()
end

---@return boolean
function hsc.ai_show_sound_distance()
end

---@return boolean
function hsc.ai_debug_fast_los()
end

---@return boolean
function hsc.ai_debug_oversteer_disable()
end

---@return boolean
function hsc.ai_debug_evaluate_all_positions()
end

---@return boolean
function hsc.ai_debug_path()
end

---@return boolean
function hsc.ai_debug_path_start_freeze()
end

---@return boolean
function hsc.ai_debug_path_end_freeze()
end

---@return boolean
function hsc.ai_debug_path_flood()
end

---@return real
function hsc.ai_debug_path_maximum_radius()
end

---@return boolean
function hsc.ai_debug_path_attractor()
end

---@return real
function hsc.ai_debug_path_attractor_radius()
end

---@return real
function hsc.ai_debug_path_attractor_weight()
end

---@return real
function hsc.ai_debug_path_accept_radius()
end

---@return boolean
function hsc.ai_debug_ballistic_lineoffire_freeze()
end

---@return boolean
function hsc.ai_debug_communication_random_disabled()
end

---@return boolean
function hsc.ai_debug_communication_timeout_disabled()
end

---@return boolean
function hsc.ai_debug_communication_unit_repeat_disabled()
end

---@return boolean
function hsc.ai_debug_communication_focus_enable()
end

---@return boolean
function hsc.ai_debug_blind()
end

---@return boolean
function hsc.ai_debug_deaf()
end

---@return boolean
function hsc.ai_debug_invisible_player()
end

---@return boolean
function hsc.ai_debug_ignore_player()
end

---@return boolean
function hsc.ai_debug_flee_always()
end

---@return boolean
function hsc.ai_debug_force_all_active()
end

---@return boolean
function hsc.ai_debug_disable_wounded_sounds()
end

---@return boolean
function hsc.ai_debug_force_vocalizations()
end

---@return boolean
function hsc.ai_debug_force_crouch()
end

---@return boolean
function hsc.ai_debug_path_disable_smoothing()
end

---@return boolean
function hsc.ai_debug_path_disable_obstacle_anilance()
end

---@return boolean
function hsc.ai_fix_defending_guard_firing_positions()
end

---@return boolean
function hsc.ai_fix_actor_variants()
end

---@return boolean
function hsc.controls_enable_crouch()
end

---@return boolean
function hsc.controls_swapped()
end

---@return boolean
function hsc.controls_enable_doubled_spin()
end

---@return boolean
function hsc.controls_swap_doubled_spin_state()
end

---@return boolean
function hsc.player_autoaim()
end

---@return boolean
function hsc.player_magnetism()
end

---@return boolean
function hsc.debug_player_teleport()
end

---@return boolean
function hsc.texture_cache_graph()
end

---@return boolean
function hsc.texture_cache_list()
end

---@return boolean
function hsc.director_camera_switch_fast()
end

---@return boolean
function hsc.director_camera_switching()
end

---@return boolean
function hsc.debug_recording()
end

---@return short
function hsc.debug_recording_newlines()
end

---@return boolean
function hsc.debug_framerate()
end

---@return boolean
function hsc.display_framerate()
end

---@return boolean
function hsc.framerate_throttle()
end

---@return boolean
function hsc.framerate_lock()
end

---@return boolean
function hsc.debug_game_save()
end

---@return boolean
function hsc.allow_out_of_sync()
end

---@return boolean
function hsc.global_connection_dont_timeout()
end

---@return long
function hsc.slow_server_startup_safety_zone_in_seconds()
end

---@return boolean
function hsc.find_all_fucked_up_shit()
end

---@return boolean
function hsc.error_suppress_all()
end

---@return boolean
function hsc.run_game_scripts()
end

---@return long
function hsc.debug_score()
end

---@return boolean
function hsc.object_prediction()
end

---@return short
function hsc.developer_mode()
end

---@return real
function hsc.mouse_acceleration()
end







-------------------------------------------------------
-- Example sintaxis 
-------------------------------------------------------

-- Functions that return a "short" (integer) value have the option 
-- of modifying that value, and in some cases have a special action 
-- assigned at that value in the engine; the following examples will 
-- help us understand better.


-- Example ai_living_count
function using_ai_living_count(call, sleep)
    sleep(function()
        return hsc.ai_living_count("encounter") == 0
    end)
    if hsc.ai_living_count('encounter') == 0 then
        print("No enemies left")
    end
end

local countEnemyesLeft = 0
countEnemyesLeft = hsc.ai_living_count("encounter")


-- Example ai_status
local statusCombat = {
    inactive = 0,
    nonCombat = 1,
    guarding = 2,
    searchSuspicious = 3,
    magicAwareness = 4,
    visibleEnemy = 5,
    engageCombat = 6
}

function using_ai_status(call, sleep)
    sleep(function()
        return hsc.ai_status("encounter") == statusCombat.guarding
    end)
    if hsc.ai_status("encounter") < 5 then
        print("wololo")
    end
end

statusCombat.guarding = hsc.ai_status("encounter/squad")