extends Node3D

@onready var holes = $"Holes"

var Player : CharacterBody3D
var Cam : SpringArm3D

@onready var game_disc_index: int = Global.game_disc_index
@onready var Bag: Array = Global.Bag
@export var _Gem:Gem

func _ready():
	_set_hole()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_node("Player")
	Cam = Player.get_node("SpringArm3D")
	if Global.Profile:
		load_game(Global.Profile)

func _process(_delta):
	pass

func _set_hole():
	for hole in holes.get_children():
		hole.queue_free()
	var new_hole = holes.build_hole("Hole_01")
	holes.add_child(new_hole)

func save_game():
	$SaveController.save_game()
	
func load_game(profile):
	$SaveController.load_game(profile)
