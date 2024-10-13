extends CharacterBody3D
@onready var Tripod = $Tripod
@onready var Tripos_StartRot = Tripod.rotation
@onready var Camera = $Tripod/Camera3D

var follow_target: Node3D
var look_target: Node3D
var rot_x = 0.0

const SPEED = 5
var spd_mod: float = 1.0

func _process(_delta):
	Camera.rotation.y = 0
	Camera.rotation.z = 0
	
	if !follow_target: return
	if follow_target == Global.Player:
		Tripod.rotation.x = rot_x
	if follow_target.is_in_group("Launcher"):
		Tripod.rotation.x = rot_x
		#follow_target.Barrel_Pivot.rotation.x = rot_x

func _physics_process(delta):
	if follow_target:
		_follow_target(delta)
		_look_at_target(delta)

func _follow_target(delta):
	var follow_pos = Vector3(
		follow_target.position.x,
		look_target.global_position.y,
		follow_target.position.z,
	)
	
	var dist_to_target = position.distance_to(follow_pos)
	if dist_to_target > .05:
		spd_mod = lerp(0,5,dist_to_target/5)
		var spd = SPEED + spd_mod
		position = lerp(position, follow_pos, delta * spd) 
	else: 
		position = follow_pos

func _look_at_target(delta):
	if follow_target.can_look:
		rotation.y = lerp_angle(rotation.y, follow_target.rotation.y, delta*10)

func set_target(new_target: Node3D, new_look: Node3D ):
	if follow_target:
		follow_target.accepts_input = false
		
	if !new_target:
		new_target = Global.Player
	if !new_look:
		new_look = new_target.get_node("CamFocus")
	
	new_target.accepts_input = true
	follow_target = new_target
	look_target = new_look
	
	Tripod.rotation = Tripos_StartRot
