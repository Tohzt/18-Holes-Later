# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_falling = false
	Master.is_landing = false
	Master.is_moving = false
	Master.can_throw = true
	Master.can_move = true
	Master.can_crouch = true
	Master.can_slide = false
	Master.look_forward = false
	Master.SPEED_MULT = 1
	Master.is_running = false
	Master.anim_play("Idle")

func monitor_state():
	pass

func update_state(_delta):
	if Master.is_crouching:
		exit_state("Crouch")
	
	if Master.velocity.length() >= 0.1:
		exit_state("Walk")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
