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
@export var Anim_Controller   : AnimController  
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
	
func _process(delta):
	speed_mult = 1
	if Input.is_action_pressed("run"):
		speed_mult = SPEED_MULT
	
	rotation.y = look_dir
	
	if input_dir:
		velocity.x = input_dir.x * SPEED * speed_mult
		velocity.z = input_dir.z * SPEED * speed_mult
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_mult)
		velocity.z = move_toward(velocity.z, 0, SPEED * speed_mult)
		
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	move_and_slide()

func take_damage(dmg_incoming: float = 0, _knockback: Vector3 = Vector3.ZERO):
	#velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
