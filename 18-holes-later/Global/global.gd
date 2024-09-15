extends Node

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
# References
@onready var Refs: ReferenceClass = $References
# Default/Debug Settings
@onready var Debug_Settings: DebugSettingsClass = $DebugSettings
@onready var Settings: SettingsClass = $Settings

@onready var Cameraman = $Global_Tripod

var Scene: String
var HUD: HUD_Class
var Current_Hole: PackedScene
var Active_Hole: Node3D
var Hole_Name: String = ""
var Player: Entity
var Profile: String = ""
var should_load: bool = false

var game_on = false
var hole_over = false
var selected_disc = 1
var is_paused: bool = 	false

func _process(_delta):
	if !HUD:
		HUD = get_tree().get_first_node_in_group("HUD")
	if !Active_Hole:
		Active_Hole = get_tree().get_first_node_in_group("Hole")
		
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED

func init_current_hole() -> Node3D:
	var hole = Current_Hole.instantiate()
	return hole
 
func init_player(spawn_pos) -> Entity:
	var new_player = Refs.CHAR_BENNY.instantiate()
	Player = new_player
	Player.position = spawn_pos
	return Player

func go_to_scene(next_scene: String):
	Scene = next_scene
	get_tree().change_scene_to_file(Refs.SCENE_LOADING)
	
func go_to_course(next_scene: String, next_hole: PackedScene, hole_name: String):
	Scene = next_scene
	Current_Hole  = next_hole
	Hole_Name = hole_name
	go_to_scene(Scene)

var screen_position = Vector2(50.0, 50.0)  # 100 pixels from left and top
var distance_from_camera = 1.0  # Adjust this value as needed
var hud_gap = 50

func select_next_disc():
	# TODO: Recursively check if disc is in bag
	selected_disc += 1
	if selected_disc > 3:
		selected_disc = 1_

func save_game(profile): $SaveController.save_game(profile)
func load_game(profile): $SaveController.load_game(profile)
