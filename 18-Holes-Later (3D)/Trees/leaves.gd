extends StaticBody3D

func _process(delta):
	var collision = move_and_collide(Vector3.ZERO, true)
	if collision:
		get_parent().start_wiggle()
