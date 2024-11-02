extends Area3D

@export var destination: String

func interact():
	var holes = get_tree().root.get_node("Course").get_node("Holes")
	var clubhouse = holes.get_child(0)
	Global.Player.Input_Controller.character_look = true
	Global.Player.position = Vector3(0,-1000,0)
	Global.Cameraman.position = Vector3(0,-1000,0)
	clubhouse.queue_free()
	var next_hole
	if destination:
		var dest = load(destination)
		next_hole = dest.instantiate()
	else:
		# TODO: TEMP - might use this to default to clubhouse
		next_hole = Global.Refs.HOLE_01.instantiate()
	
	holes.add_child(next_hole)
	Global.Player.position = next_hole.get_node("Player_Spawn").position
