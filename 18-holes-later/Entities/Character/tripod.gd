# TODO: Remove - when Global has Camera Controller
extends SpringArm3D

var camera: Camera3D

@export var has_camera: Camera3D:
	get:
		return camera
	set(value):
		camera = value
		_on_obtain_camera(value)

func _on_obtain_camera(_value: Camera3D) -> void:
	pass

@onready var Camera: Camera3D = $Camera_Main
@onready var Master: Entity_Character = get_parent()

@onready var position_offset: Vector3 = position
@onready var snap_back_rotation: Vector3 = rotation
