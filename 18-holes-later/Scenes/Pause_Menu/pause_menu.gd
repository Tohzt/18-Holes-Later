extends CanvasLayer

func _process(_delta):
	#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
	if Input.is_action_just_pressed("ui_cancel"):
		if(visible):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$DEBUG.hide()
			hide()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$DEBUG.show()
			show()

func _on_btn_exit_pressed():
	# WARNING: This could close before save is complete 
	#get_parent().save_game()
	get_tree().quit()

func _on_btn_resume_pressed():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.is_paused = false


func _on_btn_retry_pressed():
	Global.Bag.clear()
	get_tree().change_scene_to_file("res://Scenes/Main_Menu/main_menu.tscn")
