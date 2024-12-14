extends GPUParticles3D

@onready var height = global_position.y

func _process(_delta):
	global_position.y = height
