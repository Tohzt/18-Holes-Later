extends RigidBody3D

@export_category("Stats")
var stats = {
	"Speed": Global.debug_stats[0],  # (1-14) Minimum power to throw stable
	"Glide": Global.debug_stats[1],  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  Global.debug_stats[2],  # (1--5) Expected distance before curve at perfect speed
	"Fade":  Global.debug_stats[3],  # (0-5)  How hard it wants to curve
	"Resistance": .5  # Rate that disc loses power
	}

@onready var spawn_pos : Vector3 = self.position
var target_dir : Vector3
var power : float
var power_resist: float
var grounded = false
var handedness = 1

func _ready():
	print(stats)
	apply_central_impulse((power * -target_dir)/2)

func _process(_delta):
	power -= stats["Resistance"] if power > 0.0 else 0.0
	
	if power < stats["Speed"]: 
		var curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Fade"] * handedness))
		apply_central_force(curve)
		power = 0.0
	else:
		var pre_curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10 * stats["Turn"] * handedness))
		apply_central_force(pre_curve)
		
	
	if stats["Glide"]:
		var glide_amt = stats["Glide"]
		apply_central_force(Vector3(0,glide_amt,0))

	var collison = move_and_collide(Vector3.ZERO, true)
	if collison:
		var collider = collison.get_collider()
		if collider.is_in_group("Solid"):
			grounded = true

