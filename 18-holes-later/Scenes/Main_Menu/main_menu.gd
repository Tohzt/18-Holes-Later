extends Control
const GAME = "res://Scenes/Game/game.tscn"

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_btn_start_pressed():
	get_tree().change_scene_to_file(GAME)

func _on_btn_exit_pressed():
	get_tree().quit()
