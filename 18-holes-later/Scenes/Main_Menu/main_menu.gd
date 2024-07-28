extends Control
@onready var options_container = $"OptionsContainer"
@onready var profile_container = $ProfileContainer

func _ready():
	options_container.hide()


func _on_btn_new_game_pressed():
	Global.go_to_scene(Global.SCENE_CLUBHOUSE)

func _on_btn_continue_pressed():
	Global.Profile = "Profile 1"
	Global.go_to_scene(Global.SCENE_GAME)

func _on_btn_load_pressed():
	if profile_container.visible:
		profile_container.hide()
	else:
		options_container.hide()
		profile_container.show()

func _on_btn_options_pressed():
	if options_container.visible:
		options_container.hide()
	else:
		profile_container.hide()
		options_container.show()


func _on_btn_exit_pressed():
	get_tree().quit()
