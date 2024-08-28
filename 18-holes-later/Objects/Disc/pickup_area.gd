extends Area3D
@onready var disc: Disc = get_parent()
var can_pickup = false

func _on_body_entered(body):
	if body.is_in_group("Character"):
		can_pickup = true

func _on_body_exited(body):
	if body.is_in_group("Character"):
		can_pickup = false

func _process(_delta):
	if can_pickup:
		if disc.in_play:
			if Input.is_action_just_pressed("collect"):
				Global.Player.locked_in = true
				disc.pick_up(Global.Player.Bag)
		else:
			disc.pick_up(Global.Player.Bag)
			
