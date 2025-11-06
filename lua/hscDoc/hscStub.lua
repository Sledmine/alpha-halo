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
---@param playerTeams short 0 for Red Team, 1 for Blue Team
---@return object_list
function hsc.players_on_multiplayer_team(playerTeams)
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
---@param objectPath object_definition
function hsc.objects_delete_by_definition(objectPath)
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

---Make the specified unit run the specified cutscene recording.
---@param unitName unit Name of a unit in "name objects" scenario tag block.
---@param recAnimsName cutscene_recording Name of a cutscene recording in "Recorded Animations" scenario tag block.
---@return boolean
---Example: hsc.recording_play("foehammer_cliff", "foehammer_cliff_in")
function hsc.recording_play(unitName, recAnimsName)
end

---Make the specified unit run the specified cutscene recording, deletes the unit when the animation finishes.
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

---Kill the specified unit's cutscene recording.
---@param unitName unit Name of a unit in "name objects" scenario tag block.
function hsc.recording_kill(unitName)
end

---Return the time remaining in the specified unit's cutscene recording.
---@param unitName unit Name of a unit in "name objects" scenario tag block.
---@return short
---Example: hsc.recording_time("foehammer_cliff")
---Output: time remaining in milliseconds
function hsc.recording_time(unitName)
end

---FALSE prevents object from using ranged attack.
---@param objectName object
---@param isInhibited boolean
---Example: hsc.object_set_ranged_attack_inhibited("grunt_1", true) -- Prevents the grunt_1 from using ranged attacks.
function hsc.object_set_ranged_attack_inhibited(objectName, isInhibited)
end

---FALSE prevents object from using melee attack.
---@param objectName object 
---@param isInhibited boolean
---Example: hsc.object_set_melee_attack_inhibited("grunt_1", true) -- Prevents the grunt_1 from using melee attacks.
function hsc.object_set_melee_attack_inhibited(objectName, isInhibited)
end

---Debugs object memory usage.
function hsc.objects_dump_memory()
end

---FALSE prevents any object from colliding with the given object.
---@param objectName object
---@param isCollidable boolean
function hsc.object_set_collideable(objectName, isCollidable)
end

---Sets the scale for a given object and interpolates over the given number of frames to achieve that scale.
---@param objectName object
---@param scale real
---@param transitionScaleFrames short
---Example: hsc.object_set_scale("ghost_1", 1.5, 30) -- Sets the scale of ghost_1 to 1.5 over 30 frames.
function hsc.object_set_scale(objectName, scale, transitionScaleFrames)
end

---Attaches the second object to the first within the specified markers; both strings can be empty, if so, the objects will be attached at their origin frame/bone.
---@param parentObjectName object
---@param parentMarker string
---@param childObjectName object
---@param childMarker string
---Example: hsc.objects_attach("marine_1", "right_hand", "pistol_1", "") -- Attaches pistol_1 to the right hand of marine_1.
function hsc.objects_attach(parentObjectName, parentMarker, childObjectName, childMarker)
end

---Detaches from the given parent object the given child object.
---@param parentObjectName object
---@param childObjectName object
---Example: hsc.objects_detach("marine_1", "pistol_1") -- Detaches pistol_1 from marine_1.
function hsc.objects_detach(parentObjectName, childObjectName)
end

---Causes all garbage objects except those visible to a player to be collected immediately.
function hsc.garbage_collect_now()
end

---Prevents an object from taking damage.
---@param objectList object_list -- A list of objects (e.g., "players", "enemies", "allies") to prevent from taking damage.
---Example: hsc.object_cannot_take_damage("players") -- Prevents all players from taking damage.
function hsc.object_cannot_take_damage(objectList)
end

---Allows an object to take damage again
---@param objectList object_list -- A list of objects (e.g., "players", "enemies", "allies") to allow to take damage.
---Example: hsc.object_can_take_damage("players") -- Allows all players to take damage.
function hsc.object_can_take_damage(objectList)
end

---Makes an object pretty for the remainder of the levels' cutscenes.
---@param objectName object
---@param isBeautiful boolean
---Example: hsc.object_beautify("cortana", true) -- Makes the object named "cortana" beautiful for cutscenes.
function hsc.object_beautify(objectName, isBeautiful)
end

---Loads textures necessary to draw a objects that are about to come on-screen.
---@param objectList object_list
---Example: hsc.objects_predict("enemies") -- Loads textures for all enemy objects.
function hsc.objects_predict(objectList)
end

---Loads textures necessary to draw an object that's about to come on-screen.
---@param objectPath object_definition
function hsc.object_type_predict(objectPath)
end

---Just another (old) name for object_pvs_set_object.
---@param objectName object
---@deprecated
function hsc.object_pvs_activate(objectName)
end

---Sets the specified object as the special place that activates everything it sees.
---@param objectName object
---Example: hsc.object_pvs_set_object("camera_1") -- Sets the object named "camera_1" as the PVS activator.
function hsc.object_pvs_set_object(objectName)
end

---Sets the specified cutscene camera point as the special place that activates everything it sees.
---@param cameraPointName cutscene_camera_point
---Example: hsc.object_pvs_set_camera("cutscene_camera_1") -- Sets the cutscene camera point named "cutscene_camera_1" as the PVS activator.
function hsc.object_pvs_set_camera(cameraPointName)
end

---Removes the special place that activates everything it sees.
function hsc.object_pvs_clear()
end

---Enables/disables dynamic lights.
---@param enableDynamicLights boolean
---@return boolean
---Example: hsc.render_lights(false) -- Disables dynamic lights.
function hsc.render_lights(enableDynamicLights)
end

---Returns the number of ticks remaining in a custom animation (or zero, if the animation is over).
---@param sceneryName scenery
---@return short
function hsc.scenery_get_animation_time(sceneryName)
end

---Starts a custom animation playing on a piece of scenery.
---@param sceneryName scenery
---@param modelAnimationPath animation_graph
---@param animationName string
---Example: hsc.scenery_animation_start("tree_1", "environment\\\trees\\\tree_oak", "sway")
function hsc.scenery_animation_start(sceneryName, modelAnimationPath, animationName)
end

---Starts a custom animation playing on a piece of scenery at a specific frame.
---@param sceneryName scenery
---@param modelAnimationPath animation_graph
---@param animationName string
---@param startAtFrame short
---Example: hsc.scenery_animation_start_at_frame("tree_1", "environment\\\trees\\\tree_oak", "sway", 10)
function hsc.scenery_animation_start_at_frame(sceneryName, modelAnimationPath, animationName, startAtFrame)
end

---Renders or stops rendering special effects.
---@param enableEffects boolean
function hsc.render_effects(enableEffects)
end

---Allows a unit to blink on motion sensor or not (units never blink when they are dead).
---@param unitName unit
---@param canBlink boolean
---Example: hsc.unit_can_blink("elite_1", false) -- Prevents the unit named "elite_1" from blinking on motion sensor.
function hsc.unit_can_blink(unitName, canBlink)
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

---Kills a given unit, no saving throw.
---@param unitName unit
---Example: hsc.unit_kill("grunt_1") -- Kills the unit named "grunt_1".
function hsc.unit_kill(unitName)
end

