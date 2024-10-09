extends Area3D

@export var tee_number = 0
@onready var collision_shape_3d = $CollisionShape3D

func _on_tee_entered(_body):
	Global.Player.is_on_tee = true
func _on_tee_exited(_body):
	Global.Player.is_on_tee = false
