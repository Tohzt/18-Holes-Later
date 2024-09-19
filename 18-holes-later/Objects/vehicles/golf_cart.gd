class_name VehicleClass
extends CharacterBody3D

@onready var pickup_area: Area3D = $Area3D
@onready var seats: Array = [$Seat_Driver]
var has_driver = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_durability: int = 100
@export var durability: float

@export var SPEED: float = 10.0
@export var SPEED_MULT: float = 2
@export var JUMP_FORCE: float = 10
var speed_mult: float = 0.0

@export var Input_Controller: InputController
var accepts_input = false

var look_dir: float = 0.0
var input_dir := Vector3.ZERO

func _process(_delta):
	_enter_exit_vehicle()

func _physics_process(delta):
	speed_mult = 1
	if Input.is_action_pressed("run"):
		speed_mult = SPEED_MULT
	
	if input_dir:
		velocity.x = input_dir.x * SPEED * speed_mult
		velocity.z = input_dir.z * SPEED * speed_mult
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_mult)
		velocity.z = move_toward(velocity.z, 0, SPEED * speed_mult)
		
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if has_driver:
		move_and_slide()

func _enter_exit_vehicle():
	var collisions = pickup_area.get_overlapping_bodies()
	for collision in collisions:
		if collision.is_in_group("Character"):
			if Input.is_action_just_pressed("interact"):
				if collision.in_vehicle:
					collision.in_vehicle = null
					collision.accepts_input = true
					Global.Cameraman.set_target(collision, collision.get_node("CamFocus"))
					Global.Player.set_collision_mask_value(6,true)
					has_driver = false
					accepts_input = false
				else:
					Global.Cameraman.set_target(self, $CamFocus)
					collision.in_vehicle = self
					collision.accepts_input = false
					Global.Player.set_collision_mask_value(6,false)
					has_driver = true
					accepts_input = true
