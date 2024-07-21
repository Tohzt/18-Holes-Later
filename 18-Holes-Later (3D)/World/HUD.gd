extends CanvasLayer

@onready var label_power = $CenterContainer/HBoxContainer/Label_Power
@onready var label_tilt  = $CenterContainer/HBoxContainer/Label_Tilt
@onready var label_spin  = $CenterContainer/HBoxContainer/Label_Spin

var Player : MovementMechanics

func _ready():
	Player = Global.Player

func _process(_delta):
	label_power.text = "Power: " + str(Global.mouse_hold_time).pad_decimals(2)
	label_tilt.text  = "Tilt: "  + str(Global.tilt).pad_decimals(2)
	label_spin.text  = "Spin: "  + str(Global.spin).pad_decimals(2)
