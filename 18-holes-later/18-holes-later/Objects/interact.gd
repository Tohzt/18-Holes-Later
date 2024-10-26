class_name Interact_Class
extends Area3D

var active = false
var can_interact = true
@export var interact_cd_max = 1.0
var interact_cd = interact_cd_max

func interact():
	print_debug("interact() not set in interact.gd...")

func set_active(TorF: bool):
	active = TorF
