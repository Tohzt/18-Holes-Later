class_name Entity
extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_health: int = 100
@export var health: float

@export var SPEED: float = 10.0
@export var SPEED_MULT: float = 2
@export var JUMP_FORCE: float = 5
var speed_mult: float = 0.0

@export var Anim_Controller   : AnimController3D
@onready var Input_Controller  : InputController = $InputController
@onready var State_Controller : StateController  = $StateController
@onready var Collision_Mask   : CollisionShape3D = $Character_Base

var state: String = "Idle"
var new_dir      := Vector3.ZERO
var look_dir     := 0.0
var input        := Vector2.ZERO
var input_dir    := Vector3.ZERO
var is_dead       = false
var can_combat    = true
var in_combat     = false
var can_attack    = true
var is_attacking  = false
var can_move      = true
var is_moving     = false
var is_running    = false
var is_jumping    = false
var is_falling    = false
var is_landing    = false
var accepts_input = true

func _ready():
	health = max_health

func take_damage(dmg_incoming: float = 0, _knockback: Vector3 = Vector3.ZERO):
	#velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