---Kills a given unit silently (doesn't make them play their normal death animation or sound)
---@param unitName unit
---Example: hsc.unit_kill_silent("grunt_1") -- Silently kills the unit named "grunt_1".
function hsc.unit_kill_silent(unitName)
end

---Returns the number of ticks remaining in a unit's custom animation (or zero, if the animation is over).
---@param unitName unit
---@return short
---Example: hsc.unit_get_custom_animation_time("cyborg")
---Output: number of ticks remaining in the custom animation.
function hsc.unit_get_custom_animation_time(unitName)
end

---Stops the custom animation running on the given unit.
---@param unitName unit
---Example: hsc.unit_stop_custom_animation("cyborg")
---Output: stops the custom animation on the unit named "cyborg".
function hsc.unit_stop_custom_animation(unitName)
end

---Starts a custom animation playing on a unit at a specific frame index(interpolates into animation if next to last parameter is TRUE).
---@param unitName unit
---@param modelAnimationPath animation_graph
---@param animationName string
---@param interpolate boolean
---@param startAtFrame short
---@return boolean
---Example: hsc.unit_custom_animation_at_frame("marine_1", "characters\\\marine\\\marine", "walk", true, 10)
function hsc.unit_custom_animation_at_frame(unitName, modelAnimationPath, animationName, interpolate, startAtFrame)
end

---Starts a custom animation playing on a unit (interpolates into animation if last parameter is TRUE).
---@param unitName unit -- Name of a unit in "name objects" scenario tag block.
---@param modelAnimationPath animation_graph -- Path to the animation tag
---@param animationName string -- Name of the animation to play inside animation tag (e.g., "walk")
---@param interpolate boolean -- If true, the animation will interpolate from the current state to the new animation; if false, it will snap to the new animation immediately.
---@return boolean
---Example: hsc.custom_animation("marine_1", "characters\\\marine\\\marine", "walk", true)
function hsc.custom_animation(unitName, modelAnimationPath, animationName, interpolate)
end

---Starts a custom animation playing on a unit list (interpolates into animation if last parameter is TRUE).
---@param objectList object_list A list of objects (units) to play the animation on.
---@param modelAnimationPath animation_graph Path to the animation tag
---@param animationName string Name of the animation to play inside animation tag
---@param interpolate boolean
---@return boolean
---Example: hsc.custom_animation_list("players", "characters\\\cinematic\\\stage2", "battle", false)
function hsc.custom_animation_list(objectList, modelAnimationPath, animationName, interpolate)
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

---Puts the specified unit in the specified vehicle (in the named seat).
---@param unitName unit Name of a unit in scenario tag.
---@param vehicleName vehicle Name of a vehicle in scenario tag.
---@param seatName string  Name of the seat in the vehicle.
---Example: hsc.unit_enter_vehicle("marine_1", "pelican_2", "P-passenger") -- Puts the unit named "marine_1" into the "P-passenger" seat of the vehicle named "pelican_2".
function hsc.unit_enter_vehicle(unitName, vehicleName, seatName)
end

---Tests whether the named seat has an object in the object list.
---@param vehicleName vehicle Name of a vehicle in scenario tag.
---@param seatName string Name of the seat in the vehicle. Use "" to match all seats.
---@param unitList object_list A list of objects (units) to test for in the seat.
---@see hsc.ai_actors for creating unit lists.
---@return boolean
---Example: hsc.vehicle_test_seat_list("pelican_2", "P-passenger", "players")
---Tests whether any player units are in the "P-passenger" seat of the vehicle named "pelican_2".
---Example 2: hsc.vehicle_test_seat_list("dropship", "CD-passenger", hsc.ai_actors("dropship/dropship_troopers")).
---Tests whether any of the units in the AI encounter "dropship/dropship_troopers" are in the "CD-passenger" seat of the vehicle named "dropship".
function hsc.vehicle_test_seat_list(vehicleName, seatName, unitList)
end

---Tests whether the named seat has a specified unit in it.
---@param vehicleName vehicle Name of a vehicle in scenario tag.
---@param seatName string Name of the seat in the vehicle.
---@param unitName unit Name of a unit in scenario tag.
---@return boolean
---Example: hsc.vehicle_test_seat("pelican_2", "P-passenger", "marine_1") -- Tests whether the unit named "marine_1" is in the "P-passenger" seat of the vehicle named "pelican_2".
function hsc.vehicle_test_seat(vehicleName, seatName, unitName)
end

---Sets the emotion animation to be used for the given unit.
---@param unitName unit Name of a unit in scenario tag.
---@param animationName string Name of the emotion animation to set.
---Example: hsc.unit_set_emotion_animation("cortana", "happy") -- Sets Cortana's emotion animation to "happy".
function hsc.unit_set_emotion_animation(unitName, animationName)
end

---Makes a unit exit its vehicle.
---@param unitName unit Name of a unit in scenario tag.
---Example: hsc.unit_exit_vehicle("marine_1") -- Makes the unit named "marine_1" exit its vehicle.
function hsc.unit_exit_vehicle(unitName)
end

---Sets a unit's maximum body and shield vitality [0,1].
---@param unitName unit Name of a unit in scenario tag.
---@param maxBody real Number for maximum body vitality.
---@param maxShield real Number for maximum shield vitality.
---Example: hsc.unit_set_maximum_vitality("marine_1", 1, 0.5) -- Sets the maximum body vitality of the unit named "marine_1" to 1 and maximum shield vitality to 0.5.
function hsc.unit_set_maximum_vitality(unitName, maxBody, maxShield)
end

---Sets a group of units' maximum body and shield vitality.
---@param unitList object_list A list of objects (units) to set the maximum vitality for.
---@param maxBody real Number for maximum body vitality.
---@param maxShield real Number for maximum shield vitality.
---Example: hsc.units_set_maximum_vitality("players", 1, 0.5) -- Sets the maximum body vitality of all player units to 1 and maximum shield vitality to 0.5.
function hsc.units_set_maximum_vitality(unitList, maxBody, maxShield)
end

---Sets a unit's current body and shield vitality.
---@param unitName unit Name of a unit in scenario tag.
---@param currentBody real Number for current body vitality.
---@param currentShield real Number for current shield vitality.
---Example: hsc.unit_set_current_vitality("marine_1", 0.8, 0.3) -- Sets the current body vitality of the unit named "marine_1" to 0.8 and current shield vitality to 0.3.
function hsc.unit_set_current_vitality(unitName, currentBody, currentShield)
end

---Sets a group of units' current body and shield vitality.
---@param unitList object_list A list of objects (units) to set the current vitality for.
---@param currentBody real Number for current body vitality.
---@param currentShield real Number for current shield vitality.
---Example: hsc.units_set_current_vitality("players", 0.8, 0.3) -- Sets the current body vitality of all player units to 0.8 and current shield vitality to 0.3.
function hsc.units_set_current_vitality(unitList, currentBody, currentShield)
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

---All units controlled by the player will assume the given seat name (valid values are 'asleep', 'alert', 'stand', 'crouch' and 'flee') ???.
---@param seatName string 
function hsc.magic_seat_name(seatName)
end

---This unit will assume the named seat.
---@param unitName unit Name of a unit in scenario tag.
---@param seatName string Name of the seat in the vehicle. Use "" to match all seats.
---Example: hsc.unit_set_seat("marine_1", "P-passenger")
function hsc.unit_set_seat(unitName, seatName)
end

---Causes player's unit to start a melee attack.
function hsc.magic_melee_attack()
end

-- Returns a list of all riders in a vehicle.
---@param unitName unit @Name of a unit in scenario tag.
---@return object_list vehicle_riders
--Example: hsc.vehicle_riders("pelican_3")
function hsc.vehicle_riders(unitName)
end

---Returns the driver of a vehicle.
---@param unitName unit Name of a unit in scenario tag.
---@return unit
---Example: hsc.vehicle_driver("warthog_1")
---Output: the unit driving the warthog_1
function hsc.vehicle_driver(unitName)
end

---Returns the gunner of a vehicle.
---@param unitName unit Name of a unit in scenario tag.
---@return unit
---Example: hsc.vehicle_gunner("warthog_1")
---Output: the unit manning the turret of warthog_1
function hsc.vehicle_gunner(unitName)
end

---Returns the health [0,1] of the unit, returns -1 if the unit does not exists.
---@param unitName unit Name of a unit in scenario tag.
---@return real
---Example: hsc.unit_get_health("marine_1")
---Output: the health of the unit marine_1
function hsc.unit_get_health(unitName)
end

---Returns the shield [0,1] of the unit, returns -1 if the unit does not exists.
---@param unitName unit Name of a unit in scenario tag.
---@return real
---Example: hsc.unit_get_shield("marine_1")
---Output: the shield of the unit marine_1
function hsc.unit_get_shield(unitName)
end

---Returns the total number of grenades for the given unit, 0 if it does not exist
---@param unitName unit Name of a unit in scenario tag.
---@return short
---Example: hsc.unit_get_total_grenade_count("marine_1")
---Output: the total number of grenades for the unit marine_1
function hsc.unit_get_total_grenade_count(unitName)
end

---Returns TRUE if the <unit> has <object> as a weapon, FALSE otherwise
---@param unitName unit Name of a unit in scenario tag.
---@param weaponPath weapon Object definition must be a weapon
---@return boolean
---Example: hsc.unit_has_weapon("marine_1", "weapons\\\pistol\\\pistol")
---Output: TRUE if the unit marine_1 has the pistol as a weapon, FALSE otherwise
function hsc.unit_has_weapon(unitName, weaponPath)
end

---Returns TRUE if the <unit> has <object> as the primary weapon, FALSE otherwise.
---@param unitName unit Name of a unit in scenario tag.
---@param weaponPath weapon
---@return boolean
---Example: hsc.unit_has_weapon_readied("player0", "weapons\\\pistol\\\pistol")
---Output: TRUE if the unit player0 has the pistol as the primary weapon, FALSE otherwise
function hsc.unit_has_weapon_readied(unitName, weaponPath)
end

---Prevents any of the given units from dropping weapons or grenades when they die.
---@param objectList object_list
---@see hsc.ai_actors Go to reference
---Example: hsc.unit_doesnt_drop_items(hsc.ai_actors("rocks/elites_2"))
function hsc.unit_doesnt_drop_items(objectList)
end

---Prevents any of the given units from being knocked around or playing ping animations.
---@param objectList object_list
---@param isImpervious boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.unit_impervious(hsc.ai_actors("rocks/elites_2"), true)
function hsc.unit_impervious(objectList, isImpervious)
end

---Stops gravity from working on the given unit.
---@param unitName unit Name of a unit in scenario tag.
---@param isSuspendedGravity boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.unit_suspended("elite_1", true)
function hsc.unit_suspended(unitName, isSuspendedGravity)
end

---Returns whether the night-vision mode could be activated via the flashlight button.
---@return boolean
function hsc.unit_solo_player_integrated_night_vision_is_active()
end

---Sets the units' desired flashlight state.
---@param objectList object_list
---@param isEnabled boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.units_set_desired_flashlight_state(hsc.ai_actors("rocks/marines_2"), true) -- Enables the flashlight for all units in the "rocks/marines_2" encounter.
---Example: hsc.units_set_desired_flashlight_state("players", true) -- Enables the flashlight for all player units.
function hsc.units_set_desired_flashlight_state(objectList, isEnabled)
end

---Sets the unit's desired flashlight state.
---@param unitName unit Name of a unit in scenario tag.
---@param isEnabled boolean
---Example: hsc.unit_set_desired_flashlight_state("marine_1", true) -- Enables the flashlight for the unit named "marine_1".
function hsc.unit_set_desired_flashlight_state(unitName, isEnabled)
end

---Gets the unit's current flashlight state.
---@param unitName unit Name of a unit in scenario tag.
---@return boolean
---Example: hsc.unit_get_current_flashlight_state("marine_1") -- Returns TRUE if the flashlight is currently enabled for the unit named "marine_1", FALSE otherwise
function hsc.unit_get_current_flashlight_state(unitName)
end

---Changes a machine's never_appears_locked flag, but only if paul is a BLAM! (WTF with the last quote).
---@param deviceName device Name of a device in scenario tag.
---@param isNeverAppearsLocked boolean
---Example: hsc.device_set_never_appears_locked("main_gate", true) -- Sets the never_appears_locked flag for the device named "main_gate" to true.
function hsc.device_set_never_appears_locked(deviceName, isNeverAppearsLocked)
end

---Gets the current power of a named device.
---@param deviceName device Name of a device in scenario tag.
---@return real
---Example: hsc.device_get_power("main_gate") -- Returns the current power level of the device named "main_gate".
---Output: power level as a real number between [0, 1]
function hsc.device_get_power(deviceName)
end

---Immediately sets the power of a named device to the given value.
---@param deviceName device Name of a device in scenario tag.
---@param powerValue real Desired power value [0, 1]
---Example: hsc.device_set_power("main_gate", 1) -- Sets the power level of the device named "main_gate" to 1 immediately.
function hsc.device_set_power(deviceName, powerValue)
end

---Set the desired position of the given device (used for devices without explicit device groups).
---@param deviceName device Name of a device in scenario tag.
---@param positionValue real Desired position value [0.0, 1.0]
---@return boolean
---Example: hsc.device_set_position("main_gate", 0.5) -- Sets the desired position of the device named "main_gate" to 0.5
function hsc.device_set_position(deviceName, positionValue)
end

---Gets the current position of the given device (used for devices without explicit device groups).
---@param deviceName device Name of a device in scenario tag.
---@return real
---Example: hsc.device_get_position("main_gate") -- Returns the current position of the device named "main_gate".
---Output: position value as a real number between [0.0, 1.0]
function hsc.device_get_position(deviceName)
end

---Instantaneously changes the position of the given device (used for devices without explicit device groups).
---@param deviceName device Name of a device in scenario tag.
---@param positionValue real Desired position value [0.0, 1.0]
---Example: hsc.device_set_position_immediate("main_gate", 0.75) -- Sets the position of the device named "main_gate" to 0.75 immediately.
function hsc.device_set_position_immediate(deviceName, positionValue)
end

---Returns the desired value of the specified device group.
---@param deviceGroupName device_group Name of a device group in scenario tag.
---@return real
---Example: hsc.device_group_get("main_gate_position") -- Returns the desired value of the device group named "main_gate_position".
function hsc.device_group_get(deviceGroupName)
end

---Changes the desired value of the specified device group.
---@param deviceGroupName device_group Name of a device group in scenario tag.
---@param deviceValue real Desired value [0.0, 1.0]
---@return boolean
---Example: hsc.device_group_set("main_gate_position", 0.5) -- Sets the desired value of the device group named "main_gate_position" to 0.5
function hsc.device_group_set(deviceGroupName, deviceValue)
end

---Instantaneously changes the value of the specified device group.
---@param deviceGroupName device_group Name of a device group in scenario tag.
---@param deviceValue real Desired value [0.0, 1.0]
---Example: hsc.device_group_set_immediate("main_gate_position", 0.75) -- Sets the value of the device group named "main_gate_position" to 0.75 immediately.
function hsc.device_group_set_immediate(deviceGroupName, deviceValue)
end

---TRUE makes the given device one-sided (only able to be opened from one direction), FALSE makes it two-sided
---@param deviceName device Name of a device in scenario tag.
---@param isOneSided boolean
---Example: hsc.device_one_sided_set("main_gate", true) -- Makes the device named "main_gate" one-sided.
function hsc.device_one_sided_set(deviceName, isOneSided)
end

---TRUE makes the given device open automatically when any biped is nearby, FALSE makes it not.
---@param deviceName device Name of a device in scenario tag.
---@param operatesAutomatically boolean
---Example: hsc.device_operates_automatically_set("main_gate", true) -- Makes the device named "main_gate" operate automatically.
function hsc.device_operates_automatically_set(deviceName, operatesAutomatically)
end

---TRUE allows a device to change states only once.
---@param deviceGroupName device_group Name of a device group in scenario tag.
---@param allowChange boolean
---Example: hsc.device_group_change_only_once_more_set("main_gate_position", true) -- Allows the device group named "main_gate_position" to change states only once more.
function hsc.device_group_change_only_once_more_set(deviceGroupName, allowChange)
end

---Restores all breakable surfaces.
function hsc.breakable_surfaces_reset()
end

---Drops all powerups from globals near player.
function hsc.cheat_all_powerups()
end

---Drops all weapons from globals near player.
function hsc.cheat_all_weapons()
end

---Drops a warthog near player.
function hsc.cheat_spawn_warthog()
end

---Drops all vehicles from globals near player.
function hsc.cheat_all_vehicles()
end

---Teleports player to camera location.
function hsc.cheat_teleport_to_camera()
end

---Gives the player active camouflage.
function hsc.cheat_active_camouflage()
end

---Gives the player active camouflage
---Check what is unknownValue for
---@param unknownValue short
function hsc.cheat_active_camouflage_local_player(unknownValue)
end

---Reloads the cheats.txt file
function hsc.cheats_load()
end

-- Removes a group of actors from their encounter and sets them free
---@param encounterName ai
---Example: hsc.ai_free("rocks/elites_2")
function hsc.ai_free(encounterName)
end

---Removes a set of units from their encounter (if any) and sets them free
---@param objectList object_list An object list | After choose one, concatenate the target name in each case.
---@see hsc.vehicle_riders Go to reference
---@see hsc.ai_actors Go to reference
---Example 1: hsc.ai_free_units(hsc.vehicle_riders("jeep")) | Example 2: hsc.ai_free_units(hsc.ai_actors("first_wave/wave_2_lz_toon"))
function hsc.ai_free_units(objectList)
end

-- Attaches the specified unit to the specified encounter.
---@param unitName unit @Name of a unit in the scenario.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_attach("marine_1", "control_room/marines2")
function hsc.ai_attach(unitName, encounterName)
end

-- Attaches a unit to a newly created free actor of the specified type.
---@param unitName unit @Name of a unit in the scenario.
---@param actorVariantPath actor_variant Actor Variant Tag Path
-- Example: hsc.ai_attach_free("bridge_sentinel_3", "characters\monitor\monitor")
function hsc.ai_attach_free(unitName, actorVariantPath)
end

-- Detaches the specified unit from all AI.
---@param unitName unit
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
-- Example: hsc.ai_kill("woods/grunts1")
function hsc.ai_kill(encounterName)
end

-- Instantly kills the specified encounter and/or squad without any sound and death animation.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_kill_silent("woods/grunts1")
function hsc.ai_kill_silent(encounterName)
end

-- Erases the specified encounter and/or squad.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_erase("myEncounter/mySquad")
function hsc.ai_erase(encounterName)
end

-- Erases all AI.
function hsc.ai_erase_all()
end

-- Selects the specified encounter.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_select("control_room/marines2")
function hsc.ai_select(encounterName)
end

-- Spawns an actor in the specified encounter and/or squad.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
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
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param isEnabled boolean @True to enable hearing, false to disable.
-- Example: hsc.ai_set_deaf("encounter_name/squad_name", false)
function hsc.ai_set_deaf(encounterName, isEnabled)
end

-- Enables or disables sight for actors in the specified encounter.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param isEnabled boolean @True to enable sight, false to disable.
-- Example: hsc.ai_set_blind("encounter_name/squad_name", true)
function hsc.ai_set_blind(encounterName, isEnabled)
end

-- Makes encounter 1 magically aware of encounter 2.
---@param encounter1 ai An "Encounters" name value (a block in the scenario tag).
---@param encounter2 ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_magically_see_encounter("first_marine", "first_wave")
function hsc.ai_magically_see_encounter(encounter1, encounter2)
end

---Makes an encounter magically aware of nearby players.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_magically_see_players("jackals_lz")
function hsc.ai_magically_see_players(encounterName)
end

---Makes an encounter magically aware of the specified unit.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param unitName unit A "Unit" name from the scenario.
-- Example: hsc.ai_magically_see_unit("control_room/elites_2", "marines_support")
function hsc.ai_magically_see_unit(encounterName, unitName)
end

---Makes a squad's delay timer start counting.
---@param encounterName ai
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_timer_start("rocks/elites_2")
function hsc.ai_timer_start(encounterName)
end

---Makes a squad's delay timer expire and releases them to enter combat.
---@param encounterName ai
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_timer_expire("rocks/elites_2")
function hsc.ai_timer_expire(encounterName)
end

---Makes the specified platoon(s) go into the attacking state.
---@param encounterName ai
---Example: hsc.ai_attack("rocks/elites_2")
function hsc.ai_attack(encounterName)
end

---Makes the specified platoon(s) go into the defending state.
---@param encounterName ai
---Example: hsc.ai_defend("rocks/elites_2")
function hsc.ai_defend(encounterName)
end

---Makes all squads in the specified platoon(s) retreat to their designated maneuver squads.
---@param encounterName ai
---Example: hsc.ai_retreat("rocks/elites_2")
function hsc.ai_retreat(encounterName)
end

---Makes all squads in the specified platoon(s) maneuver to their designated maneuver squads.
---@param encounterName ai
---Example: hsc.ai_maneuver("rocks/elites_2")
function hsc.ai_maneuver(encounterName)
end

---Enables or disables the maneuver/retreat rule for an encounter or platoon. the rule will still trigger, but none of the actors will be given the order to change squads.
---@param encounterName ai
---@param isEnabled boolean
---Example: hsc.ai_maneuver_enable("rocks/elites_2", true)
function hsc.ai_maneuver_enable(encounterName, isEnabled)
end

---Makes a named vehicle or group of units move from one encounter to another.
---@param encounter1 ai An "Encounters" name value (a block in the scenario tag).
---@param encounter2 ai An "Encounters" name value (a block in the scenario tag).
-- Example: hsc.ai_migrate(airlock_1/main airlock_1/advance). | Note: *Also you can type just the encounter name and migrate all inside it.
function hsc.ai_migrate(encounter1, encounter2)
end

---Makes all or part of an encounter move to another encounter, and say their 'advance' or 'retreat' speech lines.
---@param encounter1 ai An "Encounters" name value (a block in the scenario tag).
---@param encounter2 ai An "Encounters" name value (a block in the scenario tag).
---@param speechLine string The speech line to play. Valid values are "advance" and "retreat".
-- Example: hsc.ai_migrate_and_speak("airlock_1/main", "airlock_1/deck", "advance")
function hsc.ai_migrate_and_speak(encounter1, encounter2, speechLine)
end

---Makes a named vehicle or group of units move to another encounter.
---@param unitList object_list A list of units to move.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@see hsc.vehicle_riders Go to reference
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_migrate_by_unit(hsc.vehicle_riders("jeep"), hsc.ai_actors("airlock_1/advance"))
function hsc.ai_migrate_by_unit(unitList, encounterName)
end

---Creates an allegiance between two teams.
---@param teamName1 team
---@param teamName2 team
---Example: hsc.ai_allegiance(sentinel, player)
function hsc.ai_allegiance(teamName1, teamName2)
end

---Removes an allegiance between two teams.
---@param teamName1 team
---@param teamName2 team
---Example: hsc.ai_allegiance_remove(sentinel, player)
function hsc.ai_allegiance_remove(teamName1, teamName2)
end

-- Return the number of living actors in the specified encounter and/or squad.
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---@return short
---@see using_ai_living_count Ussage example in context
-- Example: hsc.ai_living_count("hills/marines_2")
function hsc.ai_living_count(encounterName)
end

---Return the fraction [0-1] of living actors in the specified encounter and/or squad.
---@param encounterName ai
---@return real
---Example: hsc.ai_living_fraction("hills/marines_2")
function hsc.ai_living_fraction(encounterName)
end

---Return the current strength (average body vitality from 0-1) of the specified encounter and/or squad.
---@param encounterName ai
---@return real
---Example: hsc.ai_strength("hills/marines_2")
function hsc.ai_strength(encounterName)
end

---Return the number of swarm actors in the specified encounter and/or squad. (Not used in Halo CE Campaign) Unknown what is a swarm actor.
---@param encounterName ai
---@return short
function hsc.ai_swarm_count(encounterName)
end

---Return the number of non-swarm actors in the specified encounter and/or squad.
---@param encounterName ai
---@return short
function hsc.ai_nonswarm_count(encounterName)
end

---Converts an encounter and/or squad reference to an object list.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag)
---@return object_list ai_actors
-- Example: hsc.ai_actors("ext_c_cov/ghost_a")
function hsc.ai_actors(encounterName)
end

