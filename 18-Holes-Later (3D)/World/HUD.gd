extends CanvasLayer

@onready var label_power = $CenterContainer/MarginContainer/HBoxContainer/Label_Power
@onready var label_tilt = $CenterContainer/MarginContainer/HBoxContainer/Label_Tilt
@onready var label_spin = $CenterContainer/MarginContainer/HBoxContainer/Label_Spin

var Player : MovementMechanics

func _ready():
	Player = Global.Player
	print(Player)

func _process(delta):
	label_power.text = "Power: " + str(Global.mouse_hold_time).pad_decimals(2)
	label_tilt.text  = "Tilt: "  + str(Global.tilt).pad_decimals(2)
	label_spin.text  = "Spin: "  + str(Global.spin).pad_decimals(0)
