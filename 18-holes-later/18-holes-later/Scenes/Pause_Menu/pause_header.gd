extends UI_Class

func _ready():
	show_pos = position
	hide_pos = Vector2(show_pos.x,show_pos.y-150)
	position = hide_pos

func _process(delta):
	super._process(delta)
