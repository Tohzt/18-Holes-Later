extends InputController

var mouse_motion = false
var mouse_velocity = Vector3.ZERO

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_input():
	_handle_mouse_input()
	_handle_movement_input()

func _handle_mouse_input():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: return
	print(mouse_velocity)
	if mouse_motion:
		Global.Player.rotate_y(deg_to_rad(-mouse_velocity.x * Global.Settings.MOUSE_SENSITIVITY))

func _handle_movement_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input_dir = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _input(event):
	mouse_motion = false
	if event is InputEventMouseMotion:
		mouse_motion = true
		mouse_velocity = Input.get_last_mouse_velocity()/10
