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
	
	if State_Controller.state_suffix == "_Release":
		if !Master.AnimController.is_playing():
			exit_state("Idle")
			return
	
	if Input.is_action_just_pressed("left_click"):
		State_Controller.state_suffix = "_Charge"
	
	if Input.is_action_just_released("left_click"):
		State_Controller.state_suffix = "_Release"
		var disc = Global.DISC.instantiate()
		disc.position = Master.Hand.global_position
		disc.power = Master.MAX_POWER/2
		disc.target_dir = Master.get_node("SpringArm3D").get_node("Camera3D").get_global_transform().basis.z
		disc.target_dir.y -= deg_to_rad(20)
		Global.Scene.add_child(disc)

func exit_state(next_state: String):
	State_Controller.state_suffix = ""
	Master.is_throwing = false
	State_Controller.state_next = next_state
