# BLANK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.anim_play("Something")

func monitor_state():
	pass

func update_state(_delta):
	if false:
		Master.anim_play("Land")
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
