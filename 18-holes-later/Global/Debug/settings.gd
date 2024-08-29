extends Node
class_name SettingsClass

# TODO: Add to Settings
@export var MOUSE_SENSITIVITY : float = 0.4

func export_variables() -> Array:
	var property_list = get_property_list()
	var exported_vars = []
	for property in property_list:
		# Check if the property is exported and a variable (not a method)
		if property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE and property["usage"] & PROPERTY_USAGE_EDITOR:
			exported_vars.append(property["name"])
	return exported_vars
