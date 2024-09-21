extends Node3D

@onready var Holes = $Holes
var current_hole: Node3D

# Character Stats
var Character : CharacterBody3D
var Character_Cam : SpringArm3D

func _ready():
	if Global.should_load:
		Global.load_game(Global.Profile)
		return
	add_hole()
	add_player()

func _process(_delta):
	pass

func add_hole():
	Holes.add_child(Holes.build_hole(Global.Hole_Name))
	#Holes.add_child(Global.init_current_hole())

func add_player():
	var spawn_pos = Holes.get_child(-1).get_node("Player_Spawn").position
	add_child(Global.init_player(spawn_pos))
