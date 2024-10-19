class_name UI_Class
extends NinePatchRect

@onready var show_pos: Vector2 = position
@onready var hide_pos := Vector2(show_pos.x-700,show_pos.y)
var slide_in = false
var slide_out = false

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)

func toggle_slide():
	slide_out = slide_in
	slide_in = !slide_in
