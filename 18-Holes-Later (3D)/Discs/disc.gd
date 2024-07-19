extends RigidBody3D

const SPEED = 5
const LIFT = .1
const JUMP_VELOCITY = 4.5

var height = 0.0
#var dir = Vector3(1,0,0)
var velocity := Vector3.ZERO
var power = 0.0

var tilt := 0.0
var grounded = false

func _ready():
	# TODO: Get direction from player
	rotation.z = deg_to_rad(tilt)
	
	#var direction = (transform.basis * dir).normalized()
	#if direction:
		#velocity = Vector3(
			#direction.x * SPEED,
			#tilt * LIFT, 
			#direction.z * SPEED)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	#
	#apply_central_impulse(velocity)

func _physics_process(_delta):
	detect_collision()


func detect_collision():
	var collison = move_and_collide(velocity, true)
	if collison:
		var collider = collison.get_collider()
		if collider.is_in_group("Solid"):
			grounded = true
			return true
	return false
