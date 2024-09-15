extends Node3D
@onready var Tripod = $Tripod
@onready var Camera = $Tripod/Camera3D
@onready var Target: Node3D

const SPEED = 10

func _process(delta):
	rotation = Vector3.ZERO
	if Target and position.distance_to(Target.position) > .5:
		global_position = position.move_toward(Target.position, SPEED * delta)

func snap_to(target: Node3D):
	if target == null:
		Target = Global.Player
	Target = target
	Tripod.rotation.y = Tripod.rotation.direction_to(target.rotation).y
	
	# Reset rotation to looking direction
	if Target == Global.Player:
		Camera.rotation.x = Camera.rot_x
