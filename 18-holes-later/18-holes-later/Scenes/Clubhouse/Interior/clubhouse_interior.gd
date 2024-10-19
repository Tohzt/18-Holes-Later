extends Node3D

func _ready():
	var benny = get_tree().get_first_node_in_group("Benny")
	benny.set_active(false)
