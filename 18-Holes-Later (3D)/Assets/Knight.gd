extends Node3D
@onready var knight:UCharacterBody3D = $".."
@onready var anim: AnimationPlayer = get_node("AnimationPlayer")
var state = "Idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Walking_A")

func _get_state():
	state = "Idle"
	if knight.is_walking: state = "Walk"
	if knight.is_sprinting: state = "Run"
	if knight.is_crouching: state = "Crouch"
	if knight.is_sliding: state = "Slide"
	
	if Input.is_action_pressed("action_attack"):
		state="attack"

func _process(_delta):
	_get_state()
	
	match state:
		"Idle": anim.play("Idle")
		"Walk": anim.play("Walking_A")
		"Run": anim.play("Running_B")
		"Crouch": anim.play("Walking_A")
		"Slide": anim.play("Walking_A")
		"attack": anim.play("1H_Melee_Attack_Slice_Diagonal")
