# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.can_move = true

func monitor_state():
	pass

func update_state(_delta):
	if Master.position.distance_to(Master.Target.position) < 50:
		Master.Anim_Controller.anim.play("Run")
	
	var dist_to_target = Master.global_position.distance_to(Master.Target.global_position)
	if dist_to_target > Master.SIGHT_RANGE:
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
