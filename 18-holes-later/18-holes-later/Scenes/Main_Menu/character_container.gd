extends NinePatchRect
@onready var show_pos: Vector2 = position
@onready var hide_pos := Vector2(show_pos.x-700,show_pos.y)

var slide_in = false
var slide_out = false

func _ready():
	position = hide_pos

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)


func _on_btn_select_layla_pressed():
	slide_in = false
	slide_out = true
	get_parent().Course_Container.slide_in = true
	get_parent().Course_Container.slide_out = false
