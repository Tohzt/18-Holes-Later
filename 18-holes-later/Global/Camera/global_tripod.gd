extends SpringArm3D

var camera: Camera3D

@export var has_camera: Camera3D:
	get:
		return camera
	set(value):
		camera = value
		_on_obtain_camera(value, Global.Player.look_dir)

# TODO: Do I need value here?
func _on_obtain_camera(_value: Camera3D, aim_dir: float) -> void:
	rotation.y = rad_to_deg(aim_dir)
	print("Tripod_Disc: ", rotation)

func _process(_delta):
	global_position.y = get_parent().position.y + 1
	#global_rotation.y = (global_position.direction_to(get_tree().get_first_node_in_group("Basket_01").position)).y
	if has_camera:
		global_rotation.x = 0
		global_rotation.z = 0
	#global_rotation = Vector3.UP
	#if get_child_count():
		#print(position)
#
#func _unhandled_input(event):
	#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#if event is InputEventMouseMotion:
			#var angle_limit_down = 80
			#var angle_limit_up = 20
			##rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			#
			#rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
			#global_rotation.y += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
