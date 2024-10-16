# WALK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.look_forward = true
	Master.is_moving = true
	Master.can_run = true
	Master.can_throw = false
	Master.can_crouch = true
	Master.is_crouching = false
	Master.SPEED_MULT = 1
	Master.anim_play("Run")

func monitor_state():
	pass

func update_state(_delta):
	if Master.is_running:
		Master.can_slide = true
		Master.anim_play("Sprint")
		Master.SPEED_MULT = 2
	else:
		Master.can_slide = true
		Master.anim_play("Run")
		Master.SPEED_MULT = 1
	
	if Master.velocity.length() > Master.slide_thresh:
		Master.can_slide = true
	else: 
		Master.can_slide = false
	
	if Master.is_sliding:
		exit_state("Slide")
	elif Master.is_crouching:
		exit_state("Crouch")
	
	if Master.velocity.length() < 0.1:
		exit_state("Idle")

func exit_state(next_state: String):
	Master.SPEED_MULT = 1
	State_Controller.state_next = next_state
