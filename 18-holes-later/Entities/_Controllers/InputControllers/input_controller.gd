class_name InputController
extends Node

@onready var Master: Node3D = $".."
var mouse_motion = null
var target_rotation = 0.0
var rotation_speed = 5

func _process(delta):
	if Master.accepts_input: _handle_input(delta)

func _handle_input(_delta): 
	print_debug("_handle_input not set")

func char_mouse_input(_delta):
	pass

func char_movement_input():
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input = input
	Master.input_dir = (Master.transform.basis * Vector3(input.x, 0, input.y)).normalized()
	
	# Jump
	if Master.can_jump and Input.is_action_just_pressed("jump"):
		Master.is_jumping = true
