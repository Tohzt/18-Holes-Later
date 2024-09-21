class_name AnimController3D
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Master: Entity_Character = get_parent()
var current_anim: String = "Idle"
var look_dir: float = 0.0

func _ready():
	Master.Anim_Controller = self
	$AnimationPlayer.play(current_anim)

func _process(delta):
	#look_dir = Master.input.angle() + PI/2
	#match Master.input:
		#Vector2()
	if Master.is_moving:
		#rotation.y = Master.rotation.y - look_dir
		$AnimationPlayer.play("Walk")
	elif Master.is_running:
		#rotation.y = Master.rotation.y - look_dir
		$AnimationPlayer.play("Run")
	else:
		#rotation.y = 0
		$AnimationPlayer.play("Idle")
		
	if animation_player.current_animation != Master.State_Controller.state_next:
		pass#_update_anim()

# TODO: Update to 3D
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
	
	if dir == "" or current_anim.contains("Throw"): dir = "U"
	current_anim += dir
	$AnimationPlayer.play(current_anim)
	
