extends Node

# TODO: Get this from Master
@export_group("Perspective")
@export_enum("Top_Down", "Platformer", "Third_Person") var input_type = "Third_Person"
var input: Perspective

@onready var Master: Entity = $".."

func _ready():
	set_input_type()
	set_camera_mode()

func _process(delta):
	if input: input.handle_input(delta)
	else: set_input_type()

func set_input_type(input_name: String = input_type):
	for child_input in get_children():
		if child_input.name == input_name:
			input = child_input

func set_camera_mode(input_name: String = input_type):
	match input_name:
		"Third_Person":
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
