extends SpringArm3D

@onready var Camera: Camera3D = $Camera_Main
@onready var Master: Entity_Character = get_parent()

@onready var position_offset: Vector3 = position
@onready var snap_back_rotation: Vector3 = rotation

#func _process(_delta):
	#position = position_offset
	#if snap_to:
		#rotation = snap_to.position.direction_to(Master.position)
		#position = snap_to.position

#
#func _unhandled_input(event):
	#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#if get_child_count():
			#if event is InputEventMouseMotion:
				#var angle_limit_down = 80
				#var angle_limit_up = 20
				#rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
				#
				#if Master.State_Controller.state_suffix != "_Charge": 
					#rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
					#Master.look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
