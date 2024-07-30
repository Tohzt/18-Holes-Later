extends Node

# Default Settings
var MOUSE_SENSITIVITY : float = 0.4

# Saved Scenes
const SCENE_COURSE    = "res://Scenes/Course/course.tscn"
const SCENE_LOADING   = "res://Scenes/Loading/loading.tscn"
const SCENE_CLUBHOUSE = "res://Scenes/Clubhouse/clubhouse.tscn"

# Spawnables
const DISC    = preload("res://Objects/Disc/disc.tscn")
const HOLE_01 = preload("res://Scenes/Holes/Hole_01/hole_01.tscn")
const CHAR_BENNY = preload("res://Entities/Character/character.tscn")
const MENU_PAUSE = preload("res://Scenes/Pause_Menu/pause_menu.tscn")

var Scene: String
var Current_Hole: PackedScene = HOLE_01

var disc_bag: Array[Array] = []
var game_disc_index: int = -1
var is_paused: bool = false

func _ready():
	pass

func _process(_delta):
	# TODO: Works every other press
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if is_paused else Input.MOUSE_MODE_VISIBLE

func init_current_hole() -> Node3D:
	var hole = Current_Hole.instantiate()
	return hole
 
func init_player(spawn_pos) -> Entity:
	var player = CHAR_BENNY.instantiate()
	player.position = spawn_pos
	return player

func go_to_scene(next_scene: String):
	Scene = next_scene
	get_tree().change_scene_to_file(SCENE_LOADING)
	
func go_to_course(next_scene: String, next_hole: PackedScene):
	Scene = next_scene
	Current_Hole  = next_hole
	go_to_scene(Scene)
