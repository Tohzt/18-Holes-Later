extends AnimatedSprite3D

@onready var Master: Entity = get_parent()
var current_anim: String = "Idle_D"

func _ready():
	play(current_anim)

func _process(_delta):
	_update_anim()
	if animation != current_anim:
		play(current_anim)

func _update_anim():
	current_anim = Master.State_Controller.state_next + "_"
	
	#if Master.is_moving:
	var h_axis = Input.get_axis("move_left", "move_right")
	var v_axis = Input.get_axis("move_down", "move_up")
	var dir = ""
	if v_axis:
		dir += "U" if v_axis == 1 else "D"
	elif h_axis:
		dir += "R" if h_axis == 1 else "L"
	
	if dir == "": dir = "D"
	current_anim += dir
