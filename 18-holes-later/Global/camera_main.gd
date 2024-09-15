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
			var angle_limit_down = 80
			var angle_limit_up = 20
			if target == Global.Player:
				# Update Vertical
				_tripod.rotate_x(deg_to_rad(-event.relative.y * Global.Settings.MOUSE_SENSITIVITY))
				_tripod.rotation.x = clampf(_tripod.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
				# Update Horizontal
				Global.Player.look_dir += deg_to_rad(-event.relative.x * Global.Settings.MOUSE_SENSITIVITY)
			else:
				# Update Vertical
				rotate_x(deg_to_rad(-event.relative.y * Global.Settings.MOUSE_SENSITIVITY))
				rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down+20), deg_to_rad(angle_limit_up-15))
				# Update Horizontal
				_tripod.global_rotation.y += deg_to_rad(-event.relative.x * Global.Settings.MOUSE_SENSITIVITY)
			
