class_name InputController
extends Node

@export_category("Character Controls")
@export var character_move   := false
@export var character_look   := false
@export var character_action := false

@export_category("Vehicle Controls")
@export var vehicle_move   := false
@export var vehicle_look   := false
@export var vehicle_action := false

@export_category("Launcher Controls")
@export var launcher_look   := false
@export var launcher_action := false

@onready var Master: Node3D = $".."
var input_move = Vector2.ZERO
var mouse_motion = null
var target_rotation = 0.0
var rotation_speed = 5

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if !Master.accepts_input: return
	
	if Input.get_last_mouse_velocity().length() == 0:
		mouse_motion = null
	
	if character_move:   _character_move(delta)
	if character_look:   _character_look(delta)
	if character_action: _character_action()
	
	if vehicle_move:   _vehicle_move(delta)
	if vehicle_look:   _vehicle_look(delta)
	if vehicle_action: _vehicle_action()
	
	if launcher_look:   _launcher_look(delta)
	if launcher_action: _launcher_action()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_motion = event

# Character Inputs
func _character_move(delta):
	input_move = Vector2.ZERO
	Master.input = input_move
	if Master.can_move:
		input_move = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		Master.input = input_move
		Master.input_dir = lerp(Master.input_dir, (Master.transform.basis * Vector3(input_move.x, 0, input_move.y)).normalized(), delta*10)
	
	if Master.can_jump and Input.is_action_just_pressed("jump"):
		Master.is_jumping = true
	
var rot_cam = Vector3.ZERO
func _character_look(delta):
	if Global.Hole_Name == "Clubhouse_Interior": return
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if Master.can_look:
		if mouse_motion is InputEventMouseMotion:
			rot_cam.y = Master.new_dir.y - mouse_motion.relative.x * Global.Settings.MOUSE_H_SENSITIVITY * delta
			
			rot_cam.x = Global.Cameraman.rot_x - mouse_motion.relative.y * Global.Settings.MOUSE_V_SENSITIVITY * delta
			rot_cam.x = clamp(rot_cam.x, deg_to_rad(-45), deg_to_rad(45))
			Global.Cameraman.rot_x = rot_cam.x

func _character_action():
	if !Master.in_combat:
		if Master.can_combat:
			if Input.is_action_just_pressed("left_click"):
				Master.in_combat = true
		if Master.can_interact:
			if Input.is_action_just_pressed("interact"):
				Master.did_interact = true
			
	if Master.can_throw:
		if Input.is_action_just_pressed("right_click"):
			Master.is_throwing = true

# Vehicle Inputs
# TODO: Rotation bugs if mouse and keys simul
func _vehicle_move(delta):
	var input_forward = Input.get_axis("ui_up", "ui_down")
	var input_turn = Input.get_axis("ui_left", "ui_right")
	
	Master.turn_strength = lerp(Master.turn_strength,Master.max_turn_strength,delta*.1) * abs(input_turn)
	#Global.Settings.debug_log['cart_turn_strength'] = turn_strength
	Master.rotate_y(deg_to_rad(-Master.turn_strength  * input_turn * Global.Settings.MOUSE_H_SENSITIVITY))
	Master.input_dir = (Master.transform.basis * Vector3(0,0,input_forward)).normalized()
	
func _vehicle_look(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if false and Master.can_look:
		if mouse_motion is InputEventMouseMotion:
			Master.turn_strength = lerp(Master.turn_strength,Master.max_turn_strength,delta)
			Master.rotate_y(deg_to_rad(-Master.turn_strength  * sign(mouse_motion.relative.x) * Global.Settings.MOUSE_H_SENSITIVITY))

func _vehicle_action():
	pass

# Launcher Inputs
func _launcher_look(delta):
	print("Launcher Looking")
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if Master.can_look:
		if mouse_motion is InputEventMouseMotion:
			rot_cam.y = Master.new_dir.y - mouse_motion.relative.x * Global.Settings.MOUSE_H_SENSITIVITY * delta
			
			rot_cam.x = Global.Cameraman.rot_x - mouse_motion.relative.y * Global.Settings.MOUSE_V_SENSITIVITY * delta
			rot_cam.x = clamp(rot_cam.x, deg_to_rad(-45), deg_to_rad(45))
			Global.Cameraman.rot_x = rot_cam.x

func _launcher_action():
	if Master.can_shoot:
		if Input.is_action_just_pressed("left_click"):
			Master.did_shoot = true
