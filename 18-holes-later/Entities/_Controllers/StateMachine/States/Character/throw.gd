# THROW STATE
extends State

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false
	Master.is_throwing = true

func monitor_state():
	pass

func update_state():
	if Input.is_action_just_released("right_click"):
		exit_state("Idle") 
		return
	
	#if State_Controller.state_suffix == "_Release":
		#if !Master.AnimController.is_playing():
			#exit_state("Throw")
			#return
	
	if Input.is_action_just_pressed("left_click"):
		State_Controller.state_suffix = "_Charge"
	
	if Input.is_action_just_released("left_click"):
		State_Controller.state_suffix = "_Release"
		var disc = Global.DISC.instantiate()
		disc.position = Master.Hand.global_position
		# TODO: Get power on charge time
		disc.power = Master.MAX_POWER
		disc.target_dir = Master.get_node("SpringArm3D").get_node("Camera3D").get_global_transform().basis.z
		disc.target_dir.y -= deg_to_rad(20)
		disc.disc_name = Master.bag_of_discs[Master.game_disc_index][0]
		disc.disc_type = Master.bag_of_discs[Master.game_disc_index][1]
		disc.stats = {
			"Speed": Master.bag_of_discs[Master.game_disc_index][2],  # (1-14) Minimum power to throw stable
			"Glide": Master.bag_of_discs[Master.game_disc_index][3],  # (1-7)  How long it stays in the air (gravity delta)
			"Turn":  Master.bag_of_discs[Master.game_disc_index][4],  # (1--5) Expected distance before curve at perfect speed
			"Fade":  Master.bag_of_discs[Master.game_disc_index][5],  # (0-5)  How hard it wants to curve
			"Resistance": .5  # Rate that disc loses power
			}
		Master.get_parent().add_child(disc)

func exit_state(next_state: String):
	State_Controller.state_suffix = ""
	Master.is_throwing = false
	State_Controller.state_next = next_state
