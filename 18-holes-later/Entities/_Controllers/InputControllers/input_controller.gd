class_name InputController
extends Node

enum Character {PLAYER, CART}
enum Action {MOVE, LOOK, ATTACK}

@export var input_actions: Dictionary = {
	Character.PLAYER: {
		Action.MOVE: false,
		Action.LOOK: false,
		Action.ATTACK: false
	},
	Character.CART: {
		Action.MOVE: false,
		Action.LOOK: false,
		Action.ATTACK: false
	}
}

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
	
	if input_actions[Character.PLAYER][Action.MOVE]:   _character_move(delta)
	if input_actions[Character.PLAYER][Action.LOOK]:   _character_look(delta)
	if input_actions[Character.PLAYER][Action.ATTACK]: _character_attack()
	
	if input_actions[Character.CART][Action.MOVE]:   _cart_move(delta)
	if input_actions[Character.CART][Action.LOOK]:   _cart_look(delta)
	if input_actions[Character.CART][Action.ATTACK]: _cart_attack()
	
	#if char_look: _char_look(delta)
	#if char_move: _char_move()
	#if char_attk: _char_attk()
	#
	#if cart_look: _cart_look(delta)
	#if cart_move: _cart_move(delta)
	#if cart_attk: _cart_attk()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_motion = event

# Character Inputs
func _character_move(delta):
	if Master.can_move:
		var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		Master.input = input
		Master.input_dir = lerp(Master.input_dir, (Master.transform.basis * Vector3(input.x, 0, input.y)).normalized(), delta*10)
	
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

func _character_attack():
	if !Master.in_combat and Master.can_combat:
		if Input.is_action_just_pressed("left_click"):
			Master.in_combat = true
			
	if Master.can_throw:
		if Input.is_action_just_pressed("right_click"):
			Master.is_throwing = true

# Golf Cart Inputs
# TODO: Rotation bugs if mouse and keys simul
func _cart_move(delta):
	var input_forward = Input.get_axis("ui_up", "ui_down")
	var input_turn = Input.get_axis("ui_left", "ui_right")
	
	Master.turn_strength = lerp(Master.turn_strength,Master.max_turn_strength,delta*.1) * abs(input_turn)
	#Global.Settings.debug_log['cart_turn_strength'] = turn_strength
	Master.rotate_y(deg_to_rad(-Master.turn_strength  * input_turn * Global.Settings.MOUSE_H_SENSITIVITY))
	Master.input_dir = (Master.transform.basis * Vector3(0,0,input_forward)).normalized()
	
func _cart_look(delta):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if false and Master.can_look:
		if mouse_motion is InputEventMouseMotion:
			Master.turn_strength = lerp(Master.turn_strength,Master.max_turn_strength,delta)
			Master.rotate_y(deg_to_rad(-Master.turn_strength  * sign(mouse_motion.relative.x) * Global.Settings.MOUSE_H_SENSITIVITY))

func _cart_attack():
	pass
