class_name Disc_Base_Class
extends RigidBody3D

# Common properties
var in_hand: bool
var in_bag: bool
var in_play: bool
var power: float
var target_dir: Vector3

# Common methods that both disc types will need
func launch_disc():
	pass

func set_horizontal_influence(_influence: float):
	pass 
