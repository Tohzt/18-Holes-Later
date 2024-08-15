class_name Disc
extends RigidBody3D
@onready var in_play_mesh = $_InPlayMesh

var index = 1
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
var in_bag = false
var in_hand = false
@export var in_play = false

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
	in_bag = false
	in_hand = false
	rotation = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	reparent(get_parent().get_parent().get_parent())
	apply_central_impulse(power/3 * -target_dir)

func _process(_delta):
	#if in_play:
		#in_play_mesh.show()
	#else:
		#in_play_mesh.hide()
		
	if in_bag:
		if index == Global.selected_disc:
			scale = Vector3.ONE * .5
	
func _physics_process(_delta):
	if in_bag:
		#position = Global.Player.position
		#position.y = Global.Player.position.y + 3
		Global.add_disc_to_bag(self)
	
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
				if in_play:
					pass
				pick_up(node.Bag)
			#if node.is_in_group("Solid"):
				#self.set_collision_mask_value(2, true)
			#if trigger_swarm and node.is_in_group("Basket"):
				#trigger_swarm = false
				#get_tree().get_first_node_in_group("EnemyContainer").spawn_enemies(position)
			if node.is_in_group("Enemy"):
				node.take_damage(dmg)

func pick_up(node: Node):
	in_bag = true
	reparent(node)

func _self_cull():
	if position.y < -100:
		pick_up(Global.Player.Bag)
		#queue_free()