---Tells a group of actors to get into a vehicle, in the substring-specified seats (e.g. passenger for pelican)...
---does not interrupt any actors who are already going to vehicles
---@param encounterName ai
---@param vehicleName unit
---@param seatName string
---Example: hsc.ai_go_to_vehicle("ext_beach/marine_support_2", "pelican_2", "P-passenger")
function hsc.ai_go_to_vehicle(encounterName, vehicleName, seatName)
end

---Tells a group of actors to get into a vehicle, in the substring-specified seats (e.g. passenger for pelican)...
---NB: any actors who are already going to vehicles will stop and go to this one instead!
---@param encounterName ai
---@param vehicleName unit
---@param seatName string
---Example: hsc.ai_go_to_vehicle_override("ext_beach/marine_support_2", "pelican_2", "P-passenger")
function hsc.ai_go_to_vehicle_override(encounterName, vehicleName, seatName)
end

---Return the number of actors that are still trying to get into the specified vehicle.
---@param vehicleName unit
---@return short
---Example: hsc.ai_going_to_vehicle("pelican_2")
function hsc.ai_going_to_vehicle(vehicleName)
end

-- Tells a group of actors from encounter/squad? to get out of any vehicles that they are in. 
---@param encounterName ai @Name of the encounter and/or squad, such as "ext_c_cov/ghost_a"
-- Example: hsc.ai_exit_vehicle("ext_c_cov/ghost_a ") | hsc.ai_exit_vehicle("ext_c_cov")
function hsc.ai_exit_vehicle(encounterName)
end

