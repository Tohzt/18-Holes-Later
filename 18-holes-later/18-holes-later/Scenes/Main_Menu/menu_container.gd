extends UI_Class

var timer: Timer
func _ready():
	show_pos = position
	hide_pos = Vector2(show_pos.x,show_pos.y-Global.Settings.view_height / 2)
	position = hide_pos
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start(0.5)

func _on_timer_timeout():
	toggle_slide()

func _process(delta):
	super._process(delta)
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)
