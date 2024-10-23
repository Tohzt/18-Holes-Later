extends Area3D
@onready var character_container = $CanvasLayer/CharacterContainer

func interact():
	character_container.toggle_slide()
	print("Interacting with Character Select")
