extends StaticBody3D

func _process(delta):
	var collision = move_and_collide(Vector3.ZERO, true)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Disc"):
			collider.freeze = true
			print("SCORE!")
