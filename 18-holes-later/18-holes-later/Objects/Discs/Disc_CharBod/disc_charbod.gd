class_name Disc_CharBod_Class
extends CharacterBody3D

@export_category("Disc Base Stats")
var index = 1
@export var disc_name = ""
@export var disc_type = ""
@export var stats = {
	"Speed": 0,  # (1-14) Minimum power to throw stable
	"Glide": 0,  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  0,  # (1--5) Expected distance before curve at perfect speed
	"Fade":  0,  # (0-5)  How hard it wants to curve
	"Resistance": .5  # Rate that disc loses power
	}
 
@export_category("Disc Combat Stats")
@export var dmg = 5
@export var SPEED = 1
@export var curve_h: Curve
@export var curve_v: Curve


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var takeoff_pos: Vector3
var can_launch = true
var is_launched   = false
var in_bag   = false
var in_play  = false
var in_hand  = false
var is_grounded = false
var is_tracer = false
var can_look = false
var owned_by_player = false

var direction := Vector3.ZERO
var target_dir: Vector3
var power: float
var power_resist: float
var handedness = 1
var elapsed_time := 0.0
var elapse_duration := 2.0

func _launch_disc():
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(2, true)
	self.set_collision_mask_value(4, true)
	takeoff_pos = position
	in_hand = false
	in_bag = false
	rotation = Vector3.ZERO
	velocity = Vector3.ZERO
	direction = Vector3.ZERO
	# TODO: Do something with this
	reparent(get_tree().root)
	var impulse = power + stats["Speed"]
	impulse *= -target_dir
	direction = impulse.normalized()

func _process(delta):
	if is_grounded: return
	
	if can_launch and is_launched:
		can_launch = false
		_launch_disc()
	
	elapsed_time += delta
	if elapsed_time <= elapse_duration:
		var t = elapsed_time / elapse_duration
		var sample_h = curve_h.sample(t)
		var sample_v = curve_v.sample(t)
		
		var angle_h = lerp(-PI/4, PI/4, sample_h)  # Adjust range as needed
		direction = direction.rotated(Vector3.UP, angle_h * handedness * delta)
	
		var angle_v = lerp(-PI/4, PI/4, sample_v)  # Adjust range as needed
		direction = direction.rotated(Vector3.LEFT, angle_v * delta)
	
	var spd = SPEED * power * delta
	if direction:
		velocity = direction * spd
	else:
		velocity.x = move_toward(direction.x, 0, spd)
		velocity.y = move_toward(direction.y, 0, spd)
		velocity.z = move_toward(direction.z, 0, spd)
	
	_detect_impact()
	_self_cull()

#func _physics_process(_delta):
	##power -= stats["Resistance"] if power > 0.0 else 0.0
	#if !is_grounded:
		#if power < stats["Speed"]: 
			## TODO: Apply Curve
			##power = 0.0
			#pass
		#else:
			## TODO: Apply Pre-Curve
			#pass
		#
		#if stats["Glide"]:
			#var glide_amt = stats["Glide"]/2
			## TODO: Apply glide/loft

func _detect_impact():
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		if !collider: return
		if collider.is_in_group("Solid"):
			is_grounded = true
			direction = Vector3.ZERO
			velocity = Vector3.ZERO
			if $GPUParticles3D:
				$GPUParticles3D.emitting = true

func pick_up(node: Node):
	self.set_collision_mask_value(2, false)
	# TODO: Doing this in two places... find them
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
