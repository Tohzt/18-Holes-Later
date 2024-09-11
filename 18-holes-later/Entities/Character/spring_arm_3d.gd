extends SpringArm3D

@onready var Camera = $Camera_Main
@onready var Master: Entity_Character = get_parent()

var snap_back_position = Vector3.ZERO
var snap_back_rotation = Vector3.ZERO

func return_to_player():
	reparent(Master)
	position = snap_back_position
	rotation = snap_back_rotation
