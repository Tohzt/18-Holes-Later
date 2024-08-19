class_name Entity_Character
extends Entity

@onready var Tripod = $Tripod_Main
@onready var Hand = $Hand
@onready var Bag = $Bag

var game_disc_index: int = 0

const MAX_POWER = 2
var is_throwing = false
var is_on_tee = false
var strokes = 0

func _ready():
	Global.Player = self
	super._ready()

func _process(delta):
	super._process(delta)
	
	_collect_discs()

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			disc.pick_up(Bag)

func send_camera(new_parent):
	print("Send Camera")
	Tripod.snap_back_position = Tripod.position
	Tripod.snap_back_rotation = Tripod.rotation
	Tripod.reparent(new_parent)

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var angle_limit_down = 80
			var angle_limit_up = 20
			Tripod.rotation.x = clampf(Tripod.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			
			if State_Controller.state_suffix != "_Charge": 
				Tripod.rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
				look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
