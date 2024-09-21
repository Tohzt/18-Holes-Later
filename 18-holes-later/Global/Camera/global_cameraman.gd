extends Node3D
@onready var Tripod = $Tripod
@onready var Camera = $Tripod/Camera3D

var follow_target: Node3D
var look_target: Node3D

const SPEED = 10
var spd_mod: float = 1.0

func _process(delta):
	if follow_target:
		_follow_target(delta)
		_look_at_target(delta)

func _follow_target(delta):
	var follow_pos = Vector3(
		follow_target.position.x,
		look_target.global_position.y,
		follow_target.position.z,
	)
	position = follow_pos
	#if position.distance_to(follow_pos) > .5:
		#position = lerp(position, follow_pos, delta * 1) 
		#global_position = position.move_toward(follow_pos, SPEED * spd_mod * delta) 

func _look_at_target(_delta):
	look_at(look_target.global_position)

func set_target(new_target: Node3D, new_look: Node3D ):
	if !new_target:
		follow_target = Global.Player
	
	follow_target = new_target
	look_target = new_look
	Tripod.rotation.y = Tripod.rotation.direction_to(new_target.rotation).y
	
	# Reset rotation to looking direction
	if follow_target == Global.Player:
		Camera.rotation.x = Camera.rot_x
