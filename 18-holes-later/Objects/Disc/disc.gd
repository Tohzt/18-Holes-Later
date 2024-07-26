extends RigidBody3D

@onready var spawn_pos : Vector3 = self.position
var target_dir : Vector3
var power : float
var power_resist: float

var grounded = false

var stats = {
	"Speed": 13, 
		# (1-14) Minimum power to throw stable
		"Glide": 5, 
		# How long it stays in the air (gravity delta)
		"Turn": -1,  
		# Expected distance vefore curve at perfect speed
		"Fade": 3,
		# How hard it wants to curve
		"Resistance": .5
		}

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(power * -target_dir)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	power -= stats["Resistance"]
	if power < stats["Speed"] and !grounded: 
		# TODO: Set curve from stats and back/forehand
		var curve = linear_velocity.rotated(Vector3(0,1,0), deg_to_rad(10))
		apply_central_force(curve)
		power = 0.0
	

	var collison = move_and_collide(Vector3.ZERO, true)
	if collison:
		var collider = collison.get_collider()
		if collider.is_in_group("Solid"):
			grounded = true

