extends AnimatedSprite3D

@onready var Master: Entity = get_parent()
var current_anim: String = "Idle_D"

func _ready():
	play(current_anim)

func _process(_delta):
	#if !Master.is_throwing: _update_anim()
	_update_anim()
	if animation != current_anim:
		play(current_anim)

func _update_anim():
	var anim_base = Master.StateController.state_next
	current_anim = anim_base + Master.StateController.state_suffix + "_"
	
	#if Master.is_moving:
	var h_axis = Input.get_axis("move_left", "move_right")
	var v_axis = Input.get_axis("move_down", "move_up")
	var dir = ""
	if v_axis:
		dir += "U" if v_axis == 1 else "U"
	elif h_axis:
		dir += "R" if h_axis == 1 else "L"
	
	if dir == "": dir = "U"
	current_anim += dir
