# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_walking = false

func monitor_state():
	pass

func update_state(_delta):
	var dist_to_target = Master.position.distance_to(Master.Target.position)
	print(dist_to_target)
	if dist_to_target < Master.seight_range:
		exit_state("Chase")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
