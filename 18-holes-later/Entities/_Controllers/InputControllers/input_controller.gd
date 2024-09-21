class_name InputController
extends Node

@onready var Master: Node3D = $".."
var mouse_motion = null
var mouse_velocity = Vector3.ZERO

func _process(delta):
	if Master.accepts_input: _handle_input(delta)

func _handle_input(_delta): 
	print_debug("_handle_input not set")

func _char_mouse_input():
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: return
	if mouse_motion:
		Master.rotate_y(deg_to_rad(-mouse_motion.relative.x * Global.Settings.MOUSE_SENSITIVITY))

func _char_movement_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#Master.input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input_dir = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
