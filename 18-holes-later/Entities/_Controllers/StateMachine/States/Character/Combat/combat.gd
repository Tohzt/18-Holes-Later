# ATTACK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	if Master.is_attacking:
		Master.anim_play("Jab")
	else:
		Master.anim_play("Idle_Fight")
	#Master.can_move = false
	#Master.is_moving = false

func update_state(_delta):
	var path = Master.Anim_Controller.anim_state.get_travel_path()
	var current = Master.Anim_Controller.anim_state.get_current_node()
	
	# TODO: Create a combo counter/countdown/cooldown
	if Input.is_action_just_pressed("left_click"):
		if current == "Idle_Fight":
			Master.anim_play("Jab")
		if current == "Jab":
			Master.anim_play("Slice")
		if current == "Slice":
			Master.anim_play("Compasso")
		if current == "Compasso":
			Master.anim_play("KickUp")
	
	
	if !path and current == "Idle":
		exit_state("Idle")

func exit_state(next_state: String):
	Master.in_combat = false
	State_Controller.state_next = next_state
