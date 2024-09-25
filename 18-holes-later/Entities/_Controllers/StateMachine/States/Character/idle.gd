# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false
	Master.can_throw = true

func monitor_state():
	pass

func update_state():
	if Master.velocity.length() > 0:
		exit_state("Run")

func exit_state(next_state: String):
	Master.can_throw = false
	State_Controller.state_next = next_state
