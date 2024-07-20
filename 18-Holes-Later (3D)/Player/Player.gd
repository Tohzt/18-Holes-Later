extends MovementMechanics

@onready var AC := $AnimationController

var height = 1
var tilt = 90
var power = 50

# State Machine
var sm_main: LimboHSM
func _ready(): initiate_state_machine()

func initiate_state_machine():
	sm_main = LimboHSM.new()
	add_child(sm_main)
	
	var idle_state  = LimboState.new().named("IDLE").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state  = LimboState.new().named("WALK").call_on_enter(walk_start).call_on_update(walk_update)
	var throw_state = LimboState.new().named("THROW").call_on_enter(throw_start).call_on_update(throw_update)
	
	sm_main.add_child(idle_state)
	sm_main.add_child(walk_state)
	sm_main.add_child(throw_state)
#test comment
	sm_main.initial_state = idle_state
	
	sm_main.add_transition(idle_state, walk_state, &"walking")
	sm_main.add_transition(sm_main.ANYSTATE, idle_state, &"state_ended")
	
	sm_main.initialize(self)
	sm_main.set_active(true)

func idle_start():
	AC.anim_type = "Idle"
	AC.anim_dir = AC.anim_dir_prev
	
func idle_update(delta: float):
	print("Idle")
	AC.anim_dir = AC.anim_dir_prev
	if velocity.length() >= 0.5:
		sm_main.dispatch(&"walking")

func walk_start():
	AC.anim_type = "Walk"
	AC.anim_dir = ""
	
func walk_update(delta: float):
	print("Walk")
	AC.anim_dir = ""
	if velocity.length() < 0.5:
		sm_main.dispatch(&"state_ended")

func throw_start():
	pass
	
func throw_update(delta: float):
	pass
