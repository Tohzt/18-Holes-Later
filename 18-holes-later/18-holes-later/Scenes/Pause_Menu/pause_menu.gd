extends Control
@onready var pause_header = $PauseHeader
@onready var debug_settings = $Settings

# TODO: This needs some work. Not yet explored since UI_Class
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if(Global.is_paused):
			_hide_pause()
		else:
			_show_pause()

func _show_pause():
	Global.is_paused = true
	pause_header.toggle_slide(true)

func _hide_pause():
	Global.is_paused = false
	pause_header.toggle_slide(false)

func _on_btn_exit_pressed():
	# WARNING: This could close before save is complete 
	#get_parent().save_game()
	get_tree().quit()

func _on_btn_resume_pressed():
	_hide_pause()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.is_paused = false

func _on_btn_retry_pressed():
	_hide_pause()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Global.Cameraman.follow_target = null
	Global.go_to_scene(Global.Refs.SCENE_MAIN)

func _on_btn_save_pressed():
	Global.save_game(Global.Profile)
