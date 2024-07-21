extends RigidBody3D

const SPEED = 5
const LIFT = .1
const JUMP_VELOCITY = 4.5

var dir := Vector2.ZERO
var velocity := Vector3.ZERO
var power = 0.0
var tilt := 0.0
var spin := 0.0
var game_disc = false
var grounded = false
var in_hand = true

func _ready():
	# TODO: Set Rotatation from Tilt
	pass

func _physics_process(_delta):
	if in_hand and power != 0:
		in_hand = false
		dir *= power
		
		# Spin on the discs Normal
		apply_torque(Vector3(0,spin,0))
		apply_central_impulse(Vector3(dir.x,tilt,dir.y))
		
	detect_collision()

func detect_collision():
	var collison = move_and_collide(velocity, true)
	if collison:
		var collider = collison.get_collider()
		if collider.is_in_group("Solid"):
			grounded = true
			return true
	return false

