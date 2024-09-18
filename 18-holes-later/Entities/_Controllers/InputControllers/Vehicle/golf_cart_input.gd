extends InputController

var mouse_motion = false
var mouse_velocity = Vector3.ZERO

func _handle_input():
	_handle_mouse_input()
	_handle_movement_input()

func _handle_mouse_input():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: return
	print(mouse_velocity)
	if mouse_motion:
		Global.Player.in_vehicle.rotate_y(deg_to_rad(-mouse_velocity.x * Global.Settings.MOUSE_SENSITIVITY))

func _handle_movement_input():
	#var input_dir = Input.get_axis("move_up", "move_down")
	#var input_look = Input.get_axis("move_right","move_left")
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input_dir = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#Master.input_dir

func _input(event):
	mouse_motion = false
	if event is InputEventMouseMotion:
		mouse_motion = true
		mouse_velocity = Input.get_last_mouse_velocity()/10
