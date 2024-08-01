extends Node

# Default Settings
var MOUSE_SENSITIVITY : float = 0.4

# Saved Scenes
const SCENE_COURSE    = "res://Scenes/Course/course.tscn"
const SCENE_LOADING   = "res://Scenes/Loading/loading.tscn"
const SCENE_CLUBHOUSE = "res://Scenes/Clubhouse/clubhouse.tscn"

# Spawnables
const HOLE_CIRCLE = preload("res://Scenes/Holes/Hole_Circle/hole_circle.tscn")
const HOLE_01 = preload("res://Scenes/Holes/Hole_01/hole_01.tscn")
const DISC    = preload("res://Objects/Disc/disc.tscn")
const CHAR_BENNY = preload("res://Entities/Character/character.tscn")
const MENU_PAUSE = preload("res://Scenes/Pause_Menu/pause_menu.tscn")

var Active_Camera: Camera3D

var Scene: String
var Current_Hole: PackedScene = HOLE_01
var Player: Entity

var disc_bag: Array[Array] = []
var game_disc_index: int = -1
var is_paused: bool = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED

func init_current_hole() -> Node3D:
	var hole = Current_Hole.instantiate()
	return hole
 
func init_player(spawn_pos) -> Entity:
	var new_player = CHAR_BENNY.instantiate()
	Player = new_player
	new_player.position = spawn_pos
	return new_player

func go_to_scene(next_scene: String):
	Scene = next_scene
	get_tree().change_scene_to_file(SCENE_LOADING)
	
func go_to_course(next_scene: String, next_hole: PackedScene):
	Scene = next_scene
	Current_Hole  = next_hole
	go_to_scene(Scene)

func change_camera_to(new_perspective: String):
	for camera: Camera3D in get_tree().get_nodes_in_group("Camera"):
		camera.current = false
		if camera.is_in_group(new_perspective):
			Active_Camera = camera
			camera.current = true
