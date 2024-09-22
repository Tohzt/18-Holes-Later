extends CanvasLayer

@onready var disc_selection_container = $DiscSelectionContainer
@onready var course_selection_container = $CourseSelectionContainer

var selected_index = -1

func _ready():
	disc_selection_container.hide()
	course_selection_container.hide()

func _process(_delta):
	pass

func _select_putter_pressed():
	selected_index = 0

func _select_hybrid_pressed():
	selected_index = 1
	
func _select_driver_pressed():
	selected_index = 2

func _on_btn_select_disc_pressed():
	if disc_selection_container.visible:
		disc_selection_container.hide()
		course_selection_container.show()
	else:
		disc_selection_container.show()
		course_selection_container.hide()

func _on_btn_select_course_pressed():
	if course_selection_container.visible:
		course_selection_container.hide()
		disc_selection_container.show()
	else:
		course_selection_container.show()
		disc_selection_container.hide()

func _on_btn_hole_01_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.HOLE_01, "Hole_01")

func _on_btn_testing_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.TESTING_ROOM, "Testing_Room")
