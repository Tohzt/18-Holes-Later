extends CanvasLayer

func _process(_delta):
	if(Input.is_action_just_released("bag")):
		if(!visible):
			show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
