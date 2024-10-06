extends Control

@onready var settings_container := $MarginContainer/Settings
@onready var show_pos: Vector2
@onready var hide_pos: Vector2
var slide_in = true
var slide_out = false

func _ready():
	var exported_variables = Global.Settings.export_variables()
	for var_name in exported_variables:
		create_setting_control(var_name)
	show_pos = position
	hide_pos = Vector2(show_pos.x + 500, show_pos.y)

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta * 10)
	if slide_out:
		position = lerp(position, hide_pos, delta * 10)

func create_setting_control(var_name: String):
	var value = Global.Settings.get_property_value(var_name)
	var type = typeof(value)
	
	match type:
		TYPE_BOOL:
			var hbox = HBoxContainer.new()
			hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			var label = Label.new()
			label.text = var_name
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			label.add_theme_color_override("font_color", Color.BLACK)
			hbox.add_child(label)
			
			var spacer = Control.new()
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			hbox.add_child(spacer)
			
			var checkbox = CheckBox.new()
			checkbox.flat = true
			checkbox.button_pressed = value
			checkbox.connect("toggled", Callable(self, "_on_bool_setting_changed").bind(var_name))
			checkbox.size_flags_horizontal = Control.SIZE_SHRINK_END
			hbox.add_child(checkbox)
			
			settings_container.add_child(hbox)
		
		TYPE_STRING, TYPE_FLOAT, TYPE_INT:
			var vbox = VBoxContainer.new()
			vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			var label = Label.new()
			label.text = var_name
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			label.add_theme_color_override("font_color", Color.BLACK)
			vbox.add_child(label)
			
			match type:
				TYPE_STRING:
					var line_edit = LineEdit.new()
					line_edit.text = value
					line_edit.connect("text_changed", Callable(self, "_on_text_setting_changed").bind(var_name))
					line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					vbox.add_child(line_edit)
				
				TYPE_FLOAT:
					var hbox = HBoxContainer.new()
					hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					
					var slider = HSlider.new()
					slider.min_value = 0.0
					slider.max_value = 1.0
					slider.step = 0.05
					slider.value = value
					slider.connect("value_changed", Callable(self, "_on_slider_setting_changed").bind(var_name))
					slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					hbox.add_child(slider)
					
					var value_label = Label.new()
					value_label.text = "%.2f" % value
					value_label.size_flags_horizontal = Control.SIZE_SHRINK_END
					value_label.custom_minimum_size.x = 40
					hbox.add_child(value_label)
					
					slider.connect("value_changed", func(new_value): value_label.text = "%.2f" % new_value)
					
					vbox.add_child(hbox)
				
				TYPE_INT:
					var slider = HSlider.new()
					slider.min_value = 0
					slider.max_value = 100
					slider.value = value
					slider.connect("value_changed", Callable(self, "_on_int_setting_changed").bind(var_name))
					slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					vbox.add_child(slider)
			
			settings_container.add_child(vbox)
		_:
			print_debug("Unsupported type for " + var_name + ": " + str(type))

func _on_slider_setting_changed(new_value: float, var_name: String):
	Global.Settings.set_property_value(var_name, new_value)

func _on_bool_setting_changed(button_pressed: bool, var_name: String):
	Global.Settings.set(var_name, button_pressed)

func _on_text_setting_changed(new_text: String, var_name: String):
	Global.Settings.set(var_name, new_text)

func _on_int_setting_changed(new_value: float, var_name: String):
	Global.Settings.set(var_name, int(new_value))
