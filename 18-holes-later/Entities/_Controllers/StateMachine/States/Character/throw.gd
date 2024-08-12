# THROW STATE
extends StateClass

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
		for disc: Disc in Master.Bag.discs:
			if disc.in_hand:
				disc.position = Master.Hand.global_position
				# TODO: Get power on charge time
				disc.power = Master.MAX_POWER
				disc.target_dir = Master.get_node("SpringArm3D").get_node("Camera3D").get_global_transform().basis.z
				disc.target_dir.y -= deg_to_rad(20)
				
				# Apply tilt (rotation around local z-axis)
				var _tilt = 50
				var _side = -1
				disc.rotate_object_local(Vector3.FORWARD, deg_to_rad( _tilt * _side))
				disc.rotate_object_local(Vector3.RIGHT, Master.Camera.rotation.x)
				disc.launch()
				return

func exit_state(next_state: String):
	State_Controller.state_suffix = ""
	Master.is_throwing = false
	State_Controller.state_next = next_state
