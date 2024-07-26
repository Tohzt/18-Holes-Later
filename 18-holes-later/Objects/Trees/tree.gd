extends StaticBody3D

@onready var sprite_3d = $Sprite3D

func _ready():
	scale *= [0.75, 1, 0.5].pick_random()
	# Ensure the sprite has a material override
	if sprite_3d.material_override == null:
		sprite_3d.material_override = ShaderMaterial.new()
	# Assign the shader to the material override
	#sprite_3d.material_override.shader = load("res://Objects/Trees/tree_shake.gdshader")


func trigger_wiggle():
	# Reset the time offset to current time to restart the wiggle
	sprite_3d.material_override.set_shader_parameter("time_offset", Time.get_ticks_msec() / 1000.0)
