# TODO: SOMETHING WITH THIS
extends Node

func build_hole(hole_name):
	var hole
	match hole_name:
		"Testing_Room":
			hole = Global.Refs.TESTING_ROOM.instantiate()
		"Hole_01": 
			hole = Global.Refs.HOLE_01.instantiate()
	
	if hole: return hole
	
	print_debug("Hole was not set correctly!")
