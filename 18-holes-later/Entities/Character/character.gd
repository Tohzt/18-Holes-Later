class_name Entity_Character
extends Entity

@onready var Tripod: SpringArm3D = $Tripod_Main
@onready var Hand = $Hand
@onready var Bag = $Bag

var game_disc_index: int = 0

const MAX_POWER = 10
var is_charging = false
var is_throwing = false
var is_on_tee = false
var locked_in = false
var strokes = 0

func _ready():
	Global.Player = self
	super._ready()

func _process(_delta):
	if is_charging:
		Global.HUD.charge_bar.value += 2
	
	if Global.Debug_Settings.collect_all:
		_collect_discs()

func _physics_process(delta):
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
	
	if !locked_in:
		move_and_slide()

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			disc.pick_up(Bag)
