# THROW STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.is_moving = false
	Master.is_throwing = true
	Master.can_combat = false
	Master.can_move = false
	Master.locked_in = true
	Master.anim_play("Idle")

func monitor_state():
	pass

func update_state(delta):
	if Master.rotation.y != Master.new_dir.y:
		Master.rotation.y = lerp_angle(Master.rotation.y, Master.new_dir.y, delta*5)
	
	if !Input.is_action_pressed("right_click"):
		Global.Cameraman.set_target(Master, Master.get_node("CamFocus"))
		exit_state("Idle")
	
	if Input.is_action_just_released("right_click"):
		Master.clear_trace()
	
	if Input.is_action_just_pressed("left_click"):
		Master.anim_play("Startthrow")
		Master.is_charging = true
	
	if Input.is_action_just_released("left_click"):
		Master.anim_play("Release")
		Master.clear_trace()
		Master.is_charging = false
		
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
	disc.target_dir.y -= deg_to_rad(20)
	
	# Apply tilt (rotation around local z-axis)
	var _tilt = 50
	var _side = -1
	disc.rotate_object_local(Vector3.FORWARD, deg_to_rad( _tilt * _side))
	disc.rotate_object_local(Vector3.RIGHT, Global.Cameraman.Camera.rotation.x)
	disc.launch = true
	
	if !disc.is_tracer and Global.Settings.follow_all_throws:
		Global.Cameraman.set_target(Master, Master.get_node("CamFocus"))

func exit_state(next_state: String):
	Master.is_charging = false
	Master.is_throwing = false
	Master.locked_in = false
	State_Controller.state_next = next_state
