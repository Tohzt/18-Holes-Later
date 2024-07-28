extends Node3D

var Player : CharacterBody3D
var Cam : SpringArm3D

@onready var game_disc_index: int = Global.game_disc_index
@onready var Bag: Array = Global.Bag

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_node("Player")
	Cam = Player.get_node("SpringArm3D")
	if Global.Profile:
		load_game(Global.Profile)

func _process(_delta):
	pass

func save_game():
	$SaveController.save_game()
	
func load_game(profile):
	$SaveController.load_game(profile)
