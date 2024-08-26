extends Control
@onready var settings_container = $MarginContainer/Settings

func _ready():
	hide()
	var exported_variables = Global.Debug_Settings.export_variables()
	for var_name in exported_variables:
		create_setting_control(var_name)

func create_setting_control(var_name: String):
	var value = Global.Debug_Settings.get(var_name)
	var type = typeof(value)
	
	match type:
		TYPE_BOOL:
			var checkbox = CheckButton.new()
			checkbox.text = var_name
			checkbox.button_pressed = value
			# Connect the "toggled" signal to a new function
			checkbox.connect("toggled", Callable(self, "_toggled_bool_setting").bind(var_name))
			settings_container.add_child(checkbox)
			update_min_size()
		_:
			print_debug("Unsupported type for " + var_name + ": " + str(type))

# Add this new function to handle the signal
func _toggled_bool_setting(button_pressed: bool, var_name: String):
	Global.Debug_Settings.set(var_name, button_pressed)

func update_min_size():
	custom_minimum_size = Vector2(0, settings_container.get_minimum_size().y)

func show_hide():
	if visible:
		hide()
	else:
		show()
