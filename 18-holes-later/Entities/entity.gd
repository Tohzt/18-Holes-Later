class_name Entity
extends CharacterBody3D

@export var SPEED: float = 5.0
@export var JUMP_FORCE: float = 4.5

@onready var State_Controller : StateController = $StateController
@onready var AnimController : AnimatedSprite3D = $AnimatedSprite3D
@onready var CollisionMask : CollisionShape3D = $CollisionShape3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_moving = false

var state: String = "Idle"

func _ready():
	pass

func _process(_delta):
	pass

