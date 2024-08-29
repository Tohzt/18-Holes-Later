# THROW STATE
extends StateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false
	Master.is_throwing = true

func monitor_state():
	pass

func update_state():
	if !Input.is_action_pressed("right_click"):
		exit_state("Idle")
	
	if Input.is_action_just_released("right_click"):
		if !Master.Tripod.get_child_count():
			Global.Active_Camera.snap_to(Master)
	
	if State_Controller.state_suffix == "_Release":
		if !Master.Anim_Controller.animation_player.is_playing():
			exit_state("Throw")
			return
	
	if Input.is_action_just_pressed("left_click"):
		Master.is_charging = true
		State_Controller.state_suffix = "_Charge"
	
	if Input.is_action_just_released("left_click"):
		Master.is_charging = false
		State_Controller.state_suffix = "_Release"
		for disc: Disc in Master.Bag.discs:
			if disc.in_hand:
				disc.position = Master.Hand.global_position
				disc.power = lerpf(0.0, Master.MAX_POWER, Global.HUD.charge_bar.value/100)
				disc.target_dir = Global.Active_Camera.get_global_transform().basis.z
				disc.target_dir.y -= deg_to_rad(20)
				
				# Apply tilt (rotation around local z-axis)
				var _tilt = 50
				var _side = -1
				disc.rotate_object_local(Vector3.FORWARD, deg_to_rad( _tilt * _side))
				disc.rotate_object_local(Vector3.RIGHT, Master.Tripod.Camera.rotation.x)
				Global.select_next_disc()
				disc.launch = true
				
				if Global.game_on:
					var hud = get_tree().get_first_node_in_group("HUD")
					if hud:
						hud.update_strokes(Master.strokes)
					
					if Master.locked_in:
						disc.in_play = true
					if disc.in_play:
						Global.Active_Camera.snap_to(Global.Tripod, disc)
						Master.strokes += 1
				else:
					if Master.is_on_tee:
						Global.Active_Camera.snap_to(Global.Tripod, disc)
						Master.strokes = 1
						Global.game_on = true
						disc.in_play = true
				Master.locked_in = false
				return

func exit_state(next_state: String):
	State_Controller.state_suffix = ""
	Master.is_throwing = false
	State_Controller.state_next = next_state
