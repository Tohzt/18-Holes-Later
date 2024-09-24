class_name AnimController3D
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Bones: Skeleton3D = $Armature/Skeleton3D
@onready var Master: Entity_Character = get_parent()

var current_anim: String = "Idle"
var look_dir: float = 0.0
var prev_look_dir: float = 0.0

func _ready():
	Master.Anim_Controller = self
	$AnimationPlayer.play(current_anim)

func _process(_delta):
	_update_anim()

# TODO: Update to 3D
func _update_anim():
	look_dir = Master.input.angle() + PI/2
	if Master.input:
		prev_look_dir = look_dir
		rotation.y = -look_dir
		if Master.is_running:
			$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Walk")
	else:
		rotation.y = -prev_look_dir
		$AnimationPlayer.play("Idle")
		
	if animation_player.current_animation != Master.State_Controller.state_next:
		pass#_update_anim()
	
	#var anim_base = Master.State_Controller.state_next
	#current_anim = anim_base + Master.State_Controller.state_suffix + "_"
	##if Master.is_moving:
	#var h_axis = Input.get_axis("move_left", "move_right")
	#var v_axis = Input.get_axis("move_down", "move_up")
	#var dir = ""
	#if v_axis:
		#dir += "U" if v_axis == 1 else "D"
	#if h_axis:
		#dir += "R" if h_axis == 1 else "L"
	#
	#if dir == "" or current_anim.contains("Throw"): dir = "U"
	#current_anim += dir
	#$AnimationPlayer.play(current_anim)
	
