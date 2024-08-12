extends InputController

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_input():
	_handle_movement_input()
	_handle_throw_input()
	
	if false and Input.is_action_just_pressed("tab"):
		# TODO Move Action - Controller shouldn't care about results, just inputs
		Master.game_disc_index += 1
		if Master.game_disc_index >= Master.bag_of_discs.size():
			Master.game_disc_index = 0

func _handle_throw_input():
	if Input.is_action_just_pressed("right_click"):
		Master.State_Controller.popup_state = "Throw"

func _handle_movement_input():
	# Handle jump.
	if Input.is_action_just_pressed("jump") and Master.is_on_floor():
		Master.velocity.y = Master.JUMP_FORCE * Master.speed_mult

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input_dir = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
