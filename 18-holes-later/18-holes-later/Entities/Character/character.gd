class_name Entity_Character
extends Entity

@onready var Cam_Mount = $Cam_Mount
@onready var start_pos = position
@onready var Hand = $Hand
@onready var Bag = $Bag

const MAX_POWER = 10
var game_disc_index: int = 0

var can_interact = true
var did_interact = false
var is_charging = false
var is_on_tee = false
var aim_stable = false
var prev_look_dir = look_dir

var in_vehicle: CharacterBody3D

var charge_power = 0.0
var charge_max = 100.0
var charge_rate = 75

# Trace Properties
var predict_trace = false
var predict_search = false
var predict_cd_max = 50
var predict_cd = 0

func _ready():
	super._ready()
	Global.Player = self
	Global.Cameraman.set_target(self, Cam_Mount)
	Global.Cameraman.position = position

func _process(delta):
	super._process(delta)
	visible = false if in_vehicle else true
	new_dir.y = input_look.y
	
	if look_forward: rotation.y = new_dir.y
	if did_interact: did_interact = false
	if in_combat: State_Controller.state_next = "Combat"
	if is_jumping: State_Controller.state_next = "Jump"
	if is_throwing: 
		get_aim_trace()
		if is_charging: 
			charge_power += charge_rate * delta
		elif charge_power > 0:
			charge_rate = abs(charge_rate)
			charge_power -= charge_rate * delta
		charge_power = clamp(charge_power,0,100)
		if charge_power <= 0:
			charge_rate = abs(charge_rate)
		if charge_power >= 100:
			charge_rate = -abs(charge_rate)
	
	
	if Global.Settings.collect_all: _collect_discs()

func _physics_process(delta):
	speed_mult = 1
	if Input.is_action_pressed("run"):
		speed_mult = SPEED_MULT
	var spd = SPEED * speed_mult
	if is_landing: 
		velocity = lerp(velocity, Vector3.ZERO, delta*5)
	else:
		if input_dir:
			velocity.x = input_dir.x * spd
			velocity.z = input_dir.z * spd
		else:
			velocity.x = move_toward(velocity.x, 0, spd)
			velocity.z = move_toward(velocity.z, 0, spd)
	
	
	if in_vehicle:
		is_moving = false
		global_position = in_vehicle.seats[0].global_position
	else:
		if !is_on_floor():
			velocity.y -= gravity * delta
		if !locked_in:
			move_and_slide()

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			if disc.in_play:
				disc.takeoff_pos = disc.position
			disc.pick_up(Bag)

func get_aim_trace():
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
					trace_disc()
			else:
				predict_cd -= 1
		prev_look_dir = look_dir

func trace_disc():
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

func clear_trace():
	predict_cd = 0
	var trace_path = get_tree().get_nodes_in_group("Trace")
	if trace_path:
		for trace in trace_path:
			trace.queue_free()

func anim_play(anim):
	Anim_Controller.anim_state.travel(anim)
