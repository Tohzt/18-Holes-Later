extends NinePatchRect
@onready var hide_pos: Vector2 = position
@onready var show_pos := Vector2(hide_pos.x,hide_pos.y+150)

var slide_in = false
var slide_out = false

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)
