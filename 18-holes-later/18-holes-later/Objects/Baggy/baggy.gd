extends Entity

@onready var start_pos := position
var rotation_speed := 5.0
var targets_in_range: Array[Node3D]

func _physics_process(delta):
	pass

func rotate_to_target(delta):
	var direction = Target.global_position - global_position
	if direction.is_zero_approx(): return
	
	var target_basis = Basis.looking_at(direction)
	var new_basis = basis.slerp(target_basis, rotation_speed * delta)
	
	basis = new_basis
