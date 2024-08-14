extends Area3D

@export var tee_number = 0
@onready var collision_shape_3d = $CollisionShape3D

func _on_tee_entered(body):
	Global.Player.is_on_tee = true
	print(body.name +" has entered")
func _on_tee_exited(body):
	Global.Player.is_on_tee = false
	print(body.name +" has exited")
