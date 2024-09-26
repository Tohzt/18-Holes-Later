class_name InputController
extends Node

@export var char_move = false
@export var char_look = false
@export var cart_move = false
@export var cart_look = false

@onready var Master: Node3D = $".."
var mouse_motion = null
var target_rotation = 0.0
var rotation_speed = 5

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if !Master.accepts_input: return
	
	if Input.get_last_mouse_velocity().length() == 0:
		mouse_motion = null
	if char_look: _char_look(delta)
	if char_move: _char_move()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_motion = event

# Character Inputs
func _char_move():
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	Master.input = input
	Master.input_dir = (Master.transform.basis * Vector3(input.x, 0, input.y)).normalized()
	
	# Jump
	if Master.can_jump and Input.is_action_just_pressed("jump"):
		Master.is_jumping = true

func _char_look(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if Master.can_look:
		if mouse_motion is InputEventMouseMotion:
			# Accumulate mouse motion to rotate the camera
			var rot_cam = Vector3.ZERO
			rot_cam.y = Global.Cameraman.rotation.y - mouse_motion.relative.x * Global.Settings.MOUSE_H_SENSITIVITY * delta
			rot_cam.x = Global.Cameraman.rotation.x - mouse_motion.relative.y * Global.Settings.MOUSE_V_SENSITIVITY * delta
			Global.Cameraman.rotation.x = clamp(rot_cam.x, deg_to_rad(-90), deg_to_rad(90))
			
			# Apply rotation directly
			Master.new_dir.y = rot_cam.y


# Character Inputs
