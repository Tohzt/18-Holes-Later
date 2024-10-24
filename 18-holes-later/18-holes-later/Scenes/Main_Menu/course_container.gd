extends UI_Class

func _ready():
	show_pos = position
	hide_pos = Vector2(show_pos.x,show_pos.y)
	position = hide_pos

func _process(delta):
	super._process(delta)
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)

func _on_btn_select_hole_01_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.HOLE_01, "Hole_01")

func _on_btn_select_testing_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.TESTING_ROOM, "Testing_Room")
