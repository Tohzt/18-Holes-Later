# SLIDE STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.look_forward = true
	Master.can_throw = false
	Master.can_jump = true
	Master.anim_play("SlideStart")

func update_state(_delta):
	if Master.is_jumping:
		exit_state("Jump")
		
	if Master.velocity.is_zero_approx():
		exit_state("Idle")

func exit_state(next_state: String):
	Master.is_sliding = false
	Master.is_crouching = false
	State_Controller.state_next = next_state
