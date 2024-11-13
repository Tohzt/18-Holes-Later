# WALK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.look_forward = true
	Master.is_moving = true
	Master.can_run = true
	Master.can_throw = true
	Master.can_crouch = true
	Master.is_crouching = false
	Master.SPEED_MULT = 1
	Master.anim_play("Run")

func monitor_state():
	pass

func update_state(delta):
	if Master.is_running:
		Master.can_slide = true
		Global.Cameraman.Camera.fov = lerp(Global.Cameraman.Camera.fov,120.0,delta*5)
		Global.Player.Cam_Mount.position.z = lerp(Global.Player.Cam_Mount.position.z, -2.5, delta*5)
		Global.Player.Cam_Mount.position.y = lerp(Global.Player.Cam_Mount.position.y,  1.2,   delta*5)
		Master.anim_play("Sprint")
		Master.SPEED_MULT = 2
	else:
		Master.can_slide = true
		Global.Cameraman.Camera.fov = lerp(Global.Cameraman.Camera.fov,75.0,delta*10)
		Global.Player.Cam_Mount.position.z = lerp(Global.Player.Cam_Mount.position.z, 1.0, delta*10)
		Global.Player.Cam_Mount.position.y = lerp(Global.Player.Cam_Mount.position.y,  1.5,   delta*10)
		Master.anim_play("Run")
		Master.SPEED_MULT = 1
	
	if Master.velocity.length() > Master.slide_thresh:
		Master.can_slide = true
	else: 
		Master.can_slide = false
	
	if Master.velocity.length() < 0.1:
		exit_state("Idle")
		return
	
	if Master.is_crouching:
		exit_state("Crouch")
		return
	
	if Master.is_sliding:
		exit_state("Slide")
		return
	
	if Master.is_jumping:
		exit_state("Jump")
		return
		
	if Master.in_combat:
		exit_state("Combat")
		return

func exit_state(next_state: String):
	Master.SPEED_MULT = 1
	State_Controller.state_next = next_state
