extends Node3D

@onready var h_start : float = position.y
@onready var h_bounce : float = h_start - .5
var bounce: bool = true

func _process(delta):
	if bounce:
		position.y = lerp(position.y, h_bounce, delta*5)
		if abs(position.y - h_bounce) < 0.1:
			bounce = false
	else:
		position.y = lerp(position.y, h_start, delta*5)
		if abs(position.y - h_start) < 0.1:
			bounce = true
