-- SPDX-License-Identifier: GPL-3.0-only

---@meta _
---@diagnostic disable 

---@version 1.0.0

-------------------------------------------------------
-- Alias
-------------------------------------------------------

---@alias passthrough any

---@alias real number
---@alias short integer
---@alias long integer

---@alias game_difficulty string
---@alias strings string wtf is this?
---@alias object_list string Any object or object
---@alias ai_command_list string Name of an AI command list in the current scenario

---@alias trigger_volume string Name of a trigger volume in the current scenario
---@alias cutscene_flag string Name of a cutscene flag in the current scenario
---@alias sound_scenery string
---@alias actor_variant string
---@alias object_name string
---@alias animation_graph string
---@alias cutscene_recording string
---@alias cutscene_camera_point string
---@alias navpoint string
---@alias effect string
---@alias damage string
---@alias sound string
---@alias looping_sound string

---@alias object_definition object
---| "biped" 
---| "vehicle"
---| "weapon"
---| "equipment"
---| "scenery"
---| "device"
---| "projectile"
---| "placeholder"
---| "garbage"

---@alias device_group string
---@alias object string
---@alias item object
---@alias weapon item
---@alias equipment item
---@alias garbage item
---@alias scenery object
---@alias placeholder object
---@alias projectile object
---@alias device object
---@alias unit object
---@alias biped unit
---@alias vehicle unit

---@alias ai string # Name of an encounter from the current scenario
---| "encounter" # Enter an Encounter name
---| "encounter/squad" # Enter an Encounter/Squad name
---| "squad" # Enter a Squad name
---| "platoon" # Enter a Platoon name

---@alias conversation string # Name of a conversation from the current scenario

---@alias actor_type
---| "elite" # Select Elite
---| "jackal" # Select Jackal
---| "grunt" # Select Grunt
---| "hunter" # Select Hunter
---| "engineer" # Select Engineer
---| "assassin" # Select Assassin
---| "player" # Select Player
---| "marine" # Select Marine
---| "crew" # Select Crew
---| "combat_form" # Select Combat Form
---| "infection_form" # Select Infection Form
---| "carrier_form" # Select Carrier Form
---| "monitor" # Select Monitor
---| "sentinel" # Select Sentinel
---| "none" # Select None
---| "mounted_weapon" # Select Mounted Weapon


---@alias team
---| "default" # Select Default by Unit 
---| "player" # Select Player
---| "human" # Select Human
---| "covenant" # Select Covenant
---| "flood" # Select Flood
---| "sentinel" # Select Sentinel

---@alias hud_corner
---| "top_left" # Select Top Left
---| "top_right" # Select Top Right
---| "bottom_left" # Select Bottom Left
---| "bottom_right" # Select Bottom Right

---@alias hud_message string

---@alias sound_classes
---| "projectile impact" # Projectile impact sound
---| "projectile detonation" # Projectile explosion or detonation
---| "weapon fire" # Weapon firing
---| "weapon ready" # Weapon ready or draw
---| "weapon reload" # Weapon reload
---| "weapon empty" # Weapon empty click
---| "weapon charge" # Weapon charging
---| "weapon overheat" # Weapon overheating
---| "weapon idle" # Weapon idle loop
---| "object impacts" # General object collisions
---| "particle impacts" # Particle collision sounds
---| "slow particle impacts" # Slow or heavy particle impacts
---| "unit footsteps" # Footsteps sounds
---| "unit dialog" # Unit dialog voice lines
---| "vehicle collision" # Vehicle collision impacts
---| "vehicle engine" # Vehicle engine sounds
---| "device door" # Door mechanisms
---| "device force field" # Energy shield or field effects
---| "device machinery" # Device machinery sounds
---| "device nature" # Device ambient/nature-like sounds
---| "device computers" # Device or computer terminal sounds
---| "music" # Music or soundtrack
---| "ambient nature" # Environmental nature ambience
---| "ambient machinery" # Ambient mechanical hums
---| "ambient computers" # Ambient computer beeps or hums
---| "first person damage" # First-person hit or damage sound
---| "scripted dialog player" # Scripted player dialog
---| "scripted effect" # Scripted effect sounds
---| "scripted dialog other" # Other scripted dialog
---| "scripted dialog force unspatialized" # Non-positional scripted dialog
---| "game event" # General game event sound

---@alias cutscene_title string
---@alias profile string