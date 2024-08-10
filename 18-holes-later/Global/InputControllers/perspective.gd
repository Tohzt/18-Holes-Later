class_name InputController
extends Node

@onready var Master: Entity = $".."

func _ready():
	pass
	#set_input_type()
	#set_camera_mode()

func _process(delta):
	handle_input(delta)

func init():
	print_debug("Init not set..!")
func handle_input(_delta):
	print_debug("Input not set..!")
