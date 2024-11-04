extends Node3D

func _ready():
	Global.Cameraman.rotation.y = 0

func _process(_delta):
	print(Global.Cameraman.rotation.y)
	if Global.Player.Input_Controller.character_look:
		Global.Player.Input_Controller.character_look = false
