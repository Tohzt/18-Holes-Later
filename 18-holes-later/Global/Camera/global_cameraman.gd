extends CharacterBody3D
@onready var Tripod = $Tripod
@onready var Camera = $Tripod/Camera3D

var follow_target: Node3D
var look_target: Node3D
var offset_y = 0

const SPEED = 600
var spd_mod: float = 1.0

func _physics_process(delta):
	if follow_target:
		_follow_target(delta)
		_look_at_target(delta)

func _follow_target(delta):
	var follow_pos = Vector3(
		follow_target.position.x,
		look_target.global_position.y + offset_y,
		follow_target.position.z,
	)
	
	var dist_to_target = position.distance_to(follow_pos)
	if dist_to_target > .1:
		spd_mod = lerp(0,500,dist_to_target/5)
		var spd = SPEED + spd_mod
		velocity = ( follow_pos - position).normalized() * spd * delta
		#position = lerp(position, follow_pos, delta * 10) 
	# TODO: Stutter caused when camera catches up to target
	else: velocity = Vector3.ZERO
	
	move_and_slide()

func _look_at_target(delta):
	# TODO: Remove player reference and pass in bool on set_target
	# TODO: Not sure if this is still needed
	if follow_target.can_look:
		rotation.y = lerp_angle(rotation.y, follow_target.rotation.y, delta*10)

func set_target(new_target: Node3D, new_look: Node3D ):
	if !new_target:
		new_target = Global.Player
	if !new_look:
		new_look = new_target.get_node("CamFocus")
	
	follow_target = new_target
	look_target = new_look
