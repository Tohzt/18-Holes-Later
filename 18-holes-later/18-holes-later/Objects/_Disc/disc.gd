class_name Disc
extends CharacterBody3D
@export var bounce_factor = 0.5  # Adjust this to control the bounce strength

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

var SPEED = 200

var direction: Vector3 = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var takeoff_pos: Vector3
var launch   = false
var in_bag   = false
var in_play  = false
var in_hand  = false
var grounded = false
var is_tracer = false
var can_look = false
var can_launch = true

var target_dir: Vector3
var power: float
var power_resist: float
var handedness = 1

func _launch_disc():
	takeoff_pos = position
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(4, true)
	in_hand = false
	in_bag  = false
	rotation         = Vector3.ZERO
	# TODO: Do something with this
	reparent(get_parent().get_parent().get_parent())
	var impulse = power + stats["Speed"]
	impulse *= -target_dir
	direction = impulse

func _process(delta):
	if !is_on_floor():
		direction.y -= gravity * delta
	#var collisions = move_and_collide(velocity, true)
	#if collisions:
		#var collider = collisions.get_collider()
		##var normal = collider.get_normal()
		#if !collider.is_in_group("Character"):
			#if !in_bag and !grounded and !in_hand:
				#pass#velocity = normal.normalized() * velocity.length()
			#if grounded:
				#print("ok")
	
	
	if launch:
		show()
		DebugDraw.draw_line_relative_thick(Global.Player.position, Global.Player.position - position)
		if grounded:
			_settle()
	elif in_bag:
		position = Global.Player.position - Vector3(0,-100,0)
	if in_hand:
		if get_parent() == Global.Player:
			reparent(Global.Player.Anim_Controller.Bone_Hand)
		global_position = Global.Player.Anim_Controller.Bone_Hand.global_position
		global_rotation = Global.Player.Anim_Controller.Bone_Hand.global_rotation
		

func _physics_process(delta):
	
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.z = direction.z * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)
		
	
	# Move the character
	var collision = move_and_collide(velocity * delta)
	
	# Check for collision
	if collision:
		# Get the normal of the collision surface
		var normal = collision.get_normal()
		
		# Calculate the reflection vector
		var reflection = velocity.reflect(normal)
		
		# Apply the bounce effect
		velocity = reflection * bounce_factor
		
		# Optionally, you can add a minimum velocity threshold to stop bouncing
		if velocity.length() < 1.0:
			velocity = Vector3.ZERO
	
	if launch and can_launch:
		can_launch = false
		_launch_disc()
	
	#_detect_impact()
	_self_cull()
	#
	#power -= stats["Resistance"] if power > 0.0 else 0.0
	#if !grounded:
		#if power < stats["Speed"]: 
			#var curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Fade"] * handedness))
			#apply_central_force(curve)
			#power = 0.0
		#else:
			#var pre_curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Turn"] * handedness))
			#apply_central_force(pre_curve)
		#
		#if stats["Glide"]:
			#var glide_amt = stats["Glide"]/2
			#apply_central_force(Vector3(0,glide_amt,0))

func _settle():
	pass
	#if linear_velocity.length() < 0.2:
		#self.set_collision_mask_value(1, false)
		#linear_velocity = Vector3.ZERO
		#sleeping = true
#
#func _detect_impact():
	#for node in get_colliding_bodies():
		#if node:
			#if node.is_in_group("Character"):
				#if in_play:
					#pass
				#else:
					#pick_up(node.Bag)
			#if node.is_in_group("Solid"):
				## TODO: Spawm pickup area
				#grounded = true
				##self.set_collision_mask_value(4, false)
			#if node.is_in_group("Enemy"):
				#node.take_damage(dmg)

func pick_up(node: Node):
	# TODO: Doing this in two places... find them
	if in_play:
		Global.Player.position = takeoff_pos
		Global.Player.locked_in = true
		
	launch = false
	can_launch = true
	grounded = false
	in_bag = true
	in_play = false
	reparent(node)

func _self_cull():
	if position.y < -100:
		pick_up(Global.Player.Bag)
