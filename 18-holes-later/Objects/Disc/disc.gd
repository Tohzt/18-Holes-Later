class_name Disc
extends RigidBody3D

var camera: Camera3D
var screen_position = Vector2(50, 50)  # 100 pixels from left and top
var distance_from_camera = 1.0  # Adjust this value as needed
var hud_gap = 50
var hud_offset = 1

var disc_name = ""
var disc_type = ""
var stats = {
	"Speed": 0,  # (1-14) Minimum power to throw stable
	"Glide": 0,  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  0,  # (1--5) Expected distance before curve at perfect speed
	"Fade":  0,  # (0-5)  How hard it wants to curve
	"Resistance": .5  # Rate that disc loses power
	}
  
var dmg = 5

var trigger_swarm = true
var in_hand = false

@onready var spawn_pos : Vector3 = self.position
var target_dir : Vector3
var power : float
var power_resist: float
var grounded = false
var handedness = 1

func _ready():
	pass

func launch():
	scale = Vector3(1,1,1)
	in_hand = false
	rotation = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	reparent(get_parent().get_parent().get_parent())
	apply_central_impulse(power/3 * -target_dir)

func _process(_delta):
	if !camera:
		camera = Global.Player.Camera
	if in_hand:
		#position = Global.Player.position
		#position.y = Global.Player.position.y + 3
		add_to_hud()
		
	_detect_impact()
	_self_cull()
	
	power -= stats["Resistance"] if power > 0.0 else 0.0
	
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

	var collison = move_and_collide(Vector3.ZERO, true)
	if collison:
		var collider = collison.get_collider()
		if collider.is_in_group("Solid"):
			grounded = true

func _detect_impact():
	for node in get_colliding_bodies():
		if node:
			if node.is_in_group("Character"):
				pick_up(node.Bag)
			#if node.is_in_group("Solid"):
				#self.set_collision_mask_value(2, true)
			#if trigger_swarm and node.is_in_group("Basket"):
				#trigger_swarm = false
				#get_tree().get_first_node_in_group("EnemyContainer").spawn_enemies(position)
			if node.is_in_group("Enemy"):
				node.take_damage(dmg)

func pick_up(node: Node):
	in_hand = true
	reparent(node)

func _self_cull():
	if position.y < -100:
		pick_up(Global.Player.Bag)
		#queue_free()

func add_to_hud():
	var screen_size = get_viewport().size
	var screen_position_normalized = Vector2(
		screen_position.x / screen_size.x,
		screen_position.y / screen_size.y
	)
	screen_position.x = hud_gap*hud_offset
	#print( hud_gap*hud_offset)
	print(screen_position)
	
	# Project a ray from the camera into the world
	var from = camera.project_ray_origin(screen_position)
	var to = from + camera.project_ray_normal(screen_position) * distance_from_camera
	
	# Set the position of this node
	global_transform.origin = to
	
	# Make the object perpendicular to the camera direction
	var camera_forward = -camera.global_transform.basis.z
	var up_vector = camera_forward
	var right_vector = camera_forward.cross(Vector3.UP).normalized()
	var forward_vector = up_vector.cross(right_vector).normalized()
	
	global_transform.basis = Basis(right_vector, up_vector, forward_vector)
	scale = Vector3(0.25, 0.25, 0.25)
