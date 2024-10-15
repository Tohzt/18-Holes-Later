extends Control
@onready var Menu_Container = $MenuContainer
@onready var Character_Container = $"CharacterContainer"
@onready var Course_Container = $CourseContainer
@onready var Profile_Container = $ProfileContainer

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Menu_Container.slide_in = true
		Menu_Container.slide_out = false
		Character_Container.slide_in = false
		Character_Container.slide_out = true
		Course_Container.slide_in = false
		Course_Container.slide_out = true

func _on_btn_new_game_pressed():
	Menu_Container.slide_in = false
	Menu_Container.slide_out = true
	Character_Container.slide_in = true
	Character_Container.slide_out = false

func _on_btn_continue_pressed():
	# TODO: Default Test Profile 1.. Remove later
	Global.Profile = "Profile 1"
	Global.should_load = true
	Global.go_to_scene(Global.Refs.SCENE_COURSE)

func _on_btn_load_pressed():
	if Profile_Container.visible:
		Profile_Container.hide()
	else:
		Course_Container.hide()
		Profile_Container.show()

func _on_btn_options_pressed():
	if Course_Container.visible:
		Course_Container.hide()
	else:
		Profile_Container.hide()
		Course_Container.show()


func _on_btn_exit_pressed():
	get_tree().quit()
