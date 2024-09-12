class_name Entity
extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_health: int = 100
@export var health: float

@export var SPEED: float = 10.0
@export var SPEED_MULT: float = 2
@export var JUMP_FORCE: float = 10
var speed_mult: float = 0.0

@export var Input_Controller  : InputController
@export var Anim_Controller   : AnimController3D
@onready var State_Controller : StateController  = $StateController
@onready var Collision_Mask   : CollisionShape3D = $CollisionShape3D

var look_dir: float = 0.0
var input_dir := Vector3.ZERO
var is_dead    = false
var is_moving  = false
var is_running = false

var state: String = "Idle"

func _ready():
	health = max_health

func take_damage(dmg_incoming: float = 0, _knockback: Vector3 = Vector3.ZERO):
	#velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
