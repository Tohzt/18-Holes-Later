# IDLE STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options

func monitor_state():
	pass

func update_state(delta):
	if Master.position.distance_to(Master.Target.position) < 50:
		Master.zanim.anim.play("Run")
		Master.direction = (Master.global_position - Master.Target.global_position).normalized()
	else:
		Master.direction = Vector3.ZERO
		Master.zanim.anim.play("Zidle")
		Master.velocity = Vector3.ZERO
	
	var dist_to_target = abs(Master.global_position - Master.Target.global_position)
	if dist_to_target > Master.seight_range:
		exit_state("Idle")

func exit_state(next_state: String):
	State_Controller.state_next = next_state
