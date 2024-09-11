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
var predict_trace = false
var aim_stable = false
var prev_look_dir = look_dir

func _ready():
	Global.Player = self
	super._ready()

func _process(_delta):
	if is_throwing:
		_check_aim_stability()
		if !predict_trace and aim_stable: 
			var trace_path = get_tree().get_nodes_in_group("Trace")
			if trace_path:
				for trace in trace_path:
					trace.queue_free()
			var trace = Global.Refs.DISC_TRACE.instantiate()
			add_child(trace)
			trace.position = Hand.position
			predict_trace = true
		Global.HUD.charge_bar.value += 2
	else:
		predict_trace = false
	
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

var predict_search = false
var predict_cd_max = 50
var predict_cd = 0
func _check_aim_stability():
	if is_throwing: 
		if Input.get_last_mouse_velocity():
			predict_search = true
			aim_stable = false 
		else:
			if predict_cd <= 0:
				if predict_search:
					aim_stable = true
					predict_search = false
					predict_cd = predict_cd_max
					predict_trace = false
			else:
				predict_cd -= 1
		prev_look_dir = look_dir

func clear_trace():
	predict_cd = 0
	var trace_path = get_tree().get_nodes_in_group("Trace")
	if trace_path:
		for trace in trace_path:
			trace.queue_free()

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			if disc.in_play:
				disc.takeoff_pos = disc.position
			disc.pick_up(Bag)
