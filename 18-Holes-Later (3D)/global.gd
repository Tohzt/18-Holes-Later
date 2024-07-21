extends Node
const DISC = preload("res://Discs/disc.tscn")
const BALL = preload("res://Ball/ball.tscn")
@onready var ROOT = get_tree().root
var disc : RigidBody3D

# TODO: Clean up HUD
var HUD #: CanvasLayer
var Player : MovementMechanics
var Player_Camera : Camera3D
var mouse_pos := Vector2.ZERO
var mouse_offset := Vector2.ZERO
var mouse_pressed := false
var mouse_hold_time := 0.0

# TODO: Fix Camera Tilt
const angle_limit_up = 0
const angle_limit_down = 0
var tilt = 0.0
var tilt_amount := 1.0
var spin = 0.0
var spin_amount := 10.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	HUD = get_tree().root.get_node("World").get_node("HUD").get_node("MarginContainer").get_node("HBoxContainer")
	#HUD.hide()
	Player = get_tree().get_first_node_in_group("Player")
	Player_Camera = Player.get_node("Head").get_node("Camera")

func _process(delta):
	if mouse_pressed:
		mouse_hold_time = min(2, mouse_hold_time + delta)

func _spawn_ball():
	if Input.is_action_just_released("select"):
		var ball = BALL.instantiate()
		ball.position = Vector3(5,5,5)
		ball.set_collision_layer_value(1, false)
		ball.set_collision_layer_value(3, true)
		ball.set_collision_mask_value(2, true)
		ball.set_collision_mask_value(3, true)
		ROOT.get_node("World").get_node("Balls").add_child(ball)

func _throw_disc(event):
	if event is InputEventMouseButton:
		# Set Tilt
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			tilt -= tilt_amount 
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			tilt += tilt_amount 
			
		# Set Spin
		if event.button_index == MOUSE_BUTTON_WHEEL_LEFT and event.pressed:
			spin -= spin_amount
		if event.button_index == MOUSE_BUTTON_WHEEL_RIGHT and event.pressed:
			spin += spin_amount
		
		# Throw Disc
		if Player.discs_in_bag > 0 and event.button_index == MOUSE_BUTTON_RIGHT:
			# Init Charge
			if event.pressed:
				HUD.show()
				mouse_pressed = true
				mouse_pos = event.position
				mouse_offset = mouse_pos - Vector2(576, 324)
			
			# Release Disc
			else:
				#HUD.hide()
				disc = DISC.instantiate()
				disc.position = Player.get_node("Hand").global_position
				disc.power = floor(mouse_hold_time * 10)
				disc.tilt = tilt
				disc.spin = spin
				
				if Player.first_person:
					var camera_transform = Player_Camera.global_transform
					var forward_vector = -camera_transform.basis.z
					var normalized_forward = forward_vector.normalized()
					var velocity = normalized_forward
					disc.dir = Vector2(velocity.x,velocity.z)
				else:
					disc.dir = mouse_offset.normalized()
					
				ROOT.add_child(disc)
				Player.discs_in_bag -= 1
				if Player.golfing:
					Player.hole_score += 1
					Player.golfing = false
					disc.game_disc = true
				
				mouse_hold_time = 0.0
				mouse_pressed = false

func _unhandled_input(event):
	_spawn_ball()
	_throw_disc(event)
	
	# Close Game
	if Input.is_action_just_released("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().quit()
	
	# Toggl Camera
	if Input.is_action_just_pressed("toggle_camera"):
		# TODO: Move perspective to global variable
		Player.first_person = !Player.first_person
		if Player.first_person : 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Player.camera_node.current = !Player.camera_node.current
	
