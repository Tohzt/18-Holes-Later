extends Area3D

func _on_body_entered(body):
	if body.name == "Player":
		$"../../Player".position = $"../Marker3D".position
		$"../../Camera3D".position.y = 5.5
