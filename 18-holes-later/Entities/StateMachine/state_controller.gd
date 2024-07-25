class_name StateController
extends Node

@onready var state_current: State = $Idle
var state_next: String = "Idle"
var state_options: Array[String]

func _process(_delta):
	if state_current.name != state_next:
		_change_state(state_next)
	state_current.update_state()

func _change_state(next: String):
	for state in get_children():
		if state.name == next:
			state_current = state
			state_current.init_state()
			return
	print_debug("State Not Set")
