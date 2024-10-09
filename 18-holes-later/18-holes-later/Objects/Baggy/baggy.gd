extends RigidBody3D

@onready var start_pos := position
var target: Node3D
var rotation_speed := 5.0
 

func _physics_process(delta):
	if target:
		rotate_to_target(delta)
		if position.distance_to(Global.Player.position) > 5:
			target = null
	else: 
		if position.distance_to(Global.Player.position) < 5:
			target = Global.Player

func rotate_to_target(delta):
	# Get the direction to the target
	var direction = target.global_position - global_position
	
	# If the direction is zero, we don't need to rotate
	if direction.is_zero_approx():
		return
	
	# Create a basis that looks at the target
	var target_basis = Basis.looking_at(direction)
	
	# Interpolate the current rotation to the target rotation
	var new_basis = basis.slerp(target_basis, rotation_speed * delta)
	
	# Set the new basis (rotation)
	basis = new_basis
