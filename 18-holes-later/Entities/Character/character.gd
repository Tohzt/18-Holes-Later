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
var strokes = 0

func _ready():
	Global.Player = self
	super._ready()

func _process(delta):
	if is_charging:
		Global.HUD.charge_bar.value += 2
	super._process(delta)
	_collect_discs()

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			disc.pick_up(Bag)
