extends UI_Class

func _ready():
	show_pos = position
	hide_pos = Vector2(show_pos.x + 330,show_pos.y)
	position = hide_pos

func _process(delta):
	super._process(delta)
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)
