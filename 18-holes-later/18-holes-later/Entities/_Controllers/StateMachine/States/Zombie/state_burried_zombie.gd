# BURRIED STATE
extends StateClass

var climb_out = false

func init_state():
	climb_out = false
	Master.can_move = false
	Master.accepts_input = false
	Master.global_position.y -= Master.burry_depth

func update_state(delta):
	if !Master.Target: Master.Target = Global.Player 
	
	var dist_to_target = Master.position.distance_to(Master.Target.position)
	if dist_to_target < Master.sight_range:
		climb_out = true
	
	if climb_out:
		Master.global_position = lerp(Master.global_position, Master.start_pos, delta*5)
		if Master.global_position.is_equal_approx(Master.start_pos):
			exit_state("Idle")

func exit_state(next_state: String):
	Master.is_burried = false
	Master.can_move = true
	Master.accepts_input = true
	State_Controller.state_next = next_state