---Makes a group of actors braindead, or restores them to life (in their initial state).
---@param encounterName ai
---@param inBraindead boolean
---Example: hsc.ai_braindead("encounter", true) -- Makes encounter braindead.
function hsc.ai_braindead(encounterName, inBraindead)
end

---Makes a list of objects braindead, or restores them to life. if you pass in a vehicle name, it makes all actors in that vehicle braindead (including any built-in guns).
---@param objectList object_list 
---@param isBraindead boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_braindead_by_unit(hsc.ai_actors("rocks/elites_2"), true)
---Example with a vehicle: hsc.ai_braindead_by_unit("pelican_2", true)
function hsc.ai_braindead_by_unit(objectList, isBraindead)
end

---If TRUE, forces all actors to completely disregard the specified units, otherwise lets them acknowledge the units again.
---@param objectList object_list
---@param isDisregard boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_disregard(hsc.ai_actors("rocks/elites_2"), true)
function hsc.ai_disregard(objectList, isDisregard)
end

---If TRUE, *ALL* enemies will prefer to attack the specified units. if FALSE, removes the preference.
---@param objectList object_list
---@param isPrefer boolean
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_prefer_target(hsc.ai_actors("rocks/elites_2"), true)
---Example 2: hsc.ai_prefer_target("players", true)
function hsc.ai_prefer_target(objectList, isPrefer)
end

---Teleports a group of actors to the starting locations of their current squad(s)
---@param encounterName ai
---Example: hsc.ai_teleport_to_starting_location("rocks/elites_2")
function hsc.ai_teleport_to_starting_location(encounterName)
end

---Teleports a group of actors to the starting locations of their current squad(s), only if they are not supported by solid ground
---(i.e. if they are falling after switching BSPs)
---@param encounterName ai
---Example: hsc.ai_teleport_to_starting_location_if_unsupported("rocks/elites_2")
function hsc.ai_teleport_to_starting_location_if_unsupported(encounterName)
end

---Refreshes the health and grenade count of a group of actors, so they are as good as new.
---@param encounterName ai
---Example: hsc.ai_renew("rocks/elites_2")
function hsc.ai_renew(encounterName)
end

---Removes the preferential target setting from a group of actors.
---@param encounterName ai
---Example: hsc.ai_try_to_fight_nothing("rocks/elites_2")
function hsc.ai_try_to_fight_nothing(encounterName)
end

---Causes a group of actors to preferentially target another group of actors.
---@param encounterName ai
---@param targetEncounterName ai
---Example: hsc.ai_try_to_fight("rocks/elites_2", "woods/marines_2")
function hsc.ai_try_to_fight(encounterName, targetEncounterName)
end

---Causes a group of actors to preferentially target the player.
---@param encounterName ai
---Example: hsc.ai_try_to_fight_player("rocks/elites_2")
function hsc.ai_try_to_fight_player(encounterName)
end

---Tells a group of actors to begin executing the specified command list.
---@param encounterName ai
---@param commandList ai_command_list
---Example: hsc.ai_command_list("rocks/elites_2", "ambush_player")
function hsc.ai_command_list(encounterName, commandList)
end

---Tells a named unit to begin executing the specified command list.
---@param unitName unit
---@param commandList ai_command_list
---Example: hsc.ai_command_list_by_unit("keyesa10", "keyes_2")
function hsc.ai_command_list_by_unit(unitName, commandList)
end

---Tells a group of actors that are running a command list that they may advance further along the list
---(if they are waiting for a stimulus).
---@param encounterName ai
---Example: hsc.ai_command_list_advance("rocks/elites_2")
function hsc.ai_command_list_advance(encounterName)
end

---Just like ai_command_list_advance but operates upon a unit instead.
---@param unitName unit
---Example: hsc.ai_command_list_advance_by_unit("keyesa10")
function hsc.ai_command_list_advance_by_unit(unitName)
end

---Gets the status of a number of units running command lists.
---@param objectList object_list
---@return short | 0 = none, 1 = finished command list, 2 = waiting for stimulus, 3 = running command list
---@see hsc.ai_actors Go to reference
---Example: hsc.ai_command_list_status(hsc.ai_actors("rocks/elites_2"))
function hsc.ai_command_list_status(objectList)
end

---Returns whether a platoon is in the attacking mode (or if an encounter is specified, returns whether any platoon in that encounter is attacking).
---@param encounterName ai
---@return boolean
---Example: hsc.ai_is_attacking("rocks/elites_2")
function hsc.ai_is_attacking(encounterName)
end

---Forces an encounter to remain active (i.e. not freeze in place) even if there are no players nearby.
---@param encounterName ai
---@param bool boolean
---Example: hsc.ai_force_active("rocks/elites_2", true)
function hsc.ai_force_active(encounterName, bool)
end

---Forces a named actor that is NOT in an encounter to remain active (i.e. not freeze in place) even if there are no players nearby.
---@param unitName unit
---@param bool boolean
---Example: hsc.ai_force_active_by_unit("elite_1", true)
function hsc.ai_force_active_by_unit(unitName, bool)
end

---Sets the state that a group of actors will return to when they have nothing to do
---Idk what value is valid for "ai_default_state", this function was never used in Halo CE Campaign.
---@param encounterName ai
---@param aiDefaultState ai_default_state
---Example: hsc.ai_set_return_state("ext_c_cov/ghost_a", 0)
function hsc.ai_set_return_state(encounterName, aiDefaultState)
end

