extends Control
class_name HUD_Class
@onready var Strokes = $Strokes
@onready var bag_container = $Bag_Container
@onready var charge_bar: ProgressBar = $Charge_Bar

func _ready():
	Strokes.text = "Strokes: --"

func update_strokes(count):
	Strokes.text = "Strokes: " + str(count)
