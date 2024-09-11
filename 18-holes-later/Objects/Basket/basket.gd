extends StaticBody3D

@export var hole: int = 0

func _on_area_3d_area_entered(area):
	Global.audio.play()
	var disc = area.get_parent()
	if disc.is_in_group("Disc"):
		if disc.in_play:
			Global.game_on = false
			Global.hole_over = true
			disc.in_play = false
			Global.game_on = false
			Global.HUD.update_strokes(0)
			_trigger_swarm()

func _trigger_swarm():
	get_tree().get_first_node_in_group("EnemyContainer").spawn_enemies(position)
