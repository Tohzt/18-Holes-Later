extends Node3D
@onready var player = $Player
@onready var camera = $Camera3D

func _unhandled_input(_event):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("toggle_camera"):
		player.first_person = !player.first_person
		player.camera_node.current = !player.camera_node.current
