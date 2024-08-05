class_name Entity
extends CharacterBody3D

@export var max_health: int = 100
@export var health: float

@export var SPEED: float = 5.0
@export var RUN_MULTI: float = 5
@export var JUMP_FORCE: float = 4.5

@onready var State_Controller : StateController  = $StateController
@onready var Input_Controller : InputController  = $InputController
@onready var Anim_Controller  : AnimController   = $AnimController
@onready var Collision_Mask   : CollisionShape3D = $CollisionShape3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_dead    = false
var is_moving  = false
var is_running = false

var state: String = "Idle"

func _ready():
	health = max_health

func _process(_delta):
	pass

func take_damage(dmg_incoming: float = 0, knockback: Vector3 = Vector3.ZERO):
	velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
