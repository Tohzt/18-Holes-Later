extends CanvasLayer
@onready var Strokes = $Strokes

func _ready():
	Strokes.text = "Strokes: --"

func update_strokes(count):
	Strokes.text = "Strokes: " + str(count)
