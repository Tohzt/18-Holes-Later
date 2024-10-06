# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_landing = false
	Master.is_moving = false
	Master.can_throw = true
	Master.can_move = true
	Master.look_around = false
	Master.anim_play("Idle")

func monitor_state():
	pass

func update_state(_delta):
	if Master.velocity.length() > 0.1:
		exit_state("Walk")

func exit_state(next_state: String):
	Master.can_throw = false
	Master.look_around = true
	State_Controller.state_next = next_state
