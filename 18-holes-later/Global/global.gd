extends Node

# Default Settings
@onready var Debug_Settings = $DebugSettings
var MOUSE_SENSITIVITY : float = 0.4

# Saved Scenes
const SCENE_MAIN      = "res://Scenes/Main_Menu/main_menu.tscn"
const SCENE_COURSE    = "res://Scenes/Course/course.tscn"
const SCENE_LOADING   = "res://Scenes/Loading/loading.tscn"
const SCENE_CLUBHOUSE = "res://Scenes/Clubhouse/clubhouse.tscn"

# Spawnables
const TESTING_ROOM = preload("res://Scenes/Holes/TESTING/testing_room.tscn")
const HOLE_01      = preload("res://Scenes/Holes/Hole_01/hole_01.tscn")
const DISC         = preload("res://Objects/Disc/disc.tscn")
const CHAR_BENNY   = preload("res://Entities/Character/character.tscn")
const MENU_PAUSE   = preload("res://Scenes/Pause_Menu/pause_menu.tscn")
const TREE         = preload("res://Objects/Trees/tree.tscn")

var Active_Camera: Camera3D

var Scene: String
var Current_Hole: PackedScene = HOLE_01
var Active_Hole: Node3D
var Hole_Name: String = ""
var Player: Entity
var Profile: String = ""
var should_load: bool = false

var game_on = false
var selected_disc = 1
var bag_of_discs: Array[Array] = []
var game_disc_index: int = -1
var is_paused: bool = 	false

func _process(_delta):
	if !Active_Hole:
		Active_Hole = get_tree().get_first_node_in_group("Hole")
		
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED

func init_current_hole() -> Node3D:
	var hole = Current_Hole.instantiate()
	return hole
 
func init_player(spawn_pos) -> Entity:
	var new_player = CHAR_BENNY.instantiate()
	Player = new_player
	Player.position = spawn_pos
	if bag_of_discs:
		Player.bag_of_discs = bag_of_discs
		Player.game_disc_index = game_disc_index
	return Player

func go_to_scene(next_scene: String):
	Scene = next_scene
	get_tree().change_scene_to_file(SCENE_LOADING)
	
func go_to_course(next_scene: String, next_hole: PackedScene, hole_name: String):
	Scene = next_scene
	Current_Hole  = next_hole
	Hole_Name = hole_name
	go_to_scene(Scene)

# TODO: ... Do something with this
func change_camera_to():
	for _camera: Camera3D in get_tree().get_nodes_in_group("Camera"):
		if _camera.current:
			Active_Camera = _camera

var camera: Camera3D
var screen_position = Vector2(50.0, 50.0)  # 100 pixels from left and top
var distance_from_camera = 1.0  # Adjust this value as needed
var hud_gap = 50

func select_next_disc():
	# TODO: Recursively check if disc is in bag
	selected_disc += 1
	if selected_disc > 3:
		selected_disc = 1

func add_disc_to_bag(disc):
	if !camera and Player.Tripod.Camera:
		camera = Player.Tripod.Camera
	var screen_size = get_viewport().size
	screen_position = Vector2(50 + (hud_gap * disc.index), screen_size.y - 50)
	# Project a ray from the camera into the world
	var from = camera.project_ray_origin(screen_position)
	var to = from + camera.project_ray_normal(screen_position) * distance_from_camera
	# Set the position of this node
	disc.global_transform.origin = to
	# Make the object perpendicular to the camera direction
	var camera_forward = -camera.global_transform.basis.z
	var up_vector = camera_forward
	var right_vector = camera_forward.cross(Vector3.UP).normalized()
	var forward_vector = up_vector.cross(right_vector).normalized()
	# Set rotation and scale
	disc.global_transform.basis = Basis(right_vector, up_vector, forward_vector)
	disc.scale = Vector3(0.25, 0.25, 0.25)
