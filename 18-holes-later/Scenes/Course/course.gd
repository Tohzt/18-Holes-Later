extends Node3D

@onready var Holes = $Holes
var current_hole: Node3D

# Character Stats
@export var profile: String = ""
var Character : CharacterBody3D
var Character_Cam : SpringArm3D

func _ready():
	add_hole()
	add_player()

func _process(_delta):
	pass

func add_hole():
	Holes.add_child(Global.init_current_hole())

func add_player():
	var spawn_pos = Holes.get_child(-1).player_spawn.position
	add_child(Global.init_player(spawn_pos))

func save_game(profile): $SaveController.save_game(profile)
func load_game(profile): $SaveController.load_game(profile)
