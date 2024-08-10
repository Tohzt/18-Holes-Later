class_name Entity
extends RigidBody3D

@export var max_health: int = 100
@export var health: float

@export var SPEED: float = 5000.0
@export var SPEED_MULT: float = 2
@export var JUMP_FORCE: float = 4500
var speed_mult: float = 0.0

@export var Input_Controller : InputController
@export var Anim_Controller  : AnimController  
@onready var State_Controller : StateController  = $StateController
@onready var Collision_Mask   : CollisionShape3D = $CollisionShape3D

var look_dir: float = 0.0
var velocity := Vector3.ZERO
var is_dead    = false
var is_moving  = false
var is_running = false

var state: String = "Idle"

func _ready():
	health = max_health
	
func _process(_delta):
	speed_mult = 1
	if Input.is_action_pressed("run"):
		speed_mult = SPEED_MULT

func _physics_process(delta):
	var force = velocity * SPEED * speed_mult * delta
	constant_force = force
	rotation.y = look_dir

func take_damage(dmg_incoming: float = 0, _knockback: Vector3 = Vector3.ZERO):
	#velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
