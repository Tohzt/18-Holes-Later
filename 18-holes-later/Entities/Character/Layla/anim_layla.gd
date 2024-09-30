class_name AnimController3D
extends Node3D

#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
var anim_state
@onready var Bones: Skeleton3D = $Armature/Skeleton3D
@onready var Master: Entity_Character = get_parent()

var current_anim: String = "Idle"
var look_dir: float = 0.0
var prev_look_dir: float = 0.0

func _ready():
	anim_state = animation_tree["parameters/playback"]
	anim_state.travel("Idle")
	Master.Anim_Controller = self

func _process(_delta):
	_update_anim()

func _update_anim():
	look_dir = Master.input.angle() - PI/2
	if Master.input:
		prev_look_dir = look_dir
		rotation.y = -look_dir
	else:
		rotation.y = -prev_look_dir
