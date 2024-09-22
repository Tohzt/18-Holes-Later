extends InputController

var turn_strength = 0.0
var max_turn_strength = 100.0

func _handle_input(delta = 0.0):
	if Input.get_last_mouse_velocity().length() == 0:
		mouse_motion = null
	char_mouse_input(delta)
	cart_movement_input(delta)

func _input(event):
	mouse_motion = null
	if event is InputEventMouseMotion:
		mouse_motion = event

func cart_movement_input(delta):
	var input_forward = Input.get_axis("ui_up", "ui_down")
	var input_turn = Input.get_axis("ui_left", "ui_right")
	
	turn_strength = lerp(turn_strength,max_turn_strength,delta) * abs(input_turn)
	#Global.Debug_Settings.debug_log['cart_turn_strength'] = turn_strength
	
	Master.rotate_y(deg_to_rad(-turn_strength  * input_turn * Global.Settings.MOUSE_SENSITIVITY))
	Master.input_dir = (Master.transform.basis * Vector3(0,0,input_forward)).normalized()
