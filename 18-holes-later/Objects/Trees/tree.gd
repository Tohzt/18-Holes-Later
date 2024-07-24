extends StaticBody3D


func _ready():
	scale *= [0.75, 1, 0.5].pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
