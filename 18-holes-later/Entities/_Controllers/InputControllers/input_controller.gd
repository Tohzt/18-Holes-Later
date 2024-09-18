class_name InputController
extends Node

@onready var Master: Node3D = $".."

func _process(_delta):
	if Master.accepts_input: _handle_input()

func _handle_input(): 
	print_debug("_handle_input not set")
