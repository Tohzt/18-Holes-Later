extends CanvasLayer

@onready var name_data = $Name_Label
@onready var speed_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Speed/Speed_Data
@onready var glide_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Glide/Glide_Data
@onready var turn_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Turn/Turn_Data
@onready var fade_data = $CenterContainer/MarginContainer/MarginContainer/VBoxContainer/HBC_Fade/Fade_Data

#func _ready():
	#update_stats()
#func _process(_delta):
	#update_stats()
#
#func update_stats():
	#update_name()
	#update_speed()
	#update_glide()
	#update_turn()
	#update_fade()
#
#func update_name():  name_data.text  = str(Global.Bag[Global.Scene.game_disc_index][0] + " : " + Global.Bag[Global.Scene.game_disc_index][1])
#func update_speed(): speed_data.text = str(Global.Bag[Global.Scene.game_disc_index][2])
#func update_glide(): glide_data.text = str(Global.Bag[Global.Scene.game_disc_index][3])
#func update_turn():  turn_data.text  = str(Global.Bag[Global.Scene.game_disc_index][4])
#func update_fade():  fade_data.text  = str(Global.Bag[Global.Scene.game_disc_index][5])

