# IDLE STATE
extends State

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false

func monitor_state():
	pass

func update_state():
	if Master.velocity.length() > 1:
		exit_state("Run")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
