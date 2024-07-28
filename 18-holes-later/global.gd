extends Node

# Default Settings
var MOUSE_SENSITIVITY : float = 0.4

# Saved Schenes
const SCENE_GAME      = "res://Scenes/Game/game.tscn"
const SCENE_LOADING   = "res://Scenes/Loading/loading.tscn"
const SCENE_CLUBHOUSE = "res://Scenes/Clubhouse/Clubhouse.tscn"
const SCENE_HOLE_01   = "res://Scenes/Holes/Hole_01/hole_01.tscn"
var scene_selected: String
var scene_current:  String
var Scene:  Node

var current_hole: Node3D

# Player Stats
var Profile: String = ""
var Player: CharacterBody3D
# TODO: Should be in player or game object

const DISC = preload("res://Objects/Disc/disc.tscn")
var Bag: Array
var game_disc_index: int

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Scene = get_tree().root.get_child(1)

func _process(_delta):
	#if Input.is_action_just_pressed("tab"):
		#game_disc_index += 1
		#if game_disc_index >= Bag.size():
			#game_disc_index = 0
		#_check_bag()
	
	if !Player: 
		Player = get_tree().get_first_node_in_group("Player")
		if  Player:
			Scene = get_tree().root.get_child(1)
	else: return
	

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func go_to_scene(scene):
	scene_current = scene
	get_tree().change_scene_to_file(Global.SCENE_LOADING)

func add_disc(_disc):
	Bag.append(_disc)
	_check_bag()

func _check_bag():
	print("Bag Content: ", Bag)


