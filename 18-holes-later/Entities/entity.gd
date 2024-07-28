class_name Entity
extends CharacterBody3D

const SAVE = preload("res://Save/save.tscn")
@export var save_entity: bool = false

@export var SPEED: float = 5.0
@export var JUMP_FORCE: float = 4.5

@onready var State_Controller : StateController = $StateController
@onready var AnimController : AnimatedSprite3D = $AnimatedSprite3D
@onready var CollisionMask : CollisionShape3D = $CollisionShape3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_moving = false

var state: String = "Idle"

func _ready():
	if save_entity:
		var save = SAVE.instantiate()
		save.is_player = true
		add_child(save)

func _process(_delta):
	pass#AnimController.update_anim("Idle")

