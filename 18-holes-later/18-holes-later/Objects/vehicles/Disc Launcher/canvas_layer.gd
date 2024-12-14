extends CanvasLayer
@onready var Master = get_parent()
@onready var label_ammo_type = $VBoxContainer/Label_AmmoType
@onready var label_ammo_stats = $VBoxContainer/Label_AmmoStats
@onready var label_power = $VBoxContainer/Label_Power

func _process(_delta):
	label_ammo_type.text = "Ammo Type: " + Master.ammo_type
