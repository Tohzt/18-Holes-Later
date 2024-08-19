extends CheckButton

func _on_toggled(toggled_on):
	print(self.text)
	Global.Debug_Settings.draw_debug_lines = toggled_on
