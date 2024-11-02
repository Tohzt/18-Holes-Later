extends CanvasLayer
@onready var black: TextureRect = $TextureRect

var fade_in = false
var fade_out = true

func _process(delta):
	if fade_in:
		black.modulate.a = lerp(black.modulate.a, 1.0, delta*5)
	if fade_out:
		black.modulate.a = lerp(black.modulate.a, 0.0, delta*5)

func toggle_fade(fade = null): #T = in F = out
	if !fade:
		fade_out = fade_in
		fade_in = !fade_in
	else:
		fade_in = fade
		fade_out = !fade
	
	if fade_in:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if fade_out:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
