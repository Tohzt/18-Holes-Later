extends MeshInstance3D

#func _ready():
	## Check if the mesh already has a material
	#var material = get_surface_override_material(0)
	#
	## If it doesn't, create a new StandardMaterial3D
	#if material == null:
		#material = StandardMaterial3D.new()
		#set_surface_override_material(0, material)
	#
	## Generate a random color
	#var random_color = Color(randf(), randf(), randf())
	#
	## Set the albedo color of the material
	#material.albedo_color = random_color

func _process(_delta):
	# TODO: Optimize
	var material: Material = mesh.surface_get_material(0)
	if material:
		material.emission_enabled = false
		if get_parent().get_parent().is_in_group("Disc") and get_parent().get_parent().in_play:
			material.emission_enabled = true
