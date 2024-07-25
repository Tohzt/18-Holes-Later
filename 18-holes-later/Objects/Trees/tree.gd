extends StaticBody3D


func _ready():
	scale *= [0.75, 1, 0.5].pick_random()
	# TODO: Prevent spawning trees on top of one another

func _process(_delta):
	pass
