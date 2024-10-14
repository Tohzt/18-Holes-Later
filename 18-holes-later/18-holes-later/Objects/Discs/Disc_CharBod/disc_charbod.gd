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
@export var SPEED = 100

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

var direction := Vector3.ZERO
var target_dir: Vector3
var drop_rate := -0.05
var power: float
var power_resist: float
var handedness = 1

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
	var spd = SPEED * power * delta
	if !is_on_floor():
		direction.y += drop_rate
		print(direction.y)
	if direction:
		velocity = direction * spd
		#velocity.x = direction.x * spd * delta
		#velocity.y = direction.y * spd * delta
		#velocity.z = direction.z * spd * delta
	else:
		velocity.x = move_toward(direction.x, 0, spd)
		velocity.y = move_toward(direction.y, 0, spd)
		velocity.z = move_toward(direction.z, 0, spd)
	move_and_slide()
	
	if is_launched:
		show()

func _physics_process(_delta):
	if can_launch and is_launched:
		can_launch = false
		_launch_disc()
	if !is_grounded: _detect_impact()
	_self_cull()
	
	#power -= stats["Resistance"] if power > 0.0 else 0.0
	if !is_grounded:
		if power < stats["Speed"]: 
			# TODO: Apply Curve
			#power = 0.0
			pass
		else:
			# TODO: Apply Pre-Curve
			pass
		
		if stats["Glide"]:
			var glide_amt = stats["Glide"]/2
			# TODO: Apply glide/loft

func _detect_impact():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if !collider: return
		if collider.is_in_group("Solid"):
			is_grounded = true

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
		pick_up(Global.Player.Bag)
