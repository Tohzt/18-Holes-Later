extends Node

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
# References
@onready var Refs: ReferenceClass = $References
# Default/Debug Settings
@onready var Debug_Settings: DebugSettingsClass = $DebugSettings
@onready var Settings: SettingsClass = $Settings

@onready var Cameraman: Node3D = $Global_Tripod

var Scene: String
var HUD: HUD_Class
var Current_Hole: PackedScene
var Active_Hole: Node3D
var Hole_Name: String = ""
var Player: Entity_Character
var Profile: String = ""
var should_load: bool = false
var _temp_bag: Array[Disc]

var game_on = false
var hole_over = false
var selected_disc = 1
var is_paused: bool = 	false

func _process(_delta):
	
	if !HUD:
		HUD = get_tree().get_first_node_in_group("HUD")
	if !Active_Hole:
		Active_Hole = get_tree().get_first_node_in_group("Hole")

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

func select_next_disc():
	# TODO: Recursively check if disc is in bag
	selected_disc += 1
	if selected_disc > 3:
		selected_disc = 1_

func save_game(profile): $SaveController.save_game(profile)
func load_game(profile): $SaveController.load_game(profile)

func store_disc_in_bag(disc):
	print(disc, 'from global going to bag')
	
	 

# TODO: Might be useful
#func get_nearest_object(origin: Node3D, group: String) -> Node3D:
	#var objects_in_group = get_tree().get_nodes_in_group(group)
	#
	#if objects_in_group.is_empty():
		#return null
	#
	#var nearest_object: Node3D = null
	#var min_distance: float = INF
	#
	#for obj in objects_in_group:
		#if obj is Node3D:
			#var distance = origin.global_position.distance_to(obj.global_position)
			#if distance < min_distance:
				#min_distance = distance
				#nearest_object = obj
	#
	#return nearest_object
