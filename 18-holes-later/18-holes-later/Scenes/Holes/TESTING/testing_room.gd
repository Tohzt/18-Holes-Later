extends Node3D
@onready var teleport_testing = $Testing/Teleport_Testing
@onready var teleport_range = $Driving_Range/Teleport_Range
var offset = Vector3(0,0,5)

func _on_teleport_testing_body_entered(body):
	Global.Settings.follow_all_throws = true
	body.global_position = teleport_range.global_position + offset


func _on_teleport_range_body_entered(body):
	Global.Settings.follow_all_throws = false
	body.global_position = teleport_testing.global_position + (offset*-1)
