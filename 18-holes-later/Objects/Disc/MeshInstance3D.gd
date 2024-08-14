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