---Sets the current state of a group of actors. WARNING: may have unpredictable results on actors that are in combat
---Idk what value is valid for "ai_default_state", this function was never used in Halo CE Campaign.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param aiDefaultState ai_default_state An "AI Default State" value (a block in the scenario tag).
function hsc.ai_set_current_state(encounterName, aiDefaultState)
end

---Sets an encounter to be playfighting or not.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param isPlayfighting boolean @True to enable playfighting, false to disable.
-- Example: hsc.ai_playfight("crossfire_anti", true)
function hsc.ai_playfight(encounterName, isPlayfighting)
end

---Returns the most severe combat status of a group of actors 
---| 0 = "inactive"
---| 1 = "noncombat"
---| 2 = "guarding"
---| 3 = "search/suspicious"
---| 4 = "definite enemy(heard or magic awareness)"
---| 5 = "visible enemy"
---| 6 = "engaging in combat."
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@return short
---@see using_ai_status Usage example in context
---Example: hsc.ai_status("ext_c_cov/ghost_a")
function hsc.ai_status(encounterName)
end

---Reconnects all AI information to the current structure bsp (use this after you create encounters or command lists in sapien,
---or place new firing points or command list points).
---Note: Use after "ai_erase_all" and before "garbage_collect_now" functions.
function hsc.ai_reconnect()
end

---Sets a vehicle to 'belong' to a particular encounter/squad. any actors who get into the vehicle will be placed in this squad.
---NB: vehicles potentially drivable by multiple teams need their own encounter!.
---@param unitName unit Name of a unit in the scenario.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---Example: hsc.ai_vehicle_encounter("ext_a_dropship_wraith_a", "ext_a_area_a_wraith/squad_i")
function hsc.ai_vehicle_encounter(unitName, encounterName)
end

---Sets a vehicle as being impulsively enterable for actors within a certain distance. 
---@param unitName unit Name of the unit in the scenario.
---@param worldUnitsDistance real The distance in world units within which actors can enter the vehicle.
---Example: hsc.ai_vehicle_enterable_distance("warthog_1", 10.0)
function hsc.ai_vehicle_enterable_distance(unitName, worldUnitsDistance)
end

---Sets a vehicle as being impulsively enterable for actors of a certain team.
---Idk what value is valid for "team" parameter, maybe a string or an integer.
---@param unitName unit Name of a unit in the scenario.
---@param teamName team An "Encounters" enum value (a block in the scenario tag).
---Example: hsc.ai_vehicle_enterable_team("warthog_1", "human")
function hsc.ai_vehicle_enterable_team(unitName, teamName)
end

---Sets a vehicle as being impulsively enterable for actors of a certain type (grunt, elite, marine etc).
---@param unitName unit Name of a unit in the scenario.
---@param actorTypeName actor_type Enum value in actor tag (e.g. "marine", "elite", "grunt", etc).
---Example: hsc.ai_vehicle_enterable_actor_type("warthog_1", "marine")
function hsc.ai_vehicle_enterable_actor_type(unitName, actorTypeName)
end

---Sets a vehicle as being impulsively enterable for a certain encounter/squad of actors.
---@param unitName unit Name of a unit in the scenario.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---Example: hsc.ai_vehicle_enterable_actors("warthog_1", "encounter_name/squad_name")
function hsc.ai_vehicle_enterable_actors(unitName, encounterName)
end

---Disables actors from impulsively getting into a vehicle (this is the default state for newly placed vehicles).
---@param unitName unit Name of a unit in the scenario.
---Example: hsc.ai_vehicle_enterable_disable("cyborg_4")
function hsc.ai_vehicle_enterable_disable(unitName)
end

---Makes the specified unit look at the specified object.
---@param unitName unit Name of a unit in the scenario.
---@param objectName object Name of an object in the scenario.
---Example: hsc.ai_look_at_object("marine_1", "ghost_1")
function hsc.ai_look_at_object(unitName, objectName)
end

---Stops the specified unit from looking at anything.
---@param unitName unit Name of a unit in the scenario.
---Example: hsc.ai_stop_looking("marine_1")
function hsc.ai_stop_looking(unitName)
end

---Enables or disables a squad as being an automatic migration target.
---@param encounterName ai An "Encounters" name value (a block in the scenario tag).
---@param enableMigration boolean True to enable automatic migration, false to disable.
---Example: hsc.ai_automatic_migration_target("encounter_name/squad_name", true)
function hsc.ai_automatic_migration_target(encounterName, enableMigration)
end

---Turns off following for an encounter.
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---Example: hsc.ai_follow_target_disable("cliff_marine")
function hsc.ai_follow_target_disable(encounterName)
end

---Sets the follow target for an encounter to be the closest player.
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---Example: hsc.ai_follow_target_players("cliff_marine")
function hsc.ai_follow_target_players(encounterName)
end

---Sets the follow target for an encounter to be a specific unit.
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---@param unitTargetName unit Name of the unit to follow
---Example: hsc.ai_follow_target_unit("cliff_marine", "grunt_2")
function hsc.ai_follow_target_unit(encounterName, unitTargetName)
end

---Sets the follow target for an encounter to be a group of AI (encounter, squad or platoon).
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---@param encounterTargetName ai An "Encounters" value (a block in the scenario tag)
---Example: hsc.ai_follow_target_ai("cliff/marines_2", "rocks/grunts_1")
function hsc.ai_follow_target_ai(encounterName, encounterTargetName)
end

---Sets the distance threshold which will cause squads to migrate when following someone.
---@param encounterName ai An "Encounters" value (a block in the scenario tag)
---@param worldUnitsDistance real The distance threshold for migration
---Example: hsc.ai_follow_distance("cliff/marines_2", 5.0)
function hsc.ai_follow_distance(encounterName, worldUnitsDistance)
end

---Tries to add an entry to the list of conversations waiting to play. returns FALSE if the required units 
---could not be found to play the conversation, or if the player is too far away and the 'delay' flag is not set.
---@param aiConversationName conversation
---@return boolean
---Example: hsc.ai_conversation("intro_conversation")
---Output: returns TRUE if the conversation was successfully started, FALSE otherwise.
function hsc.ai_conversation(aiConversationName)
end

---Stops a conversation from playing or trying to play.
---@param aiConversationName conversation
---Example: hsc.ai_conversation_stop("intro_conversation")
function hsc.ai_conversation_stop(aiConversationName)
end

---Tells a conversation that it may advance.
---@param aiConversationName conversation
---Example: hsc.ai_conversation_advance("intro_conversation")
function hsc.ai_conversation_advance(aiConversationName)
end

---Returns which line the conversation is currently playing, or 999 if the conversation is not currently playing.
---@param aiConversationName conversation
---@return short
---Example: hsc.ai_conversation_line("intro_conversation")
function hsc.ai_conversation_line(aiConversationName)
end

---Returns the status of a conversation.
---| 0 = "none" 
---| 1 = "trying to begin" 
---| 2 = "waiting for guys to get in position" 
---| 3 = "playing" 
---| 4 = "waiting to advance" 
---| 5 = "could not begin" 
---| 6 = "finished successfully" 
---| 7 = "aborted midway"
---@param aiConversationName conversation
---@return short
---Example: hsc.ai_conversation_status("intro_conversation")
function hsc.ai_conversation_status(aiConversationName)
end

---Links the first encounter so that it will be made active whenever it detects that the second encounter is active.
---@param encounterName1 ai
---@param encounterName2 ai
---Example: hsc.ai_link_activation("rocks/elites_2", "woods/grunts1")
function hsc.ai_link_activation(encounterName1, encounterName2)
end

---Forces a group of actors to start or stop berserking.
---@param encounterName ai
---@param isBerserk boolean
---Example: hsc.ai_berserk("rocks/elites_2", true)
function hsc.ai_berserk(encounterName, isBerserk)
end

---Makes an encounter change to a new team.
---@param encounterName ai
---@param teamName team
---Example: hsc.ai_set_team("rocks/marines_2", "covenant")
function hsc.ai_set_team(encounterName, teamName)
end

---Either enables or disables charging behavior for a group of actors.
---@param encounterName ai
---@param isCharging boolean
---Example: hsc.ai_allow_charge("rocks/elites_2", true)
function hsc.ai_allow_charge(encounterName, isCharging)
end

---Either enables or disables automatic dormancy for a group of actors.
---@param encounterName ai
---@param isDormant boolean
---Example: hsc.ai_allow_dormant("rocks/elites_2", true)
function hsc.ai_allow_dormant(encounterName, isDormant)
end

---Returns whether two teams have an allegiance that is currently broken by traitorous behavior.
---@param teamName1 team
---@param teamName2 team
---@return boolean
---Example: hsc.ai_allegiance_broken(player, human)
function hsc.ai_allegiance_broken(teamName1, teamName2)
end

---Toggles script control of the camera.
---@param isTrue boolean
function hsc.camera_control(isTrue)
end

---Moves the camera to the specified camera point over the specified number of ticks.
---@param cameraPointName cutscene_camera_point
---@param ticksNumber short
---Example: hsc.camera_set("intro_camera_point", 30) -- Moves the camera to "intro_camera_point" over 30 ticks (1 second).
function hsc.camera_set(cameraPointName, ticksNumber)
end

---Moves the camera to the specified camera point over the specified number of ticks (position is relative to the specified object).
---@param cameraPointName cutscene_camera_point
---@param ticksNumber short
---@param objectName object
---Example: hsc.camera_set_relative("chief_lift_2a", 0, "chief_lift") -- Moves the camera to "chief_lift_2a" relative to "chief_lift" instantly.
function hsc.camera_set_relative(cameraPointName, ticksNumber, objectName)
end

