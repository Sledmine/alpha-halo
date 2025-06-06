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

---@alias strings string wtf is this?
---@alias object_list string Any object or object
---@alias trigger_volume string Name of a trigger volume in the current scenario
---@alias cutscene_flag string Name of a cutscene flag in the current scenario
---@alias sound_scenery string
---@alias actor_variant string
---@alias object_name string
---@alias animation_graph string
---@alias cutscene_recording string
---@alias navpoint string
---@alias effect string
---@alias damage string
---@alias object_definition string
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

---@alias ai string Name of an encounter from the current scenario
---| "encounter" # Enter an Encounter name
---| "encounter/squad" # Enter an Encounter/Squad name
---| "squad" # Enter a Squad name


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
---| "default_by_unit" # Select Default by Unit 
---| "player" # Select Player
---| "human" # Select Human
---| "covenant" # Select Covenant
---| "flood" # Select Flood
---| "sentinel" # Select Sentinel

---@alias hud_corner
---| "top-left" # Select Top Left
---| "top-right" # Select Top Right
---| "bottom-left" # Select Bottom Left
---| "bottom-right" # Select Bottom Right