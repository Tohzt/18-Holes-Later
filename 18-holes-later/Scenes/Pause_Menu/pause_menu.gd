extends CanvasLayer

func _process(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$DEBUG.hide()
		hide()
	else:
		$DEBUG.show()
		show()

func _on_btn_exit_pressed():
	# WARNING: This couls close before save is complete 
	Global.Scene.save_game()
	get_tree().quit()

func _on_btn_resume_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_btn_retry_pressed():
	Global.Bag.clear()
	get_tree().change_scene_to_file("res://Scenes/Main_Menu/main_menu.tscn")
