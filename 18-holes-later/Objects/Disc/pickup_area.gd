extends Area3D

var can_pickup = false

func _on_body_entered(body):
	if body.is_in_group("Character"):
		can_pickup = true

func _on_body_exited(body):
	if body.is_in_group("Character"):
		can_pickup = false

func _process(_delta):
	if can_pickup:
		if Input.is_action_just_pressed("collect"):
			if get_parent().is_in_group("Disc"):
				get_parent().pick_up()
				queue_free()
