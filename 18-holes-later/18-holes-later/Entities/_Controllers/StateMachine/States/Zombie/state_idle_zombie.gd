# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.can_move = true
	Master.Anim_Controller.anim.play("Zidle")
	if Master.get_node("Dust"):
		Master.get_node("Dust").queue_free()

func monitor_state():
	pass

func update_state(_delta):
	print("Idle")
	if Master.Target:
		var dist_to_target = Master.position.distance_to(Master.Target.position)
		if dist_to_target < Master.sight_range:
			exit_state("Chase")
	else:
		Master.Target = Global.Player

func exit_state(next_state: String):
	State_Controller.state_next = next_state
