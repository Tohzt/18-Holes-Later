extends Node3D

@onready var character_reference = Global.Refs.LAYLA
@onready var animation_player = $AnimationPlayer
@onready var Cam_Mount = $Cam_Mount
var look_forward = true
var look_around = false
var in_focus = false
func _ready():
	animation_player.play("CrouchAnims/CrouchIdle")

func _process(_delta):
	if in_focus:
		Global.Cameraman.Tripod.spring_length = 0
	else:
		Global.Cameraman.Tripod.spring_length = 2
		
func set_active(TorF: bool = false):
	in_focus = TorF
