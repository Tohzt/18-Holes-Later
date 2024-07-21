extends MovementMechanics

@export var discs_in_bag = 3
@onready var AC := $AnimationController

var height = 0.5
var tilt = 90
var power = 50
var golfing = false
var hole_score := 0

# State Machine
func _ready(): initiate_state_machine()

func _process(_delta):
	if position.y < -100: position = Vector3(10,10,10)

func initiate_state_machine():
	sm_main = LimboHSM.new()
	add_child(sm_main)
	
	var idle_state    = LimboState.new().named("IDLE").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state    = LimboState.new().named("WALK").call_on_enter(walk_start).call_on_update(walk_update)
	var drive_state   = LimboState.new().named("DRIVE").call_on_enter(drive_start).call_on_update(drive_update)
	var throw_state   = LimboState.new().named("THROW").call_on_enter(throw_start).call_on_update(throw_update)
	var release_state = LimboState.new().named("RELEASE").call_on_enter(release_start).call_on_update(release_update)
	
	sm_main.add_child(idle_state)
	sm_main.add_child(walk_state)
	sm_main.add_child(drive_state)
	sm_main.add_child(throw_state)
	sm_main.add_child(release_state)
	
	sm_main.initial_state = drive_state
	
	sm_main.add_transition(idle_state, walk_state, &"walk")
	sm_main.add_transition(idle_state, throw_state, &"throw")
	sm_main.add_transition(idle_state, drive_state, &"drive")
	sm_main.add_transition(walk_state, drive_state, &"drive")
	sm_main.add_transition(drive_state, throw_state, &"throw")
	sm_main.add_transition(throw_state, release_state, &"release")
	sm_main.add_transition(sm_main.ANYSTATE, idle_state, &"state_ended")
	
	sm_main.initialize(self)
	sm_main.set_active(true)

func idle_start():
	AC.anim_type = "Idle"
	AC.anim_dir = AC.anim_dir_prev
func idle_update(_delta: float):
	AC.anim_dir = AC.anim_dir_prev
	if velocity.length() >= 0.5:
		sm_main.dispatch(&"walk")
	if Global.mouse_hold_time > 0.0:
		sm_main.dispatch(&"throw")
	if golfing: 
		sm_main.dispatch(&"drive")

func walk_start():
	AC.anim_type = "Walk"
	AC.anim_dir = ""
func walk_update(_delta: float):
	AC.anim_dir = ""
	if velocity.length() < 0.5:
		sm_main.dispatch(&"state_ended")
	if Global.mouse_hold_time > 0.0:
		sm_main.dispatch(&"throw")
	if golfing: 
		sm_main.dispatch(&"drive")

func drive_start():
	golfing = true
	AC.anim_type = "Idle"
	AC.anim_dir = "U"
func drive_update(_delta: float):
	if Global.mouse_hold_time > 0.0:
		sm_main.dispatch(&"throw")

func throw_start():
	AC.anim_type = "Throw"
	AC.anim_dir = "U"
func throw_update(_delta: float):
	if Global.mouse_hold_time <= 0.0:
		sm_main.dispatch(&"release")

func release_start():
	AC.anim_type = "Release"
	AC.anim_dir = "U"
func release_update(_delta: float):
	if !AC.is_playing():
		sm_main.dispatch(&"state_ended")


func _on_pickup(area):
	var pickup = area.get_parent()
	if pickup.is_in_group("Disc"):
		if pickup.game_disc:
			golfing = true
		discs_in_bag += 1
		pickup.queue_free()
