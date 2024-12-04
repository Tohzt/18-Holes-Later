extends UI_Class

@onready var settings_container := $MarginContainer/Settings

func _ready():
	var exported_variables = Global.Settings.export_variables()
	for var_name in exported_variables:
		create_setting_control(var_name)
	show_pos = position
	hide_pos = Vector2(show_pos.x + 500, show_pos.y)
	position = hide_pos

func _process(delta):
	super._process(delta)

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
					var int_vbox = VBoxContainer.new()
					int_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					
					var int_label = Label.new()
					int_label.text = var_name
					int_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					int_label.add_theme_color_override("font_color", Color.BLACK)
					int_vbox.add_child(int_label)
					
					# Get property info to check for export range
					var property_list = Global.Settings.get_property_list()
					var min_value = 0
					var max_value = 100
					
					for property in property_list:
						if property["name"] == var_name:
							if "hint" in property and property["hint"] == PROPERTY_HINT_RANGE:
								var hint_string = property["hint_string"].split(",")
								min_value = float(hint_string[0])
								max_value = float(hint_string[1])
							break
					
					var slider = HSlider.new()
					slider.min_value = min_value
					slider.max_value = max_value
					slider.value = value
					slider.connect("value_changed", Callable(self, "_on_int_setting_changed").bind(var_name))
					slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					vbox.add_child(slider)
					
					#settings_container.add_child(vbox)
			
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
