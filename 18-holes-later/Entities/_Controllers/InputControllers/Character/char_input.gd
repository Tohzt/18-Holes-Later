extends InputController

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_input(_delta):
	#if Input.get_last_mouse_velocity().length() == 0:
		#mouse_motion = null
	#char_mouse_input(delta)
	char_movement_input()

#func _input(event):
	#if event is InputEventMouseMotion:
		#mouse_motion = event
func _input(event):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if event is InputEventMouseMotion:
		# Accumulate mouse motion to rotate the camera
		var rot_cam = Vector3.ZERO
		rot_cam.y = Global.Cameraman.rotation.y - event.relative.x * Global.Settings.MOUSE_SENSITIVITY
		rot_cam.x = Global.Cameraman.rotation.x - event.relative.y * Global.Settings.MOUSE_SENSITIVITY
		#Global.Cameraman.rotation.x = clamp(rot_cam.x, deg_to_rad(-90), deg_to_rad(90))
		
		# Apply rotation directly
		Master.new_dir.y = rot_cam.y
