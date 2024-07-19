extends Node
const DISC = preload("res://Discs/disc.tscn")
@onready var ROOT = get_tree()

var Player : MovementMechanics

const camera_angle_limit = 0

func _ready():
	Player = get_tree().get_first_node_in_group("Player")
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var disc = DISC.instantiate()
			disc.position = Player.position
			disc.position.y = Player.height
			var throw_force : Vector3
			throw_force = Player.camera_node.rotation
			#throw_force.x = Player.tilt
			disc.apply_central_impulse(Player.camera_node.rotation * Player.power)
			get_tree().root.add_child(disc)
			print("Spawn Disc")
