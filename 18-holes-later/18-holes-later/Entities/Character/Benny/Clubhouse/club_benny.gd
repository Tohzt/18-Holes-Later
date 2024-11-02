extends Node3D
@onready var character_reference = Global.Refs.BENNY
@onready var animation_player = $AnimationPlayer
@onready var Cam_Mount = $Cam_Mount
var look_forward = true
var look_around = false


func _ready():
	animation_player.play("Idle")

func set_active(_TorF: bool = false):
	pass
