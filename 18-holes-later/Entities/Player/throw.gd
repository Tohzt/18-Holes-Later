extends State

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false

func monitor_state():
	pass

func update_state():
	if Input.is_action_just_pressed("ui_accept"):
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.next_state = next_state
