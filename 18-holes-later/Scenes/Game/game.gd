extends Node3D

var Player : CharacterBody3D
var Cam : SpringArm3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_node("Player")
	Cam = Player.get_node("SpringArm3D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
