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
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_dir: Vector3
var power: float
var power_init: float

var takeoff_pos: Vector3
var in_throw = false
var in_bag = false
var in_hand = false
var in_play = false

# Needed for Cameraman to follow
var look_forward = true
var look_around = false

#var handedness = 1
#var elapsed_time := 0.0
#var elapse_duration := 2.0
#var angle_h: float = 0.
#var angle_v: float = 0.0

# might yoink
var owned_by_player = false
var h_strafe = 0.0
@export var h_strafe_min = -1.5
@export var h_strafe_max = 1.5
@export var h_strafe_rate = 0.05


func launch_disc():
	#stats = { "Speed": Global.Settings.DISC_SPEED, "Glide": Global.Settings.DISC_GLIDE, "Turn": Global.Settings.DISC_TURN, "Fade": Global.Settings.DISC_FADE, "Resistance": 0.5 }
	print(stats)
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(2, true)
	self.set_collision_mask_value(4, true)
	takeoff_pos = position
	in_throw = true
	in_hand = false
	in_bag = false
	rotation = Vector3.ZERO
	velocity = Vector3.ZERO
	reparent(get_tree().root) 
	target_dir = -target_dir.normalized()
	power += 6.0
	power_init = power
	
	look_at(position + target_dir)

	curve_primary = 0.0
	curve_secondary = -1.0

func _calculate_power(delta):
	# Get the forward direction (-Z axis) based on current rotation
	var forward_dir = -transform.basis.z.normalized()
	velocity = power * forward_dir * delta
	power -= stats["Resistance"] * delta * 10

func _fight_gravity(delta):
	if !is_on_floor(): velocity.y -= gravity * delta
	var up_force: float = lerp(0.0, gravity, power/power_init)
	if !in_hand and !in_bag and !is_on_floor():
		velocity.y += up_force * delta

var push := Vector3.ZERO
var curve_primary = 0.0
var curve_secondary = -1.0

func _calculate_drift(delta):
	var power_ratio = power / power_init
	
	# Turn phase (early flight, high speed)
	# More negative Turn = stronger initial turn right
	var turn_force = -stats["Turn"] * 0.5  # Scale factor might need adjustment
	
	# Fade phase (late flight, low speed)
	# Higher Fade = stronger hook left
	var fade_force = stats["Fade"] * 0.5    # Scale factor might need adjustment
	
	# Blend between turn and fade based on power
	# At high power: more turn influence
	# At low power: more fade influence
	var blend = smoothstep(0.2, 0.8, power_ratio)
	var net_force = lerp(fade_force, turn_force, blend)
	
	# Apply rotation based on current speed and force
	rotation.y += net_force * (power/10.0) * delta

func _twist_it(_delta):
	rotation.z = push.z * 120

func _process(delta):
	if in_throw:
		_calculate_power(delta)
		_fight_gravity(delta)
		_calculate_drift(delta)
		_twist_it(delta)
		
		# Update disc orientation to face travel direction
		#look_at(position + target_dir)
	
	var collision = move_and_collide(velocity)
	#Bounce off shit
	if collision:
		var collider = collision.get_collider()
		if collider and collider.is_in_group("Solid"):
			# Calculate bounce direction using reflection
			var normal = collision.get_normal()
			target_dir = velocity.bounce(normal).normalized()
			# Reduce velocity on bounce to simulate energy loss
			power *= 0.7

	# TODO: Handedness
	# TODO: Curve
	#		relation between target dir and initital target dir

	# TODO: Glide
	#_detect_impact()
	_self_cull()

func _detect_impact():
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if !collider: return
		if false and collider.is_in_group("Solid"):
			in_throw = true
			target_dir = Vector3.ZERO
			velocity = Vector3.ZERO
			pick_up(Global.Player.Bag)

func pick_up(node: Node):
	self.set_collision_mask_value(2, false)
	in_bag = true
	in_throw = false
	reparent(node)

func _self_cull():
	if position.y < -100:
		if owned_by_player:
			pick_up(Global.Player.Bag)
		else:
			queue_free()

func set_active(_TorF):
	pass
	
