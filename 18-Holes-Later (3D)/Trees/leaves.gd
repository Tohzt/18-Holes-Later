extends StaticBody3D

func _process(_delta):
	var collision = move_and_collide(Vector3.ZERO, true)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Disc"):
			get_parent().start_wiggle()
