class_name _Disc_CharBod_Class
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
	
	if is_launched:
		# Calculate horizontal trajectory
		_apply_flight_path(delta)
		
		# Softer power reduction
		power = max(0, power - stats["Resistance"] * delta)
		
		# More nuanced vertical movement
		var speed_rating = float(stats["Speed"])
		var power_ratio = power / power_init
		var glide_factor = stats["Glide"] / 7.0
		
		# Speed reduction based on power loss
		var speed_reduction = max(0.1, power_ratio)
		var spd = SPEED * power * delta * speed_reduction
		
		# Update velocity with speed reduction
		if target_dir:
			velocity = target_dir * spd
		else:
			velocity.x = move_toward(velocity.x, 0, spd)
			velocity.z = move_toward(velocity.z, 0, spd)
		
		# Lift and descent calculation
		var lift_factor = glide_factor * (1.0 - (1.0 - power_ratio) * 0.5)
		var descent_rate = gravity * delta * (1.0 - lift_factor * 1.5)
		
		velocity.y -= descent_rate
		
		# Prevent too rapid descent
		velocity.y = max(velocity.y, -gravity * delta * 2)
	
	_detect_impact()
	_self_cull()



func _apply_flight_path(delta: float) -> void:
	var speed_rating = float(stats["Speed"])
	var power_ratio = power / power_init
	
	# Right-handed throw dynamics
	# Turn (early stage right drift for right-handed throw)
	var turn_factor = 0.0
	if power_ratio > 0.7:  # Early flight stage
		turn_factor = float(stats["Turn"]) * (power_ratio - 0.7) * 0.5
	
	# Fade (late stage left drift)
	var fade_factor = 0.0
	if power_ratio < 0.4:  # Late flight stage
		fade_factor = float(stats["Fade"]) * (1.0 - power_ratio) * 0.5
	
	# Combine turn and fade
	# For right-handed throw, turn is positive (right), fade is negative (left)
	var total_curve = (turn_factor - fade_factor) * delta * handedness
	
	# Apply the curve to the flight path
	target_dir = target_dir.rotated(Vector3.UP, total_curve)
	
	# Soft wobble for slight realism
	var wobble_amplitude = 0.02 * (1.0 - power_ratio)
	var wobble = sin(elapsed_time * 3) * wobble_amplitude
	target_dir = target_dir.rotated(Vector3.UP, wobble)
	
	# Maintain horizontal speed
	var speed_reduction = 1.0 - (delta * 0.2 * (1.0 - power_ratio))
	velocity.x *= speed_reduction
	velocity.z *= speed_reduction


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
	
