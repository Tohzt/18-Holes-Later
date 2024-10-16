# CROUCH STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.look_forward = true
	Master.can_throw = false
	Master.can_move = true
	Master.can_run = false
	Master.can_slide = false
	Master.SPEED_MULT = 0.25
	Master.anim_play("CrouchIdle")

func monitor_state():
	pass

func update_state(_delta):
	if !Master.velocity.is_zero_approx():
		Master.anim_play("CrouchWalk")
	else:
		Master.anim_play("CrouchIdle")
	
	if Master.is_jumping:
		exit_state("Jump")
	elif !Master.is_crouching:
		exit_state("Idle")

func exit_state(next_state: String):
	Master.is_crouching = false
	Master.SPEED_MULT = 1
	State_Controller.state_next = next_state
