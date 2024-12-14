extends CharacterBody3D
@onready var Tripod = $Tripod
@onready var Tripos_StartRot = Tripod.rotation
@onready var Camera = $Tripod/Camera3D

var Target: Node3D
var look_target: Node3D

var chase = false
var SPEED = 2.5
var spd_mod: float = 1.0

const fov_min = 75.0
const fov_max = 100.0

func _process(delta):
	Camera.rotation.y = 0
	Camera.rotation.z = 0
	
	if !Target: return
	if Target == Global.Player:
		Tripod.rotation.x = Target.input_look.x
	
	if Target:
		_follow_target(delta)
		if chase: _chase_target(delta)
		else: _orbit_target(delta)


func _follow_target(delta):
	var follow_pos = Target.get_node("Cam_Mount").global_position
	var dist_to_target = position.distance_to(follow_pos)
	 
	chase = Target.is_running if Target.is_in_group("Character") else false
	if chase:
		Camera.fov = lerp(Camera.fov, fov_max, delta * 5)
	else:
		Camera.fov = lerp(Camera.fov, fov_min, delta * 5)
	position = follow_pos


func _chase_target(delta):
	#Camera.fov = lerp(Camera.fov,120.0,delta*5)
	if Target.look_forward:  
		rotation.y = lerp_angle(rotation.y, Target.Cam_Mount.global_rotation.y, delta)
	if Target.look_around and !Target.look_forward: 
		rotation.y = lerp_angle(rotation.y, Target.input_look.y, delta*10)


func _orbit_target(delta):
	#Camera.fov = lerp(Camera.fov,75.0,delta*10)
	if !Target: return
	var target_pos = Target.get_node("Cam_Mount").global_position
	
	if Target.look_forward:
		var target_rotation = Target.Cam_Mount.global_rotation.y
		global_position = target_pos + (global_position - target_pos).rotated(Vector3.UP, 
			lerp_angle(0, target_rotation - rotation.y, delta))
		rotation.y = target_rotation
		
	elif Target.look_around:
		var target_rotation = Target.input_look.y
		global_position = target_pos + (global_position - target_pos).rotated(Vector3.UP, lerp_angle(0, target_rotation - rotation.y, delta * 10))
		rotation.y = target_rotation

func set_target(new_target: Node3D = null):
	if !new_target:
		Target.queue_free()
		look_target.queue_free()
		new_target = Global.Player
		
	if Target:
		Target.set_active(false)
	
	Target = new_target
	Target.set_active(true)
	look_target = Target.Cam_Mount
	
	#Tripod.rotation = Tripos_StartRot
