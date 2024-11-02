extends Node3D

func _process(_delta):
	if Global.Player.Input_Controller.character_look:
		Global.Player.Input_Controller.character_look = false
