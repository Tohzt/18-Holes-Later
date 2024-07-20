extends Node
const DISC = preload("res://Discs/disc.tscn")
@onready var ROOT = get_tree()

var Player : MovementMechanics
var Camera : Camera3D
var mouse_pos := Vector2.ZERO
var mouse_offset := Vector2.ZERO

const camera_angle_limit = 0

func _ready():
	Player = get_tree().get_first_node_in_group("Player")
	Camera = Player.get_node("Head").get_node("Camera")
	print(Camera)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				mouse_pos = event.position
				mouse_offset = mouse_pos - Vector2(1152/2, 648/2)
			else:
				var disc = DISC.instantiate()
				disc.position = Player.position
				disc.position.y = Player.height
				#1152x648
				var player_pos = Vector2(Player.position.x, Player.position.z)
				disc.dir = mouse_offset.normalized()
				disc.power = mouse_offset.length()/33
				print(disc.power)
				#var throw_force : Vector3
				#throw_force = Player.camera_node.rotation
				#throw_force.x = Player.tilt
				get_tree().root.add_child(disc)
