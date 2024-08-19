extends TextureRect
class_name hud_disc

@export var selected: bool = false
@onready var gradient: Gradient = self.texture.gradient

func _ready():
	pass

func _process(_delta):
	print(selected)
	if selected:
		gradient.set_color(0, Color.RED)
	else:
		gradient.set_color(0, Color.BLUE)

func selected_disc(yes_no):
	selected = yes_no
