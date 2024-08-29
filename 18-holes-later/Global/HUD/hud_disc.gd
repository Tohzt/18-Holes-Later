extends Control
class_name hud_disc

@export_range (1,3) var slot: int = 1
@onready var label: Label       = $Disc_Label
@onready var disc:  TextureRect = $Disc_Sprite
@onready var gradient: Gradient = disc.texture.gradient

var has_disc = false

func _process(_delta):
	label.text = Global.Player.Bag.discs[slot-1].disc_type[0]
	if slot == Global.selected_disc:
		gradient.set_color(0, Color.RED)
	else:
		gradient.set_color(0, Color.BLUE)
	
	_check_for_disc()

func _check_for_disc():
	has_disc = false
	for _disc: Disc in Global.Player.Bag.get_children():
		if _disc.index == slot:
			has_disc = true
	if !has_disc:
		gradient.set_color(0, Color.BLACK)
