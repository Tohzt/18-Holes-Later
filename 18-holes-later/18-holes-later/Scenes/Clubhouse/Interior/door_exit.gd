extends Area3D

@export var destination: String = "res://Scenes/Holes/Hole1HTerrain/HTERRAINhole1.tscn"

func _process(_delta):
	var overlap = get_overlapping_bodies()
	if overlap: _detect(overlap)

func _detect(overlap):
	for body in overlap:
		if body.is_in_group("Character"):
			if body.did_interact:
				body.cd_interact = 0
				interact()
				
func interact():
	var holes = get_tree().root.get_node("Course").get_node("Holes")
	var clubhouse = holes.get_child(0)
	Global.Player.position = Vector3(0,-1000,0)
	Global.Cameraman.position = Vector3(0,-1000,0)
	clubhouse.queue_free()
	var dest = load(destination)
	var next_hole = dest.instantiate()
	holes.add_child(next_hole)
	Global.Player.position = next_hole.get_node("Player_Spawn").position
