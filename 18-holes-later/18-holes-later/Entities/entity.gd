class_name Entity
extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_health: int = 100
@export var health: float

@export var SPEED: float = 10.0
@export var SPEED_MULT: float = 1
@export var JUMP_FORCE: float = 5

@onready var Area_Interact: Area3D = $Area_Interact
@onready var Anim_Controller: AnimController3D = $Anim_Controller
@onready var Input_Controller: InputController = $Input_Controller
@onready var State_Controller: StateController = $State_Controller
@onready var Collision_Mask: CollisionShape3D = $Character_Base

@onready var Cam_Mount = $Cam_Mount
@onready var start_pos = position
var is_dead: bool
var state: String = "Idle"
var accepts_input: bool

var new_dir := Vector3.ZERO
var look_dir := 0.0
var input_move := Vector2.ZERO
var input_look := Vector2.ZERO
var input_dir := Vector3.ZERO
var can_look: bool
var can_move: bool
var is_moving: bool
var can_crouch: bool = true
var is_crouching: bool = false
var can_slide: bool = true
var is_sliding: bool = false

var locked_in: bool
var look_forward: bool
var look_around: bool

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

func _ready():
	health = max_health
	set_active(true)

func _process(_delta):
	if Input_Controller:
		input_move = Input_Controller.input_move
		input_look = Input_Controller.input_look
	# TODO: Not sure if I should be doing this next part
	else:
		return

func take_damage(dmg_incoming: float = 0, knockback: Vector3 = Vector3.ZERO):
	velocity += knockback
	health -= dmg_incoming
	if health <= 0:
		health = 0
		is_dead = true
		queue_free()
		
func set_active(TorF: bool):
	if TorF:
		look_forward = true
		look_around = true
		can_look = true
		can_throw = true
		can_combat = true
		can_attack = true
		can_throw = true
		can_look = true
		can_move = true
		can_jump = true
		accepts_input = true
		Input_Controller.character_action = true
		Input_Controller.character_look = true
		Input_Controller.character_move = true
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
		accepts_input = false
		Input_Controller.character_action = false
		Input_Controller.character_look = false
		Input_Controller.character_move = false

func get_overlapping_areas():
	return Area_Interact.get_overlapping_areas()
