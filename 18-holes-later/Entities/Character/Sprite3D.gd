class_name AnimController
extends Sprite3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Master: Entity_Character = get_parent()
var current_anim: String = "Idle_D"

func _ready():
	$AnimationPlayer.play(current_anim)

func _process(_delta):
	#if !Master.is_throwing: _update_anim()
	#print("Cur Anim/State: ", animation_player.current_animation, Master.State_Controller.state_next)
	if animation_player.current_animation != Master.State_Controller.state_next:
		_update_anim()

func _update_anim():
	
	var anim_base = Master.State_Controller.state_next
	current_anim = anim_base + Master.State_Controller.state_suffix + "_"
	#if Master.is_moving:
	var h_axis = Input.get_axis("move_left", "move_right")
	var v_axis = Input.get_axis("move_down", "move_up")
	var dir = ""
	if v_axis:
		dir += "U" if v_axis == 1 else "D"
	if h_axis:
		dir += "R" if h_axis == 1 else "L"
	
	if dir == "": dir = "U"
	current_anim += dir
	$AnimationPlayer.play(current_anim)
	
