extends Area3D

func _ready():
	hide()

func _process(_delta):
	if get_collision_layer_value(2):
		show()
	else:
		hide()
