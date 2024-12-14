extends CanvasLayer

func _process(_delta):
	# TODO: Trigger from player interact
	if(Input.is_action_just_released("bag")):
		if(!visible):
			show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			pass
	pass
