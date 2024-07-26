extends CanvasLayer

func _process(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		hide()
	else:
		show()

func _on_btn_exit_pressed(): 
	get_tree().quit()

func _on_btn_resume_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
