class_name Disc_CharBod_Class
extends CharacterBody3D

@onready var Cam_Mount = $Cam_Mount

@export_category("Disc Base Stats")
var index = 1
@export var disc_name = ""
@export var disc_type = ""
# These stats are to be used for the flight path of a disc golf disc
@export var stats = {
	"Speed": 0,  # (1-14) Minimum power to throw stable
	"Glide": 0,  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  0,  # (1--5) Expected distance before curve at perfect speed
	"Fade":  0,  # (0-5)  How hard it wants to curve
	"Resistance": 0.01  # Rate that disc loses power
}
 
@export_category("Disc Combat Stats")
@export var dmg = 5
@export var SPEED = 1
@export var curve_h: Curve

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var takeoff_pos: Vector3
var can_launch = true
var is_launched = false
var in_bag = false
var in_play = false
var in_hand = false
var is_grounded = false
var is_tracer = false
var can_look = false
var owned_by_player = false

var friction := 0.0
var target_dir: Vector3
var power: float
var power_init: float
var handedness = 1
var elapsed_time := 0.0
var elapse_duration := 2.0
var angle_h: float = 0.0
var angle_v: float = 0.0

var look_forward = true
var look_around = false

func _launch_disc():
	print(stats)
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(2, true)
	self.set_collision_mask_value(4, true)
	takeoff_pos = position
	in_hand = false
	in_bag = false
	rotation = Vector3.ZERO
	velocity = Vector3.ZERO
	reparent(get_tree().root) 
	target_dir = -target_dir.normalized()
	power_init = power
func _process(delta):
	if is_grounded: return
	
	if can_launch and is_launched:
		can_launch = false
		_launch_disc()
	
	var spd = SPEED * power * delta
	if target_dir:
		velocity = target_dir * spd
	else:
		velocity.x = move_toward(target_dir.x, 0, spd)
		velocity.z = move_toward(target_dir.z, 0, spd)
	
	if is_launched:
		# Calculate horizontal trajectory
		_apply_flight_path(delta)
		
		# Update power and vertical movement
		power -= stats["Resistance"] * delta
		
		var glide_factor = stats["Glide"] / 7.0
		var speed_factor = power / power_init
		var descent_rate = gravity * delta * (1.0 - (glide_factor * speed_factor))
		velocity.y -= descent_rate
		
		if Input.is_action_just_pressed("interact"):
			printt("power: ", power)
			printt("velocity.y: ", velocity.y)
	
	_detect_impact()
	_self_cull()

func _apply_flight_path(delta: float) -> void:
	var speed_rating = float(stats["Speed"])
	var power_ratio = power / power_init
	
	# Calculate turn (right drift during high speed)
	var turn_factor = 0.0
	if power_ratio > (speed_rating / 14.0):  # Only turn if thrown hard enough
		turn_factor = float(stats["Turn"]) * power_ratio * 0.5
	
	# Calculate fade (left drift during low speed)
	var fade_threshold = 0.4  # Start fade when disc slows to 40% power
	var fade_factor = 0.0
	if power_ratio < fade_threshold:
		var fade_strength = (fade_threshold - power_ratio) / fade_threshold
		fade_factor = float(stats["Fade"]) * fade_strength * 0.5
	
	# Combine turn and fade
	var total_curve = (turn_factor + fade_factor) * delta * handedness
	
	# Apply the curve to the flight path
	target_dir = target_dir.rotated(Vector3.UP, total_curve)
# I dont know if this is needed
func curve(delta):
	elapsed_time += delta
	if elapsed_time <= elapse_duration:
		var t = elapsed_time / elapse_duration
		var sample_h = curve_h.sample(t)
		
		angle_h = lerp(angle_h, angle_h + sample_h, delta*3)
		target_dir = target_dir.rotated(Vector3.UP, angle_h * delta)
	
	else:
		elapsed_time = 0

func _detect_impact():
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if !collider: return
		if collider.is_in_group("Solid"):
			target_dir = Vector3.ZERO
			velocity = Vector3.ZERO
			if get_node("GPUParticles3D"):
				$GPUParticles3D.emitting = true

func pick_up(node: Node):
	self.set_collision_mask_value(2, false)
	if in_play:
		Global.Player.position = takeoff_pos
		Global.Player.locked_in = true
		
	is_launched = false
	can_launch = true
	is_grounded = false
	in_bag = true
	in_play = false
	reparent(node)

func _self_cull():
	if position.y < -100:
		if owned_by_player:
			pick_up(Global.Player.Bag)
		else:
			queue_free()

func set_active(_TorF):
	pass
	
