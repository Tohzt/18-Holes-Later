extends Control
class_name HUD_Class
@onready var Strokes_Label = $Stroke_Container/VBoxContainer/MarginContainer/Strokes
@onready var bag_container = $Bag_Container
@onready var charge_bar: ProgressBar = $Charge_Bar
@onready var strokes = 0

func _ready():
	update_strokes(0)

func update_strokes(count):
	strokes += count
	Strokes_Label.text = str(strokes)
