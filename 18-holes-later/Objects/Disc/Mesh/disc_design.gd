extends MeshInstance3D

func _process(_delta):
	# TODO: Optimize
	var material: Material = mesh.surface_get_material(0)
	if material:
		material.emission_enabled = false
		if get_parent().get_parent().in_play:
			material.emission_enabled = true
