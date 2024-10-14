extends NinePatchRect
@onready var show_pos: Vector2 = position
@onready var hide_pos := Vector2(show_pos.x+700,show_pos.y)

var slide_in = false
var slide_out = false

func _ready():
	position = hide_pos

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)

func _on_btn_select_clubhouse_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.CLUBHOUSE_INTERIOR, "Clubhouse_Interior")

func _on_btn_select_hole_01_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.HOLE_01, "Hole_01")

func _on_btn_select_testing_pressed():
	Global.go_to_course(Global.Refs.SCENE_COURSE, Global.Refs.TESTING_ROOM, "Testing_Room")
