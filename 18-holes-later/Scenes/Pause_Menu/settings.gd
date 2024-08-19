extends NinePatchRect

func _ready():
	hide()

func show_hide():
	if visible:
		hide()
	else:
		show()
