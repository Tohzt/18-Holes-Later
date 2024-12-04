# THROW STATE
extends CharacterStateClass

# Add these variables at the top
var initial_mouse_position: Vector2
var max_horizontal_offset := 50.0  # Pixels of mouse movement for max effect
var max_influence := 0.0

func init_state():
	State_Controller.state_options = state_options
	Master.can_combat = false
	Master.can_move = false
	Master.locked_in = true
	Master.anim_play("Idle")
	Master.Cam_Mount.position.z -= 1
	Master.Cam_Mount.position.x -= 1
	Master.can_look = true  # Keep camera movement enabled until charging
	initial_mouse_position = get_viewport().get_mouse_position()

func monitor_state():
	pass

func _combat_throw():
	for disc: Disc_RigidBod_Class in Master.Bag.discs:
			if disc.in_hand:
				Global.select_next_disc()
				disc.position = Master.Hand.global_position
				disc.target_dir = -Master.global_position.direction_to(Master.Target.global_position)
				disc.power = 8.0
				disc.launch_disc()
		
	print("combat throw")
	exit_state("Idle")

func update_state(delta):
	if Master.Target:
		_combat_throw()
		return
	
	Master.get_aim_trace()
	if Master.is_charging: 
		Master.can_look = false  # Only disable camera movement during charge
		Master.charge_power += Master.charge_rate * delta
	elif Master.charge_power > 0:
		Master.can_look = true   # Re-enable camera movement when not charging
		Master.charge_rate = abs(Master.charge_rate)
		Master.charge_power -= Master.charge_rate * delta
	Master.charge_power = clamp(Master.charge_power,0,100)
	if Master.charge_power <= 0:
		Master.charge_rate = abs(Master.charge_rate)
	if Master.charge_power >= 100:
		Master.charge_rate = -abs(Master.charge_rate)
	
	if Master.rotation.y != Master.new_dir.y:
		Master.rotation.y = lerp_angle(Master.rotation.y, Master.new_dir.y, delta*5)
	
	if Input.is_action_just_released("right_click"):
		Global.Cameraman.set_target(Master)
		exit_state("Idle")
		Master.charge_power = 0  # Reset charge power on right-click release
	
	if Input.is_action_just_released("right_click"):
		Master.clear_trace()
	
	if Input.is_action_just_pressed("left_click"):
		Master.anim_play("Startthrow")
		Master.is_charging = true
		initial_mouse_position = get_viewport().get_mouse_position()
		max_influence = 0.0  # Reset max influence
		print("Initial mouse position: ", initial_mouse_position)
	
	if Master.is_charging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		print("Current mouse position: ", current_mouse_pos)
		print("Mouse movement delta: ", current_mouse_pos.x - initial_mouse_position.x)
		
		var horizontal_offset = (current_mouse_pos.x - initial_mouse_position.x) / max_horizontal_offset
		horizontal_offset = clamp(horizontal_offset, -1.0, 1.0)
		
		# Store the largest influence seen during charge
		max_influence = horizontal_offset if abs(horizontal_offset) > abs(max_influence) else max_influence
		Global.throw_horizontal_influence = max_influence
		print("Current influence: ", horizontal_offset, " Max influence: ", max_influence)
	
	if Input.is_action_just_released("left_click"):
		Master.anim_play("Release")
		Master.clear_trace()
		Master.charge_power = 0  # Reset charge power on disc throw
		
		for disc: Disc_RigidBod_Class in Master.Bag.discs:
			if disc.in_hand:
				Global.select_next_disc()
				throw_disc(disc)
				print("Throwing disc with max influence: ", max_influence)
				disc.set_horizontal_influence(max_influence)
				
				if Global.game_on:
					if Master.locked_in:
						disc.in_play = true
					if disc.in_play:
						Global.HUD.update_strokes(1)
						# TODO: Spawn Cam_Mount as disc child
						#Global.Cameraman.set_target(disc)
				else:
					if Master.is_on_tee:
						Global.HUD.update_strokes(1)
						# TODO: Spawn Cam_Mount as disc child
						#Global.Cameraman.set_target(disc)
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
	disc.launch_disc()
	
	# Only follow disc for non-combat throws
	if Global.Settings.follow_all_throws and !Master.Target:
		Global.Cameraman.set_target(disc)

