# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options

func monitor_state():
	pass

func update_state():
	var dir_to_target = Master.position.direction_to(Master.Target.position)
	dir_to_target.y = 0
	Master.apply_central_force(dir_to_target.normalized() * 10)
	var dist_to_target = Master.position.distance_to(Master.Target.position)
	if dist_to_target > Master.seight_range:
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