---Begins a prerecorded camera animation.
---Idk how it works exactly, need to test it.
---@param modelAnimationPath animation_graph
---@param animationName string
---Example: hsc.camera_set_animation("models\cinematics\intro_camera\intro_camera", "intro_camera_anim") -- Plays the "intro_camera_anim" animation from the specified model animation graph.
function hsc.camera_set_animation(modelAnimationPath, animationName)
end

---Makes the scripted camera follow a unit.
---@param unitName unit
---Example: hsc.camera_set_third_person("masterchief") -- Makes the camera follow the "masterchief" unit in third-person view.
function hsc.camera_set_first_person(unitName)
end

---Makes the scripted camera zoom out around a unit as if it were dead.
---@param unitName unit
---Example: hsc.camera_set_dead("masterchief") -- Makes the camera zoom out around the "masterchief" unit as if it were dead.
function hsc.camera_set_dead(unitName)
end

---Returns the number of ticks remaining in the current camera interpolation.
---@return short
function hsc.camera_time()
end

---Loads the saved camera position and facing from camera_<map_name>.txt
function hsc.debug_camera_load()
end

---Saves the camera position and facing to camera_<map_name>.txt
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

---Changes the game speed (Only works in single-player).
---@param speedNumber real
---Example: hsc.game_speed(1.5) -- Sets the game speed to 1.5x normal speed.
function hsc.game_speed(speedNumber)
end

---Gets ticks elapsed since the start of the game.
---@return long
function hsc.game_time()
end

---Set the game engine.
---Idk how it works exactly, need to test it.
---@param engineName string
function hsc.game_variant(engineName)
end

-----@return game_difficulty
-- function hsc.game_difficulty_get() end

-----@return game_difficulty
-- function hsc.game_difficulty_get_real() end

---Starts the map from the beginning. (Only works in single-player).
function hsc.map_reset()
end

---Opens a map (This is intended for single-player maps)
---@param mapName string
---Example: hsc.map_name("a50_coop_evolved") -- Opens the "a50_coop_evolved" map.
function hsc.map_name(mapName)
end

---Opens a multiplayer map (Leftover from Halo CE, this function is deprecated).
---@deprecated
---@param mapName string
function hsc.multiplayer_map_name(mapName)
end

---Changes the difficulty setting for the next map to be loaded.
---@param difficultyName game_difficulty "easy = easy", "normal = normal", "hard = heroic", or "impossible = legendary".
---Example: hsc.game_difficulty_set("hard") -- Sets the game difficulty to "heroic" for the next map.
function hsc.game_difficulty_set(difficultyName)
end

---Crashes (for debugging).
---@param unknownString string
function hsc.crash(unknownString)
end

---Switch to a different structure bsp by it's index.
---@param bspIndex short
---Example: hsc.switch_bsp(1) -- Switches to the structure BSP with index 1.
function hsc.switch_bsp(bspIndex)
end

---Returns the current structure bsp index.
---@return short
function hsc.structure_bsp_index()
end

---Prints the build version.
function hsc.version()
end

---Starts game in film playback mode. (Huh?)
function hsc.playback()
end

---Quits the game.
function hsc.quit()
end

--function hsc.texture_cache_flush()
--end

--function hsc.sound_cache_flush()
--end

--function hsc.sound_cache_dump_to_file()
--end

---Displays the current pvs.
---@param displayPVS boolean
function hsc.debug_pvs(displayPVS)
end

---Starts radiosity computation.
function hsc.radiosity_start()
end

---Saves radiosity solution.
function hsc.radiosity_save()
end

---Tests sun occlusion at a point.
function hsc.radiosity_debug_point()
end

---Turns all AI on or off.
---@param turnAI boolean
function hsc.ai(turnAI)
end

---Turns impromptu dialogue on or off.
---@param improDialog boolean
function hsc.ai_dialogue_triggers(improDialog)
end

---Turns grenade inventory on or off.
---@param grenadeInventory boolean
function hsc.ai_grenades(grenadeInventory)
end

---Does a screen fade in from a particular color over a number of ticks.
---@param red real
---@param green real
---@param blue real
---@param ticksNumber short
function hsc.fade_in(red, green, blue, ticksNumber)
end

---Does a screen fade out to a particular color over a number of ticks.
---@param red real
---@param green real
---@param blue real
---@param ticksNumber short
function hsc.fade_out(red, green, blue, ticksNumber)
end

---Initializes game to start a cinematic (interruptive) cutscene.
function hsc.cinematic_start()
end

---Initializes the game to end a cinematic (interruptive) cutscene.
function hsc.cinematic_stop()
end

---Aborts a cinematic.
function hsc.cinematic_abort()
end

function hsc.cinematic_skip_start_internal()
end

function hsc.cinematic_skip_stop_internal()
end

---Sets or removes the letterbox bars.
---@param removesLetterboxBars boolean
function hsc.cinematic_show_letterbox(removesLetterboxBars)
end

---Activates the chapter title.
---@param cutsceneTitleName cutscene_title
---Example: hsc.cinematic_set_title("chapter_1_intro") -- Displays the "chapter_1_intro" title.
function hsc.cinematic_set_title(cutsceneTitleName)
end

---Activates the chapter title, delayed in seconds.
---@param cutsceneTitleName cutscene_title
---@param delayInSeconds real
---Example: hsc.cinematic_set_title_delayed("chapter_1_intro", 2.0) -- Displays the "chapter_1_intro" title after a delay of 2 seconds.
function hsc.cinematic_set_title_delayed(cutsceneTitleName, delayInSeconds)
end

---Suppresses or enables the automatic creation of objects during cutscenes due to a bsp switch.
---@param suppressObjects boolean
function hsc.cinematic_suppress_bsp_object_creation(suppressObjects)
end

-- function hsc.game_won() end

---Causes the player to revert to their previous saved game.
function hsc.game_lost()
end

---Returns FALSE if it would be a bad idea to save the player's game right now.
---@return boolean
function hsc.game_safe_to_save()
end

---Returns FALSE if there are bad guys around, projectiles in the air, etc.
---@return boolean
function hsc.game_all_quiet()
end

---Returns FALSE if it would be a bad idea to save the player's game right now.
---@return boolean
function hsc.game_safe_to_speak()
end

-----@return boolean
-- function hsc.game_is_cooperative() end

-----@return boolean
--function hsc.game_is_authoritative()
--end

-- function hsc.game_save() end

--function hsc.game_save_cancel()
--end

-- function hsc.game_save_no_timeout() end

-- function hsc.game_save_totally_unsafe() end

-----@return boolean
--function hsc.game_saving()
--end

--function hsc.game_revert()
--end

-----@return boolean
--function hsc.game_reverted()
--end

---Saves debug game state to "My Games\Halo CE\core\core.bin"
function hsc.core_save()
end

---Saves debug game state to My Games\Halo CE\core\<path>
---@deprecated Use hsc.core_save instead.
---@param pathName string path from core.bin to save to
---@return boolean
---Example: hsc.core_save_name("test_save") -- Saves the debug game state to "My Games\Halo CE\core\test_save.bin"
function hsc.core_save_name(pathName)
end

---Loads debug game state from "My Games\Halo CE\core\core.bin"
function hsc.core_load()
end

---Loads debug game state from "My Games\Halo CE\core\core.bin" as soon as the map is initialized
function hsc.core_load_at_startup()
end

---Loads debug game state from "My Games\Halo CE\core\<path>"
---@deprecated Use hsc.core_load instead.
---@param pathName string
function hsc.core_load_name(pathName)
end

---Loads debug game state from "My Games\Halo CE\core\<path>" as soon as the map is initialized
---@deprecated Use hsc.core_load_at_startup instead.
---@param pathName string
function hsc.core_load_name_at_startup(pathName)
end

-----@param arg1 string
-----@return boolean
--function hsc.mcc_mission_segment()
--end

---Skips an amount of game ticks. ONLY USE IN CUTSCENES!
---@param ticksNumber short
---Example: hsc.game_skip_ticks(60) -- Skips 60 ticks (2 seconds) of game time.
function hsc.game_skip_ticks(ticksNumber)
end

---Loads an impulse sound into the sound cache ready for playback.
---@param soundPath sound
---@param loadSound boolean
function hsc.sound_impulse_predict(soundPath, loadSound)
end

---Plays an impulse sound from the specified source object (or "none"), with the specified volume.
---@param soundPath sound
---@param objectName object | "none"
---@param soundVolume real
---Example: hsc.sound_impulse_start("sounds\explosion", "grenade_1", 1.0) -- Plays the "explosion" sound from the "grenade_1" object at full volume.
function hsc.sound_impulse_start(soundPath, objectName, soundVolume)
end

---Returns the time remaining for the specified impulse sound.
---@param soundPath sound
---@return long
function hsc.sound_impulse_time(soundPath)
end

---Stops the specified impulse sound.
---@param soundPath sound
function hsc.sound_impulse_stop(soundPath)
end

-----Your mom
-----@param arg1 looping_sound
--function hsc.sound_looping_predict()
--end

---Plays a looping sound from the specified source object (or "none"), with the specified scale.
---@param loopingSoundPath looping_sound
---@param objectName object | "none"
---@param soundVolume real
---Example: hsc.sound_looping_start("sounds\engine_loop", "warthog_1", 0.5) -- Plays the "engine_loop" sound from the "warthog_1" object at half volume.
function hsc.sound_looping_start(loopingSoundPath, objectName, soundVolume)
end

---Stops the specified looping sound.
---@param loopingSoundPath looping_sound
function hsc.sound_looping_stop(loopingSoundPath)
end