func exit_state(next_state: String):
	Master.Cam_Mount.position.x += 1
	Master.Cam_Mount.position.z += 1
	Master.is_charging = false
	Master.is_throwing = false
	Master.locked_in = false
	State_Controller.state_next = next_state
	Master.can_look = true  # Re-enable camera movement



## THROW STATE
#extends CharacterStateClass
#
#func init_state():
	#State_Controller.state_options = state_options
	#Master.can_combat = false
	#Master.can_move = false
	#Master.locked_in = true
	#Master.anim_play("Idle")
	#Master.Cam_Mount.position.z -= 1
	#Master.Cam_Mount.position.x -= 1
#
#func monitor_state():
	#pass
#
#func _combat_throw():
	#for disc: Disc_CharBod_Class in Master.Bag.discs:
			#if disc.in_hand:
				#Global.select_next_disc()
				#disc.position = Master.Hand.global_position
				#disc.target_dir = -Master.global_position.direction_to(Master.Target.global_position)
				#disc.power = 8.0
				#disc.curve_h.clear_points()
				#disc.curve_v.clear_points()
				#disc.launch_disc()
		#
	#print("combat throw")
	#exit_state("Idle")
#
#func update_state(delta):
	#if Master.Target:
		#_combat_throw()
		#return
	#
	#Master.get_aim_trace()
	#if Master.is_charging: 
		#Master.charge_power += Master.charge_rate * delta
	#elif Master.charge_power > 0:
		#Master.charge_rate = abs(Master.charge_rate)
		#Master.charge_power -= Master.charge_rate * delta
	#Master.charge_power = clamp(Master.charge_power,0,100)
	#if Master.charge_power <= 0:
		#Master.charge_rate = abs(Master.charge_rate)
	#if Master.charge_power >= 100:
		#Master.charge_rate = -abs(Master.charge_rate)
	#
	#if Master.rotation.y != Master.new_dir.y:
		#Master.rotation.y = lerp_angle(Master.rotation.y, Master.new_dir.y, delta*5)
	#
	#if Input.is_action_just_released("right_click"):
		#Global.Cameraman.set_target(Master)
		#exit_state("Idle")
	#
	#if Input.is_action_just_released("right_click"):
		#Master.clear_trace()
	#
	#if Input.is_action_just_pressed("left_click"):
		#Master.anim_play("Startthrow")
		#Master.is_charging = true
	#
	#if Input.is_action_just_released("left_click"):
		#Master.anim_play("Release")
		#Master.clear_trace()
		#Master.is_charging = false
		#
		#for disc: Disc_CharBod_Class in Master.Bag.discs:
			#if disc.in_hand:
				#Global.select_next_disc()
				#throw_disc(disc)
				#
				#if Global.game_on:
					#if Master.locked_in:
						#disc.in_play = true
					#if disc.in_play:
						#Global.HUD.update_strokes(1)
						## TODO: Spawn Cam_Mount as disc child
						##Global.Cameraman.set_target(disc)
				#else:
					#if Master.is_on_tee:
						#Global.HUD.update_strokes(1)
						## TODO: Spawn Cam_Mount as disc child
						##Global.Cameraman.set_target(disc)
						#Global.game_on = true
						#Global.hole_over = false
						#disc.in_play = true
				#Master.locked_in = false
#
#func throw_disc(disc, power = 0.0):
	#disc.position = Master.Hand.global_position
	#disc.power = lerpf(0.0, Master.MAX_POWER, Global.HUD.charge_bar.value/100)
	#if power > 0.0:
		#disc.power = power
	#
	#disc.target_dir = Global.Cameraman.Camera.get_global_transform().basis.z
	##disc.target_dir.y -= deg_to_rad(20)
	#
	## Apply tilt (rotation around local z-axis)
	#var _tilt = 50
	#var _side = -1
	##disc.rotate_object_local(Vector3.FORWARD, deg_to_rad( _tilt * _side))
	##disc.rotate_object_local(Vector3.RIGHT, Global.Cameraman.Camera.rotation.x)
	#disc.launch_disc()
	#
	#if  Global.Settings.follow_all_throws:
		#Global.Cameraman.set_target(disc)
#
#func exit_state(next_state: String):
	#Master.Cam_Mount.position.x += 1
	#Master.Cam_Mount.position.z += 1
	#Master.is_charging = false
	#Master.is_throwing = false
	#Master.locked_in = false
	#State_Controller.state_next = next_state
