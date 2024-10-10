extends CollisionShape3D
var isInside = false
@onready var ds = get_tree().get_first_node_in_group("DiscSelector")

func _process(_delta):
	if isInside and Input.is_action_just_pressed("interact"):
		if ds.slide_out:
			ds.slide_in = true
			ds.slide_out = false
		else:
			ds.slide_in = false
			ds.slide_out = true
	pass
	


func _on_area_body_3d_body_entered(_body):
	isInside = true

func _on_area_body_3d_body_exited(_body):
	isInside=false