---Changes the volume of the sound within the range 0 to 1.
---@param loopingSoundPath looping_sound
---@param soundVolume real
---Example: hsc.sound_looping_set_scale("sounds\engine_loop", 0.8) -- Sets the volume of the "engine_loop" sound to 0.8.
function hsc.sound_looping_set_scale(loopingSoundPath, soundVolume)
end

---Enables or disables the alternate loop/alternate end for a looping sound.
---@param loopingSoundPath looping_sound
---@param isEnabled boolean
---Example: hsc.sound_looping_set_alternate("sounds\engine_loop", true) -- Enables the alternate loop/alternate end for the "engine_loop" sound.
function hsc.sound_looping_set_alternate(loopingSoundPath, isEnabled)
end

---Enables or disables all sound classes matching the substring.
---@param soundClass sound_classes
---@param isEnabled boolean
---Example: hsc.debug_sounds_enable("music", false) -- Disables all sound classes containing "music" in their name.
function hsc.debug_sounds_enable(soundClass, isEnabled)
end

---Enables or disables all sound.
---@param isEnabled boolean
function hsc.sound_enable(isEnabled)
end

---Set the game's master gain.
---@param masterGain real
---Example: hsc.sound_set_master_gain(0.8) -- Sets the game's master gain to 0.8.
function hsc.sound_set_master_gain(masterGain)
end

---Returns the game's master gain.
---@return real
function hsc.sound_get_master_gain()
end

---Set the game's music gain.
---@param musicGain real
---Example: hsc.sound_set_music_gain(0.8) -- Sets the game's music gain to 0.8.
function hsc.sound_set_music_gain(musicGain)
end

---Returns the game's music gain.
---@return real
function hsc.sound_get_music_gain()
end

---Set the game's effects gain.
---@param effectsGain real
---Example: hsc.sound_set_effects_gain(0.8) -- Sets the game's effects gain to 0.8.
function hsc.sound_set_effects_gain(effectsGain)
end

---Returns the game's effects gain.
---@return real
function hsc.sound_get_effects_gain()
end

---Changes the gain on the specified sound class(es) to the specified game over the specified number of ticks.
---@param soundClass sound_classes
---@param soundGain real
---@param soundDuration short
---Example: hsc.sound_class_set_gain("unit dialog", 0.5, 30) -- Sets the gain of the "unit dialog" sound class to 0.5 over 30 ticks (1 second).
function hsc.sound_class_set_gain(soundClass, soundGain, soundDuration)
end

---Stops the vehicle from running real physics and runs fake hovering physics instead.
---@param vehicleName vehicle Name of a vehicle in scenario tag.
---@param isHovering boolean True to enable fake hovering physics, false to disable.
---Example: hsc.vehicle_hover("pelican_1", true)
function hsc.vehicle_hover(vehicleName, isHovering)
end

---Resets zoom levels on all players.
function hsc.players_unzoom_all()
end

---Enables or disables player input. the player can still free-look, but nothing else.
---@param enablePlayerInput boolean
---Example: hsc.player_enable_input(false) -- Disables player input.
function hsc.player_enable_input(enablePlayerInput)
end

---Enables/disables camera control globally.
---@param enableCameraControl boolean
---@return boolean
function hsc.player_camera_control(enableCameraControl)
end

---Resets the player action test state so that all tests will return false.
function hsc.player_action_test_reset()
end

---Returns true if any player has jumped since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_jump()
end

---Returns true if any player has used primary trigger since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_primary_trigger()
end

---Returns true if any player has used grenade trigger since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_grenade_trigger()
end

---Returns true if any player has hit the zoom button since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_zoom()
end

---Returns true if any player has hit the action key since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_action()
end

---Returns true if any player has hit accept since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_accept()
end

---Returns returns true if any player has hit the back key since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_back()
end

---Returns true if any player has looked up since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_look_relative_up()
end

---Returns true if any player has looked down since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_look_relative_down()
end

---Returns true if any player has looked left since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_look_relative_left()
end

---Returns true if any player has looked right since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_look_relative_right()
end

---Returns true if any player has looked up, down, left, and right since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_look_relative_all_directions()
end

---Returns true if any player has moved forward, backward, left, and right since the last call to (player_action_test_reset).
---@return boolean
function hsc.player_action_test_move_relative_all_directions()
end

---Adds/resets the player's health, shield, and inventory (weapons and grenades) to the named profile. 
---Resets if third parameter is true, adds if false.
---@param unitName unit
---@param profileName profile
---@param isResetProfile boolean
---Example: hsc.player_add_equipment("masterchief", "spartan_mk_v", false) -- Adds the equipment from the "spartan_mk_v" profile to the "masterchief" unit.
---Example: hsc.player_add_equipment("masterchief", "spartan_mk_v", true) -- Resets the "masterchief" unit's equipment to the "spartan_mk_v" profile.
function hsc.player_add_equipment(unitName, profileName, isResetProfile)
end

-----@param arg1 short
-----@param arg2 short
--function hsc.debug_teleport_player()
--end

---Shows or hides the hud.
---@param isShowHud boolean
---@return boolean
function hsc.show_hud(isShowHud)
end

---Shows or hides the hud help text.
---@param isShowHelpText boolean
---@return boolean
function hsc.show_hud_help_text(isShowHelpText)
end

---Starts/stops the help text flashing
---@param isFlashing boolean
function hsc.enable_hud_help_flash(isFlashing)
end

---Resets the timer for the help text flashing
function hsc.hud_help_flash_restart()
end

---Activates a nav point attached to local player anchored to a flag with a vertical offset.
---If the player is not local to the machine, this will fail.
---@param navPointName navpoint
---@param unitName unit
---@param flagName cutscene_flag
---@param zOffset real
---Example: hsc.activate_nav_point_flag("default_red", "masterchief", "flag_objective_1", 2.0)
function hsc.activate_nav_point_flag(navPointName, unitName, flagName, zOffset)
end

---Activates a nav point attached to local player anchored to an object with a vertical offset. 
---If the player is not local to the machine, this will fail.
---@param navName navpoint
---@param unitName unit
---@param objectName object
---@param zOffset real
---Example: hsc.activate_nav_point_object("default_red", "masterchief", "objectives_marker_1", 2.0)
function hsc.activate_nav_point_object(navName, unitName, objectName, zOffset)
end

---Activates a nav point attached to a team anchored to a flag with a vertical offset.
---If the player is not local to the machine, this will fail.
---@param navPointName navpoint
---@param teamName team
---@param flagName cutscene_flag
---@param zOffset real
---Example: hsc.activate_team_nav_point_flag("default_red", "player", "flag_objective_1", 2.0)
function hsc.activate_team_nav_point_flag(navPointName, teamName, flagName, zOffset)
end

---Activates a nav point attached to a team anchored to an object with a vertical offset.
---If the player is not local to the machine, this will fail.
---@param navPointName navpoint
---@param teamName team
---@param objectName object
---@param zOffset real
---Example: hsc.activate_team_nav_point_object("default_red", "human", "pelican_2", 2.0)
function hsc.activate_team_nav_point_object(navPointName, teamName, objectName, zOffset)
end

---Deactivates a nav point attached to a player anchored to a flag.
---@param unitName unit
---@param flagName cutscene_flag
function hsc.deactivate_nav_point_flag(unitName, flagName)
end

---Deactivates a nav point attached to a player anchored to an object.
---@param unitName unit
---@param objectName object
function hsc.deactivate_nav_point_object(unitName, objectName)
end

---Deactivates a nav point attached to a team anchored to a flag.
---@param teamName team
---@param flagName cutscene_flag
function hsc.deactivate_team_nav_point_flag(teamName, flagName)
end

---Deactivates a nav point attached to a team anchored to an object.
---@param teamName team
---@param objectName object
function hsc.deactivate_team_nav_point_object(teamName, objectName)
end

---Clears console text from the screen.
function hsc.cls()
end

---Enables or disables the suppression of error spamming.
---@param isSuppressed boolean
function hsc.error_overflow_suppression(isSuppressed)
end

---Sets the maximum translation values for the player effect. Used for camera shaking.
---@param x real
---@param y real
---@param z real
function hsc.player_effect_set_max_translation(x, y, z)
end

---Sets the maximum rotation values for the player effect. Used for camera shaking?.
---@param yaw real
---@param pitch real
---@param roll real
function hsc.player_effect_set_max_rotation(yaw, pitch, roll)
end

---Sets the maximum vibration values for the player effect. Used for controller rumble?.
---@param left real
---@param right real
function hsc.player_effect_set_max_vibrate(left, right)
end

---Use player_effect_set_max_vibrate, this is only to keep compatibility with Custom Edition
---@param maxLow real
---@param maxHigh real
function hsc.player_effect_set_max_rumble(maxLow, maxHigh)
end

---Player effect start with specified intensity and attack time.
---@param maxIntensity real
---@param attackTime real
---@see hsc.real_random_range
---Example: hsc.player_effect_start(1.0, 0.5) -- Starts a player effect with maximum intensity of 1.0 and an attack time of 0.5 seconds.
---Example: hsc.player_effect_start(hsc.real_random_range(0.5, 1.0), 0.2) -- Starts a player effect with random intensity between 0.5 and 1.0 and an attack time of 0.2 seconds.
function hsc.player_effect_start(maxIntensity, attackTime)
end

---Player effect stop with specified release time.
---@param decayTime real
---@see hsc.real_random_range
---Example: hsc.player_effect_stop(0.5) -- Stops the player effect with a release time of 0.5 seconds.
---Example: hsc.player_effect_stop(hsc.real_random_range(0.2, 1.0)) -- Stops the player effect with a random release time between 0.2 and 1.0 seconds.
function hsc.player_effect_stop(decayTime)
end

---Hides/shows the health panel.
---@param IsShowHealth boolean
function hsc.hud_show_health(IsShowHealth)
end

