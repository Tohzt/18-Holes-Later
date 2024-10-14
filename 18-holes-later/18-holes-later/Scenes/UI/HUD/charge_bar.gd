extends ProgressBar
@onready var show_pos: Vector2 = position
@onready var hide_pos := Vector2(show_pos.x,show_pos.y+100)

var slide_in = false
var slide_out = false

func _ready():
	position = hide_pos

func _process(delta):
	if Global.Player.is_throwing: 
		slide_in = true
		slide_out = false
	else:
		slide_in = false
		slide_out = true
	value = clamp(Global.Player.charge_power, 0, 100)

	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)
