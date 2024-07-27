extends Node3D

const CLUBHOUSE = "res://Scenes/Clubhouse/Clubhouse.tscn"

var Player : CharacterBody3D
var Cam : SpringArm3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_node("Player")
	Cam = Player.get_node("SpringArm3D")

func _process(_delta):
	pass

func go_to_clubhouse():
	get_tree().change_scene_to_file(CLUBHOUSE)