---Starts/stops manual blinking of the health panel.
---@param IsBlinking boolean
function hsc.hud_blink_health(IsBlinking)
end

---Hides/shows the shield panel.
---@param IsShowShield boolean
function hsc.hud_show_shield(IsShowShield)
end

---Starts/stops manual blinking of the shield panel.
---@param IsBlinking boolean
function hsc.hud_blink_shield(IsBlinking)
end

---Hides/shows the motion sensor panel.
---@param IsShowMotionSensor boolean
function hsc.hud_show_motion_sensor(IsShowMotionSensor)
end

---Starts/stops manual blinking of the motion sensor panel.
---@param IsBlinking boolean
function hsc.hud_blink_motion_sensor(IsBlinking)
end

---Hides/shows the crosshair.
---@param IsShowCrosshair boolean
function hsc.hud_show_crosshair(IsShowCrosshair)
end

---Clears all non-state messages on the hud.
function hsc.hud_clear_messages()
end

---Displays a message as the help text.
---@param hudMessageName hud_message
function hsc.hud_set_help_text(hudMessageName)
end

---Sets a message as the current objective.
---@param hudMessageName hud_message
function hsc.hud_set_objective_text(hudMessageName)
end

---Sets the time for the timer to minutes and seconds, and starts and displays timer.
---@param minutes short
---@param seconds short
function hsc.hud_set_timer_time(minutes, seconds)
end

---Sets the warning time for the timer to minutes and seconds.
---@param minutes short
---@param seconds short
function hsc.hud_set_timer_warning_time(minutes, seconds)
end

---Sets the timer position on screen.
---@param x short
---@param y short
---@param anchorOffset hud_corner
---Example: hsc.hud_set_timer_position(100, 50, "top_right") -- Sets the hud timer position to (100, 50) relative to the top-right corner of the screen.
function hsc.hud_set_timer_position(x, y, anchorOffset)
end

---Displays the hud timer.
---@param isShowHudTimer boolean
function hsc.show_hud_timer(isShowHudTimer)
end

---Pauses or unpauses the hud timer.
---@param isPauseHudTimer boolean
function hsc.pause_hud_timer(isPauseHudTimer)
end

---Returns the ticks left on the hud timer.
---@return short
function hsc.hud_get_timer_ticks()
end

---Shows the time code timer.
---@param isShowTimeCodeTimer boolean
function hsc.time_code_show(isShowTimeCodeTimer)
end

---Starts/stops the time code timer.
---@param isStart boolean
function hsc.time_code_start(isStart)
end

---Resets the time code timer.
function hsc.time_code_reset()
end

---Reloads the transparent chicago shaders.
function hsc.reload_shader_transparent_chicago()
end

---Check for shader changes.
function hsc.rasterizer_reload_effects()
end

---Flush all decals.
function hsc.rasterizer_decals_flush()
end

---Average fps.
function hsc.rasterizer_fps_accumulate()
end

---Sets the tint color for ambient reflection on models.
---@param alpha real
---@param red real
---@param green real
---@param blue real
function hsc.rasterizer_model_ambient_reflection_tint(alpha, red, green, blue)
end

---Reset lights for new map.
function hsc.rasterizer_lights_reset_for_new_map()
end

---Sets a screen effect script value.
---Idk what are the values for.
---@param value1 short
---@param value2 real
function hsc.script_screen_effect_set_value(value1, value2)
end

---Starts screen effect; pass TRUE to clear
---@param isStart boolean
function hsc.cinematic_screen_effect_start(isStart)
end

---Sets the convolution effect parameters.
---@param bias short higher values smoother image but worse framerate
---@param blurType short 0 = no blur, 1 = radial blur, 2 = gaussian blur
---| 0 = "no blur"
---| 1 = "radial blur"
---| 2 = "gaussian blur"
---@param startBlurPercent real
---@param endBlurPercent real
---@param transitionTicks real
---Example: hsc.cinematic_screen_effect_set_convolution(0, 1, 0.0, 1.0, 30)
---Sets the convolution effect to type 1 (radial blur) with a bias of 0, starting at 0% blur and ending at 100% blur over 30 ticks (1 second).
function hsc.cinematic_screen_effect_set_convolution(bias, blurType, startBlurPercent, endBlurPercent, transitionTicks)
end

---Sets the filter effect.
---Idk what the parameters do. Need more research.
---@param startGammaPercent real
---@param endGammaPercent real
---@param startTintPercent real
---@param endTintPercent real
---@param AdditiveBlend boolean
---@param transitionTicks real
---Example: hsc.cinematic_screen_effect_set_filter(0.5, 1.0, 0.0, 1.0, false, 30)
---Sets the filter effect to start at 50% gamma and 0% tint, ending at 100% gamma and 100% tint over 30 ticks (1 second), with no additive blending.
function hsc.cinematic_screen_effect_set_filter(startGammaPercent, endGammaPercent, startTintPercent, endTintPercent, AdditiveBlend, transitionTicks)
end

---Sets the desaturation filter tint color.
---@param red real
---@param green real
---@param blue real
---Example: hsc.cinematic_screen_effect_set_filter_desaturation_tint(1.0, 0.0, 0.0)
---Sets the desaturation filter tint color to red.
function hsc.cinematic_screen_effect_set_filter_desaturation_tint(red, green, blue)
end

---Sets the video effect: <noise intensity[0,1]>, <overbright: 0=none, 1=2x, 2=4x>
---@param noiseIntensity short
---@param overbright real 0 = none, 1 = 2x, 2 = 4x
---| 0 = "none"
---| 1 = "2x"
---| 2 = "4x"
function hsc.cinematic_screen_effect_set_video(noiseIntensity, overbright)
end

---Returns control of the screen effects to the rest of the game.
function hsc.cinematic_screen_effect_stop()
end

---Sets the near clip distance for cinematics.
---@param nearClipDistance real
function hsc.cinematic_set_near_clip_distance(nearClipDistance)
end

---Inverts player0's look.
---@param isLookInvert boolean
function hsc.player0_look_invert_pitch(isLookInvert)
end

---Returns TRUE if player0's look pitch is inverted.
---@return boolean
function hsc.player0_look_pitch_is_inverted()
end

---Returns TRUE if player0 is using the normal joystick set.
---@return boolean
function hsc.player0_joystick_set_is_normal()
end

---Show or hide the ui widget path.
---@param isShow boolean
function hsc.ui_widget_show_path(isShow)
end

---Display in-game help dialog.
---@param isHelpDisplay short
function hsc.display_scenario_help(isHelpDisplay)
end

---Enable or disable EAX extensions.
---@param isEnable boolean
function hsc.sound_enable_eax(isEnable)
end

---Returns true if EAX extensions are enabled.
---@return boolean
function hsc.sound_eax_enabled()
end

---Change environment preset.
---Idk what "preset" value is for.
---@param preset short
function hsc.sound_set_env(preset)
end

---Enable or disable hardware sound buffers.
---Idk if this values are correct.
---@param isEnable boolean
---@param is3D boolean
function hsc.sound_enable_hardware(isEnable, is3D)
end

---Set the amount of supplementary buffers.
---Idk what this function is for, neither the values means of.
---@param supplementaryBuffers short
---@param isActive boolean
function hsc.sound_set_supplementary_buffers(supplementaryBuffers, isActive)
end

---Returns the amount of supplementary buffers.
---@return short
function hsc.sound_get_supplementary_buffers()
end

---Set the DSound rolloff value.
---@param rolloff real
function hsc.sound_set_rolloff(rolloff)
end

---Set the sound factor value.
---@param factor real
function hsc.sound_set_factor(factor)
end

---Gets the yaw rate for the given player number.
---@param playerNumber short
---@return real
function hsc.get_yaw_rate(playerNumber)
end

---Gets the pitch rate for the given player number.
---@param playerNumber short
---@return real
function hsc.get_pitch_rate(playerNumber)
end

---Sets the yaw rate for the given player number.
---@param playerNumber short
---@param yawRate real
function hsc.set_yaw_rate(playerNumber, yawRate)
end

---Sets the pitch rate for the given player number.
---@param playerNumber short
---@param pitchRate real
function hsc.set_pitch_rate(playerNumber, pitchRate)
end

---Binds an input device/button combination to a game control.
---Idk what are the valid values for this function.
---@param device string
---@param button string
---@param control string
function hsc.bind(device, button, control)
end

---Unbinds an input device/button combination.
---@param device string
---@param button string
function hsc.unbind(device, button)
end

---Prints a list of all input bindings.
function hsc.print_binds()
end

---Opens a multiplayer map with a specified gametype.
---@param mapName string
---@param gameType string
---Example: hsc.sv_map("bloodgulch", "slayer") -- Opens the "bloodgulch" map with the "slayer" gametype.
function hsc.sv_map(mapName, gameType)
end

---Load any included builtin profiles and create profiles on disk.
---Idk what means this value.
---@param profile string
function hsc.profile_load(profile)
end

---Save a checkpoint.
function hsc.checkpoint_save()
end

---load a saved checkpoint.
---Idk what does checkpointName value.
---@param checkpointName string
function hsc.checkpoint_load(checkpointName)
end

-----Prints the specified boolean with the format '<string> = '<boolean>' to the Shell.
-----@param boolName string
-----@param boolValue boolean
--function hsc.TestPrintBool(boolName, boolValue)
--end

-----@param arg1 string
-----@param arg2 real
--function hsc.TestPrintReal()
--end

---Places lens flares in the structure bsp.
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
-- Example sintaxis in Lua
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
        print("AI Status {}: ", hsc.ai_status("encounter"))
    end
end

statusCombat.guarding = hsc.ai_status("encounter/squad")