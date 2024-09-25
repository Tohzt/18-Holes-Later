extends Camera3D

@onready var rot_x = rotation.x
var target: Node3D

func _process(_delta):
	rotation.y = 0
	rotation.z = 0
	if target == Global.Player:
		rot_x = rotation.x

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var _tripod = get_parent()
