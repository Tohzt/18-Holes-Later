extends Control
@onready var Menu_Container = $MenuContainer
@onready var Options_Container = $"OptionsContainer"
@onready var Profile_Container = $ProfileContainer

#func _ready():
	#Options_Container.hide()

func _on_btn_new_game_pressed():
	Menu_Container.slide_in = false
	Menu_Container.slide_out = true
	Options_Container.slide_in = true
	Options_Container.slide_out = false

func _on_btn_continue_pressed():
	# TODO: Default Test Profile 1.. Remove later
	Global.Profile = "Profile 1"
	Global.should_load = true
	Global.go_to_scene(Global.Refs.SCENE_COURSE)

func _on_btn_load_pressed():
	if Profile_Container.visible:
		Profile_Container.hide()
	else:
		Options_Container.hide()
		Profile_Container.show()

func _on_btn_options_pressed():
	if Options_Container.visible:
		Options_Container.hide()
	else:
		Profile_Container.hide()
		Options_Container.show()


func _on_btn_exit_pressed():
	get_tree().quit()


func _on_btn_select_layla_pressed():
	Global.go_to_scene(Global.Refs.SCENE_CLUBHOUSE)
