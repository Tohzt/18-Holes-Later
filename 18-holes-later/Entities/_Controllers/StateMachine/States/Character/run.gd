# WALK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = true
	Master.can_throw = false

func monitor_state():
	pass

func update_state():
	Master.is_running = false
	if Input.is_action_pressed("run"):
		Master.is_running = true
		
	if Master.velocity.length() < 1:
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
