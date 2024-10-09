extends Node
class_name SettingsClass

@export var collect_all: bool = false
@export var draw_debug_lines: bool = false
@export var draw_disc_trails: bool = false
@export var follow_all_throws: bool = false
@export var print_debug_log: bool = false
@export_range(0.1, 1.0) var MOUSE_H_SENSITIVITY: float = 0.2
@export_range(0.1, 1.0) var MOUSE_V_SENSITIVITY: float = 0.2

var debug_log: Dictionary

func _ready():
	# Ensure that the mouse sensitivity values are correctly initialized
	if MOUSE_H_SENSITIVITY == 0:
		MOUSE_H_SENSITIVITY = 0.2
	if MOUSE_V_SENSITIVITY == 0:
		MOUSE_V_SENSITIVITY = 0.2

func export_variables() -> Array:
	var property_list = get_property_list()
	var exported_vars = []
	for property in property_list:
		# Check if the property is exported and a variable (not a method)
		if property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE and property["usage"] & PROPERTY_USAGE_EDITOR:
			exported_vars.append(property["name"])
	return exported_vars

func _process(_delta):
	_update_debug_info()

var line_count = 0

func _update_debug_info():
	if print_debug_log and debug_log.size():
		print_rich("[color=orange]Debug_Log:[/color]", debug_log)

# Add a method to get the current value of a property
func get_property_value(property_name: String):
	return get(property_name)

# Add a method to set the value of a property
func set_property_value(property_name: String, value):
	set(property_name, value)
