# THROW STATE
extends CharacterStateClass

func init_state():
	Global.Cameraman.offset_y = -1
	State_Controller.state_options = state_options
	Master.is_moving = false
	Master.is_throwing = true
	Master.locked_in = true

func monitor_state():
	pass

func update_state():
	if !Input.is_action_pressed("right_click"):
		exit_state("Idle")
	
	if Input.is_action_just_released("right_click"):
		Master.clear_trace()
	
	#if State_Controller.state_suffix == "_Release":
		#if !Master.Anim_Controller.animation_player.is_playing():
			#exit_state("Throw")
			#return
	
	if Input.is_action_just_pressed("left_click"):
		Master.is_charging = true
		State_Controller.state_suffix = "_Charge"
	
	if Input.is_action_just_released("left_click"):
		Master.clear_trace()
		Master.is_charging = false
		#State_Controller.state_suffix = "_Release"
		for disc: Disc in Master.Bag.discs:
			if disc.in_hand:
				Global.select_next_disc()
				throw_disc(disc)
				
				if Global.game_on:
					if Master.locked_in:
						disc.in_play = true
					if disc.in_play:
						Global.HUD.update_strokes(1)
						Global.Cameraman.set_target(disc, disc)
				else:
					if Master.is_on_tee:
						Global.HUD.update_strokes(1)
						Global.Cameraman.set_target(disc, disc)
						Global.game_on = true
						Global.hole_over = false
						disc.in_play = true
				Master.locked_in = false

func throw_disc(disc, power = 0.0):
	disc.position = Master.Hand.global_position
	disc.power = lerpf(0.0, Master.MAX_POWER, Global.HUD.charge_bar.value/100)
	if power > 0.0:
		disc.power = power
	disc.target_dir = Global.Cameraman.Camera.get_global_transform().basis.z
	print(disc.target_dir)
	disc.target_dir.y -= deg_to_rad(20)
	
	# Apply tilt (rotation around local z-axis)
	var _tilt = 50
	var _side = -1
	disc.rotate_object_local(Vector3.FORWARD, deg_to_rad( _tilt * _side))
	disc.rotate_object_local(Vector3.RIGHT, Global.Cameraman.Camera.rotation.x)
	disc.launch = true
	
	if !disc.is_tracer and Global.Debug_Settings.follow_all_throws:
		Global.Cameraman.set_target(Global.Player, Global.Player.get_node("CamFocus"))

func exit_state(next_state: String):
	Global.Cameraman.offset_y = 0
	State_Controller.state_suffix = ""
	Master.is_throwing = false
	Master.locked_in = false
	State_Controller.state_next = next_state
