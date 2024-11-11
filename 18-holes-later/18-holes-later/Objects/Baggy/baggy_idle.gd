# IDLE STATE
extends StateClass

func init_state():
	Master.Anim_Controller.anim.play("Idle")

func update_state(delta): 
	if Master.Target:
		Master.rotate_to_target(delta)
		if Master.position.distance_to(Global.Player.position) > Master.SIGHT_RANGE:
			Master.Target = null
	else: 
		if Master.position.distance_to(Global.Player.position) < Master.SIGHT_RANGE:
			_set_nearest_target()

func _set_nearest_target():
	Master.targets_in_range = Global.get_objects_in_range(Master, "Character", Master.SIGHT_RANGE)
	if Master.targets_in_range:
		Master.Target = Master.targets_in_range.front()
		Master.targets_in_range.clear()

func exit_state(next_state: String):
	State_Controller.state_next = next_state
