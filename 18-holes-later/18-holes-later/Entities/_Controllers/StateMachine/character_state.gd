# NOTE: States should only pass on information. Do calculations where they are most relevant
class_name CharacterStateClass
extends Node

@onready var State_Controller: StateController = get_parent()
@onready var Master: Entity_Character = State_Controller.get_parent()

@export var state_options: Array[String]

func _process(_delta):
	if State_Controller.state_options.has(name):
		monitor_state()
	
	if Master.is_throwing:
		State_Controller.state_next = "Throw"

func monitor_state():
	print_debug("monitor_state is not set for: ", name)
func init_state():
	print_debug("init_state is not set for: ", name)
func update_state(_delta):
	print_debug("update_state is not set for: ", name)
func exit_state(_next_state: String): 
	print_debug("exit_state is not set for: ", name)
