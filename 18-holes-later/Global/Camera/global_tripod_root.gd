extends Node3D
@onready var Tripod = $Tripod

var target: Disc
const SPEED = 10

func _process(delta):
	rotation = Vector3.ZERO
	if target and position.distance_to(target.position) > .5:
		global_position = position.move_toward(target.position, SPEED * delta)

# TODO: This should be the main camera controller. 
#       Target player instead of player having its own SpringArm3D
