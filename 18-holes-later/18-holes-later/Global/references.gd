class_name ReferenceClass
extends Node

# Saved Scenes
const SCENE_MAIN = "res://Scenes/Main_Menu/main_menu.tscn"
const SCENE_COURSE = "res://Scenes/Course/course.tscn"
const SCENE_LOADING = "res://Scenes/Loading/loading.tscn"
const SCENE_CLUBHOUSE = "res://Scenes/Clubhouse/clubhouse.tscn"

# Scenes/Holes
const CLUBHOUSE_INTERIOR = preload("res://Scenes/Clubhouse/Interior/clubhouse_interior.tscn")
const TESTING_ROOM = preload("res://Scenes/Holes/TESTING/testing_room.tscn")
const MENU_PAUSE = preload("res://Scenes/Pause_Menu/pause_menu.tscn")
const HOLE_01 = preload("res://Scenes/Holes/Hole 01/hole_3d.tscn")

# Spawnables
const TREE = preload("res://Objects/Trees/tree_1.tscn")
const TARGET_MARKER = preload("res://Scenes/UI/Target Marker/target_marker.tscn")

# Characters
const CHARACTER = preload("res://Entities/Character/character.tscn")
const LAYLA = preload("res://Entities/Character/Layla/anim_layla.tscn")
const BENNY = preload("res://Entities/Character/Benny/anim_benny.tscn")

# Disc Things
const DISC = preload("res://Objects/Discs/Disc_CharBod/disc_charbod.tscn")
const PICKUP = preload("res://Objects/Discs/Pickup/pickup_area.tscn")
const DISC_TRACE = preload("res://Objects/Discs/Trace/disc_trace.tscn")

# Gems
@onready var GEM_BLOOD   = preload("res://Objects/Gem Object/src/gem_blood.tres")
@onready var GEM_CRIMSON = preload("res://Objects/Gem Object/src/gem_crimson.tres")
@onready var GEM_GREEN   = preload("res://Objects/Gem Object/src/gem_green.tres")
@onready var GEM_ORANGE  = preload("res://Objects/Gem Object/src/gem_orange.tres")
@onready var GEM_PINK    = preload("res://Objects/Gem Object/src/gem_pink.tres")
@onready var GEM_RED     = preload("res://Objects/Gem Object/src/gem_red.tres")
@onready var GEM_WATER   = preload("res://Objects/Gem Object/src/gem_water.tres")
@onready var GEM_YELLOW  = preload("res://Objects/Gem Object/src/gem_yellow.tres")
@onready var GEM_ARRAY = [GEM_BLOOD, GEM_CRIMSON, GEM_GREEN, GEM_ORANGE, GEM_PINK, GEM_RED, GEM_WATER, GEM_YELLOW]
