extends StaticBody3D

@export var hole: int = 0

func _on_area_3d_area_entered(area):
	print("Disc in Basket: ", area)
	if area.is_in_group("Disc"):
		if area.in_play:
			area.in_play = false;
			Global.game_on = false
			_trigger_swarm()

func _trigger_swarm():
	get_tree().get_first_node_in_group("EnemyContainer").spawn_enemies(position)
