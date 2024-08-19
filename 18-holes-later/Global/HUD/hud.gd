extends Control
class_name HUD
@onready var Strokes = $Strokes
@onready var bag_container = $Bag_Container

func _ready():
	Strokes.text = "Strokes: --"

func update_strokes(count):
	Strokes.text = "Strokes: " + str(count)
