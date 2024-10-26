extends Node3D

func _ready():
	if Global.Player:
		Global.Player.Input_Controller.character_look = false
