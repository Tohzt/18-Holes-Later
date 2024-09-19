extends InputController

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_input(_delta):
	_char_mouse_input()
	_char_movement_input()

func _input(event):
	mouse_motion = null
	if event is InputEventMouseMotion:
		mouse_motion = event
