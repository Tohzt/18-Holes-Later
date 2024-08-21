extends StaticBody3D

@export var hole: int = 0


func _on_area_3d_body_entered(body):
	if body.is_in_group("Disc"):
		var disc: Disc = body
		disc.in_play = false;
		_trigger_swarm()

func _trigger_swarm():
	get_tree().get_first_node_in_group("EnemyContainer").spawn_enemies(position)
