extends Button
@onready var debug_settings = $MarginContainer/Debug_Settings


func _on_pressed():
	debug_settings.show_hide()
