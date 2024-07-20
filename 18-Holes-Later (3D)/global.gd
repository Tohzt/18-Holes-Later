extends Node
const DISC = preload("res://Discs/disc.tscn")
@onready var ROOT = get_tree()

var Player : MovementMechanics
var Player_Camera : Camera3D
var mouse_pos := Vector2.ZERO
var mouse_offset := Vector2.ZERO

const angle_limit_up = 20
const angle_limit_down = 5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Player = get_tree().get_first_node_in_group("Player")
	Player_Camera = Player.get_node("Head").get_node("Camera")

func _unhandled_input(event):
	# Close Game
	if Input.is_action_just_released("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().quit()
	
	# Toggl Camera
	if Input.is_action_just_pressed("toggle_camera"):
		# TODO: Move perspective to global variable
		Player.first_person = !Player.first_person
		Player.camera_node.current = !Player.camera_node.current
	
	# Throw Disc
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				mouse_pos = event.position
				mouse_offset = mouse_pos - Vector2(1152/2, 648/2)
			else:
				var disc = DISC.instantiate()
				disc.position = Player.position
				disc.position.y = Player.height
				if Player.first_person:
					var camera_transform = Player_Camera.global_transform
					var forward_vector = -camera_transform.basis.z
					var normalized_forward = forward_vector.normalized()
					var velocity = normalized_forward
					print("first person")
					disc.dir = Vector2(velocity.x,velocity.z)
					disc.power = 20
				else:
					print("third person")
					disc.dir = mouse_offset.normalized()
					disc.power = mouse_offset.length()/33
				get_tree().root.add_child(disc)
