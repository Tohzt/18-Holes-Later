extends Node

var MOUSE_SENSITIVITY : float = 0.4
const DISC = preload("res://Objects/Disc/disc.tscn")
var Player : CharacterBody3D
var Scene : Node

var debug_stats = [13,5,-1,3]

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Scene = get_tree().root.get_child(1)

func _process(_delta):
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
	
