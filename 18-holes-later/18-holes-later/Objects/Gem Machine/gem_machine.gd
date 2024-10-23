extends Area3D

#var isInside = false
@onready var ds = get_tree().get_first_node_in_group("DiscSelector")

#func _process(_delta):
	#if isInside and Input.is_action_just_pressed("interact"):
		#ds.toggle_slide()

#func _on_area_body_3d_body_entered(_body):
	#isInside = true
#
#func _on_area_body_3d_body_exited(_body):
	#isInside=false

func interact():
	print("Interacting with Gem Machine")
