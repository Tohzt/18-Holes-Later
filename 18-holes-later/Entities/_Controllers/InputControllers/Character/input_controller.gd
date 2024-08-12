class_name InputController
extends Node

@onready var Master: Entity = $".."

func _process(_delta):
	_handle_input()

func _handle_input(): 
	print_debug("_handle_input not set")
