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

func char_mouse_input(delta):
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		return
	if mouse_motion:
		# Update the target rotation based on mouse input
		var turn_limit = clamp(mouse_motion.relative.x,-5,5)
		target_rotation -= turn_limit
		
		# Ensure target_rotation stays within 0-360 range
		target_rotation = fmod(target_rotation, 360.0)
		if target_rotation < 0:
			target_rotation += 360.0
		
		# Use lerp_angle for smooth rotation
		var current_rotation = fmod(Master.rotation.y, TAU)
		var new_rotation = deg_to_rad(target_rotation)
		
		# Apply the new rotation
		Master.rotation.y = lerp_angle(Master.rotation.y,new_rotation,delta*rotation_speed)
		printt(rad_to_deg(Master.rotation.y), rad_to_deg(new_rotation))

func char_movement_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#Master.input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input_dir = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
