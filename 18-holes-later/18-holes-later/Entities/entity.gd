class_name Entity
extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var MAX_HP: int = 100
@export var HP: float

@onready var Anim_Controller: AnimController3D = $Anim_Controller
@onready var Input_Controller: InputController = $Input_Controller
@onready var State_Controller: StateController = $State_Controller

@export var SPEED: float = 10000.0
var SPEED_MULT: float = 1
@export var JUMP_FORCE: float = 5
@export var SIGHT_RANGE: int = 999
var Target: Node3D

var is_dead: bool
var accepts_input: bool

var input := Vector2.ZERO
var input_move := Vector2.ZERO
var input_look := Vector2.ZERO
var input_dir := Vector3.ZERO
var new_dir := Vector3.ZERO
var look_dir := 0.0
var can_look: bool
var can_move: bool
var is_moving: bool
var can_crouch: bool = true
var is_crouching: bool = false
var can_slide: bool = true
var is_sliding: bool = false

var look_forward: bool
var look_around: bool

var can_interact = true
var locked_in: bool
var can_combat: bool
var in_combat: bool
var can_attack: bool
var is_attacking: bool
var can_throw: bool
var is_throwing: bool
var can_run: bool = false
var is_running: bool = false
var can_jump: bool
var is_jumping: bool
var is_falling: bool
var is_landing: bool

var dir_to_target = Vector3.ZERO
var dist_to_target = 0.0

func _ready():
	HP = MAX_HP
	set_active(true)

func _update_velocity(delta):
	var spd = SPEED * SPEED_MULT * delta
	
	if !is_on_floor(): velocity.y -= gravity * delta
	
	if input_dir:
		velocity.x = input_dir.x * spd
		velocity.z = input_dir.z * spd
	else:
		velocity.x = move_toward(velocity.x, 0, spd)
		velocity.z = move_toward(velocity.z, 0, spd)
	move_and_slide()

func take_damage(dmg_incoming: float = 0, knockback: Vector3 = Vector3.ZERO):
	velocity += knockback
	HP -= dmg_incoming
	if HP <= 0:
		HP = 0
		is_dead = true
		if self.is_in_group("Zombie"):
			self.timer.start()
		else:
			queue_free()
		
func set_active(TorF: bool):
	if TorF:
		look_forward = true
		look_around = true
		can_look = true
		can_throw = true
		can_combat = true
		can_attack = true
		can_look = true
		can_move = true
		can_jump = true
		can_interact = true
		accepts_input = true
	else:
		look_forward = false
		look_around = false
		can_look = false
		can_throw = false
		can_combat = false
		can_attack = false
		can_throw = false
		can_look = false
		can_move = false
		can_jump = false
		can_interact = false
		accepts_input = false

func anim_play(anim):
	Anim_Controller.anim_state.travel(anim)
