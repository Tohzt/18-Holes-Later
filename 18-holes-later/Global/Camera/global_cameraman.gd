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
	if position.distance_to(follow_pos) > .01:
		position = lerp(position, follow_pos, delta * 10) 

func _look_at_target(delta):
	rotation.y = lerp_angle(rotation.y, follow_target.rotation.y, delta*10)

func set_target(new_target: Node3D, new_look: Node3D ):
	if !new_target:
		follow_target = Global.Player
	
	follow_target = new_target
	look_target = new_look
