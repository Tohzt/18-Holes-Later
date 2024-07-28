extends Node

const HOLE_01 = preload("res://Scenes/Holes/Hole_01/hole_01.tscn")

func build_hole(hole_name):
	var hole
	match hole_name:
		"Hole_01": 
			hole = HOLE_01.instantiate()
	
	if hole: return hole
	
	print_debug("Hole was not set correctly!")
