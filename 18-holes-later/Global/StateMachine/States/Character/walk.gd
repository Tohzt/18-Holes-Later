# WALK STATE
extends State

func init_state():
	#name = "Walk"
	State_Controller.state_options = state_options
	Master.is_moving = true

func monitor_state():
	pass

func update_state():
	if Input.is_action_just_pressed("run"):
		Master.SPEED*=5
		Master.JUMP_FORCE*=5
	if Input.is_action_just_released("run"):
		Master.SPEED/=5
		Master.JUMP_FORCE/=5
		
	if Master.velocity.length() < 1:
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
