extends CanvasLayer
#const DISC = preload("res://Objects/Disc/disc.tscn")

#var disc_putter  : RigidBody3D # Putter
#var disc_hybrid : RigidBody3D # Fairway
#var disc_driver  : RigidBody3D # Driver
#var selected_disc : RigidBody3D

var selected_index = -1

func _process(_delta):
	pass

func _on_btn_next_hole_pressed():
	var disc_01 = ["Cold Stone", "Putter", 2, 2, -1, 0]
	var disc_02 = ["Midrock", "Hybrid", 5, 4, 0, 3]
	var disc_03 = ["Innova Boss", "Driver", 13, 5, -1, 3]
	
	Global.add_disc(disc_01)
	Global.add_disc(disc_02)
	Global.add_disc(disc_03)
	Global.game_disc_index = selected_index
	Global.go_to_scene(Global.SCENE_GAME)


func _select_putter_pressed():
	selected_index = 0

func _select_hybrid_pressed():
	selected_index = 1
	
func _select_driver_pressed():
	selected_index = 2
