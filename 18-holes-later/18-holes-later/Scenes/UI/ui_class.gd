class_name UI_Class
extends NinePatchRect

@onready var show_pos: Vector2
@onready var hide_pos: Vector2
var slide_in = false
var slide_out = false

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)

func toggle_slide(TorF = null):
	if TorF == null:
		slide_out = slide_in
		slide_in = !slide_in
	else:
		slide_in = TorF
		slide_out = !TorF
	
	if slide_in:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if slide_out:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
