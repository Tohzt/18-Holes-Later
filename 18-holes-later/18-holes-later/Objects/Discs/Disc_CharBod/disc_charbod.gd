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
var spd = 5000

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var takeoff_pos: Vector3
var launch   = false
var in_bag   = false
var in_play  = false
var in_hand  = false
var grounded = false
var is_tracer = false
var is_settled = false
var can_look = false
var can_launch = true

var direction := Vector3.ZERO
var target_dir: Vector3
var power: float
var power_resist: float
var handedness = 1

func _launch_disc():
	takeoff_pos = position
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(4, true)
	is_settled = false
	in_hand = false
	in_bag = false
	rotation = Vector3.ZERO
	velocity = Vector3.ZERO
	direction = Vector3.ZERO
	# TODO: Do something with this
	reparent(get_tree().root)
	var impulse = power + stats["Speed"]
	impulse *= -target_dir
	spd = impulse.length()
	direction = impulse.normalized()

func _process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
	if direction:
		velocity.x = direction.x * spd * delta
		velocity.z = direction.z * spd * delta
	else:
		velocity.x = move_toward(direction.x, 0, spd * delta)
		velocity.z = move_toward(direction.z, 0, spd * delta)
	move_and_slide()
	
	if launch:
		show()
		DebugDraw.draw_line_relative_thick(Global.Player.position, Global.Player.position - position)
		if grounded:
			_settle()
	elif in_bag:
		position = Global.Player.position - Vector3(0,10,0)
	if in_hand:
		if get_parent() == Global.Player:
			reparent(Global.Player.Anim_Controller.Bone_Hand)
		global_position = Global.Player.Anim_Controller.Bone_Hand.global_position
		global_rotation = Global.Player.Anim_Controller.Bone_Hand.global_rotation
		

func _physics_process(_delta):
	if launch and can_launch:
		can_launch = false
		_launch_disc()
	
	_detect_impact()
	_self_cull()
	
	power -= stats["Resistance"] if power > 0.0 else 0.0
	if !grounded:
		if power < stats["Speed"]: 
			# TODO: Apply Curve
			power = 0.0
		else:
			# TODO: Apply Pre-Curve
			pass
		
		if stats["Glide"]:
			var glide_amt = stats["Glide"]/2
			# TODO: Apply glide/loft

func _settle():
	if velocity.is_zero_approx():
		self.set_collision_mask_value(1, false)
		is_settled = true

func _detect_impact():
	var colliders = move_and_collide(velocity, true)
	print(colliders)
	#if colliders:
		#for node in colliders:
			#if node:
				#if node.is_in_group("Character"):
					#if in_play:
						#pass
					#else:
						#pick_up(node.Bag) 
				#if node.is_in_group("Solid"): 
					## TODO: Spawm pickup area
					#grounded = true
					#self.set_collision_mask_value(4, false)
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
