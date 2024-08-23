extends SpringArm3D

func _process(_delta):
	#global_rotation = Vector3.UP
	global_rotation.x = 0
	global_rotation.z = 0
	if get_child_count():
		print(position)
#
#func _unhandled_input(event):
	#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#if event is InputEventMouseMotion:
			#var angle_limit_down = 80
			#var angle_limit_up = 20
			##rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			#
			#rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
			#global_rotation.y += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
