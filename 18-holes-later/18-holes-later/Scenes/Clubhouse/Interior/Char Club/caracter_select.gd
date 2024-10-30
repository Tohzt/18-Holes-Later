extends Node3D
@onready var Cam_Mount = $Cam_Mount

var look_forward = false
var look_around = false
var input_look: Vector2
var input_move: Vector2
var accepts_input = true
var can_look = true
var new_dir: Vector2
var in_combat = false

var can_interact = true
var locked_in: bool
var can_combat: bool
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
var Target: Node3D
var sight = INF

func set_active(TorF: bool = false):
	pass

func set_target(new_target):
	if new_target: 
		Target = new_target
	
	else:
		Target = null
		var markers = get_tree().get_nodes_in_group("Target Marker")
		for marker in markers:
			marker.queue_free()
