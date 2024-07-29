class_name Disc
extends RigidBody3D

#@onready var disc_name = Global.Scene.Bag[Global.Scene.game_disc_index][0]
#@onready var disc_type = Global.Scene.Bag[Global.Scene.game_disc_index][1]
#@onready var stats = {
	#"Speed": Global.Scene.Bag[Global.Scene.game_disc_index][2],  # (1-14) Minimum power to throw stable
	#"Glide": Global.Scene.Bag[Global.Scene.game_disc_index][3],  # (1-7)  How long it stays in the air (gravity delta)
	#"Turn":  Global.Scene.Bag[Global.Scene.game_disc_index][4],  # (1--5) Expected distance before curve at perfect speed
	#"Fade":  Global.Scene.Bag[Global.Scene.game_disc_index][5],  # (0-5)  How hard it wants to curve
	#"Resistance": .5  # Rate that disc loses power
	#}
var disc_name = ""
var disc_type = ""
var stats = {
	"Speed": 0,  # (1-14) Minimum power to throw stable
	"Glide": 0,  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  0,  # (1--5) Expected distance before curve at perfect speed
	"Fade":  0,  # (0-5)  How hard it wants to curve
	"Resistance": .5  # Rate that disc loses power
	}

@onready var spawn_pos : Vector3 = self.position
var target_dir : Vector3
var power : float
var power_resist: float
var grounded = false
var handedness = 1

func _ready():
	apply_central_impulse(power/3 * -target_dir)

func _process(_delta):
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

func _self_cull():
	if position.y < -100:
		queue_free()
