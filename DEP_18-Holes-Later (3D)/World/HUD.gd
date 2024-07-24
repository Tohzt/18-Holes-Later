extends CanvasLayer
@onready var GC = $"../GameController"

@onready var label_power = $MarginContainer/HBoxContainer/Label_Power
@onready var label_tilt = $MarginContainer/HBoxContainer/Label_Tilt
@onready var label_spin = $MarginContainer/HBoxContainer/Label_Spin
@onready var label_discs = $MarginContainer/HBC_Top/Label_Discs
@onready var label_throws = $MarginContainer/HBC_Top/Label_Throws

var Player : MovementMechanics

func _ready():
	Player = Global.Player

func _process(_delta):
	if Player:
		label_discs.text  = "Discs: "  + str(Player.discs_in_bag).pad_decimals(0)
		label_throws.text = "Throws: " + str(Player.hole_score).pad_decimals(0)
		label_power.text  = "Power: "  + str(GC.mouse_hold_time).pad_decimals(2)
		label_tilt.text   = "Tilt: "   + str(GC.tilt).pad_decimals(2)
		label_spin.text   = "Spin: "   + str(GC.spin).pad_decimals(2)
	else:
		Player = Global.Player
