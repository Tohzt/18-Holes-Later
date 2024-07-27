extends Node

var MOUSE_SENSITIVITY : float = 0.4
const GAME_SCENE = "res://Scenes/Game/game.tscn"
const DISC = preload("res://Objects/Disc/disc.tscn")
var Player : CharacterBody3D
var Scene : Node
#var Last_Hole = "res://Scenes/Holes/Hole_01/hole_01.tscn"

var game_disc_index: int
var Bag: Array

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Scene = get_tree().root.get_child(1)

func _process(_delta):
	if Input.is_action_just_pressed("tab"):
		game_disc_index += 1
		if game_disc_index >= Bag.size():
			game_disc_index = 0
		check_bag()
	
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

func add_disc(_disc):
	Bag.append(_disc)
	check_bag()

func check_bag():
	pass
	#print("Bag Content: ", Bag)


