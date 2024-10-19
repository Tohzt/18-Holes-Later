extends UI_Class

func _ready():
	show_pos = position
	hide_pos = Vector2(show_pos.x-700,show_pos.y)
	position = hide_pos

func _on_btn_select_layla_pressed():
	slide_in = false
	slide_out = true
