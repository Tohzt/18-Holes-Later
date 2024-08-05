class_name InputController
extends Node

var input: Perspective

@onready var Master: Entity = $".."

func _ready():
	set_input_type()

func _process(delta):
	_test_action("Player")
	if input: input.handle_input(delta)
	else: set_input_type()

func set_input_type():
	for child_input in get_children():
		if child_input:
			input = child_input
			input.init()

func _test_action(master):
	if Master.name == master:
		if Input.is_action_just_pressed("left_click"):
			Master.get_node("AnimationPlayer").play("attack")
			#var disc = Global.DISC.instantiate()
			#disc.position = Global.Player.get_node("Hand").position
			#disc.in_hand = true
			#Master.get_node("Hand").add_child(disc)
