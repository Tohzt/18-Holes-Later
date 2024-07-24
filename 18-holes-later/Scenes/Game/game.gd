extends Node3D

var Player : CharacterBody3D
var Cam : SpringArm3D
@export var MOUSE_SENSITIVITY : float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_node("Player")
	Cam = Player.get_node("SpringArm3D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		Player.rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		Cam.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
		var angle_limit_down = 80
		var angle_limit_up = 20
		Cam.rotation.x = clampf(Cam.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
