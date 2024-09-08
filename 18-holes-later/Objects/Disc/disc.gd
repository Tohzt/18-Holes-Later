class_name Disc
extends RigidBody3D

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

var takeoff_pos: Vector3
var launch   = false
var in_bag   = false
var in_play  = false
var in_hand  = false
var grounded = false
var is_tracer = false

var target_dir: Vector3
var power: float
var power_resist: float
var handedness = 1

func _launch_disc():
	takeoff_pos = position
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(4, true)
	sleeping = false
	launch  = false
	in_hand = false
	in_bag  = false
	rotation         = Vector3.ZERO
	linear_velocity  = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	# TODO: Do something with this
	reparent(get_parent().get_parent().get_parent())
	var impulse = power + stats["Speed"]
	impulse *= -target_dir
	apply_central_impulse(impulse)

func _process(_delta):
	show()
	if in_bag:
		hide()
	else:
		DebugDraw.draw_line_relative_thick(Global.Player.position, Global.Player.position - position)
		if grounded:
			_settle()

func _physics_process(_delta):
	if launch:
		_launch_disc()
	
	if in_bag:
		Global.add_disc_to_bag(self)
	
	_detect_impact()
	_self_cull()
	
	power -= stats["Resistance"] if power > 0.0 else 0.0
	if !grounded:
		if power < stats["Speed"]: 
			var curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Fade"] * handedness))
			apply_central_force(curve)
			power = 0.0
		else:
			var pre_curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Turn"] * handedness))
			apply_central_force(pre_curve)
		
		if stats["Glide"]:
			var glide_amt = stats["Glide"]/2
			apply_central_force(Vector3(0,glide_amt,0))

	#var collison = move_and_collide(Vector3.ZERO, true)
	#if collison:
		#var collider = collison.get_collider()
		#if collider.is_in_group("Solid"):
			#grounded = true

func _settle():
	if linear_velocity.length() < 0.2:
		self.set_collision_mask_value(1, false)
		linear_velocity = Vector3.ZERO
		sleeping = true

func _detect_impact():
	for node in get_colliding_bodies():
		if node:
			if node.is_in_group("Character"):
				if in_play:
					pass
				else:
					pick_up(node.Bag)
			if node.is_in_group("Solid"):
				grounded = true
				self.set_collision_mask_value(4, false)
			if node.is_in_group("Enemy"):
				node.take_damage(dmg)

func pick_up(node: Node):
	# TODO: Doing this in two places... find them
	if in_play:
		Global.Player.position = takeoff_pos
		Global.Player.locked_in = true
	grounded = false
	in_bag = true
	in_play = false
	reparent(node)

func _self_cull():
	if position.y < -100:
		pick_up(Global.Player.Bag)
