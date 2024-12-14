extends Button
@onready var settings = $"../../../Settings"

func _on_pressed():
	settings.toggle_slide()
