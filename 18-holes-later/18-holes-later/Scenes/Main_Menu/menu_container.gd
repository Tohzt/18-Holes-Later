extends NinePatchRect
@onready var show_pos: Vector2 = position
@onready var hide_pos := Vector2(show_pos.x,show_pos.y-150)

var slide_in = false
var slide_out = false
var timer: Timer

func _ready():
	position = hide_pos
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start(0.5)

func _on_timer_timeout():
	slide_in = true
	slide_out = false

func _process(delta):
	if slide_in:
		position = lerp(position, show_pos, delta*10)
	if slide_out:
		position = lerp(position, hide_pos, delta*10)
