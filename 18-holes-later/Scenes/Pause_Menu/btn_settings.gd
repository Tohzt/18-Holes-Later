extends Button
@onready var settings = $"../../../Settings"

func _on_pressed():
	if settings.slide_in:
		settings.slide_in = false
		settings.slide_out = true
	else:
		settings.slide_in = true
		settings.slide_out = false
