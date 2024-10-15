extends GPUParticles3D

func _on_finished():
	queue_free()
