extends NinePatchRect
@onready var disc_01 = $VBoxContainer/MarginContainer/HBoxContainer/Disc_01
@onready var disc_02 = $VBoxContainer/MarginContainer/HBoxContainer/Disc_02
@onready var disc_03 = $VBoxContainer/MarginContainer/HBoxContainer/Disc_03


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlight_selected():
	match Global.selected_disc:
		1:
			print("Select Disc 1")
			disc_01.selected_disc(true)
			disc_02.selected_disc(false)
			disc_03.selected_disc(false)
		2:
			print("Select Disc 2")
			disc_01.selected_disc(false)
			disc_02.selected_disc(true)
			disc_03.selected_disc(false)
		3:
			print("Select Disc 3")
			disc_01.selected_disc(false)
			disc_02.selected_disc(false)
			disc_03.selected_disc(true)
		_:
			print_debug("No Disc Selected")
