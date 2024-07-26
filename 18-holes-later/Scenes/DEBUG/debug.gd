extends CanvasLayer

@onready var speed_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Speed/Speed_Data
@onready var glide_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Glide/Glide_Data
@onready var turn_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Turn/Turn_Data
@onready var fade_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Fade/Fade_Data

func _ready():
	update_stats()
#func _process(delta):
	#update_stats()

func update_stats():
	update_speed()
	update_glide()
	update_turn()
	update_fade()
	print(Global.debug_stats)

func update_speed(): speed_data.text = str(Global.debug_stats[0])
func update_glide(): glide_data.text = str(Global.debug_stats[1])
func update_turn():  turn_data.text  = str(Global.debug_stats[2])
func update_fade():  fade_data.text  = str(Global.debug_stats[3])


func _on_add_speed_pressed():
	Global.debug_stats[0] += 1
	update_stats()

func _on_add_glide_pressed():
	Global.debug_stats[1] += 1
	update_stats()

func _on_add_turn_pressed():
	Global.debug_stats[2] -= 1
	update_stats()

func _on_add_data_pressed():
	Global.debug_stats[3] += 1
	update_stats()

func _on_reset_pressed():
	Global.debug_stats = [0,0,0,0]
	update_stats()
