extends InputController

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_input(_delta):
	#if Input.get_last_mouse_velocity().length() == 0:
		#mouse_motion = null
	#char_mouse_input(delta)
	char_movement_input()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_motion = event
