extends Control
class_name hud_disc
@onready var label: Label       = $Disc_Label
@onready var disc:  TextureRect = $Disc_Sprite
@onready var gradient: Gradient = disc.texture.gradient

@export_range (1,3) var slot: int = 1

func _process(_delta):
	label.text = Global.Player.Bag.discs[slot-1].disc_details.disc_type[0]
	if slot == Global.selected_disc:
		gradient.set_color(0, Color.RED)
	else:
		gradient.set_color(0, Color.BLUE)
