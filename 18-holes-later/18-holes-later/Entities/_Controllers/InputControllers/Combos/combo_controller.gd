class_name ComboController
extends Node

const VALID_INPUTS = [
	"left_click",
	"right_click",
	"move_left",
	"move_right",
	"move_up",
	"move_down",
	"interact",
	"crouch"
]

@export var input_timeout: float = 0.5
@export var max_stored_inputs: int = 10

var input_sequence: Array[String] = []
var input_times: Array[float] = []

# TODO: Extract into resource
var combos = {
	"dash_attack": ["move_right", "move_right", "left_click"],
	"power_slash": ["left_click", "left_click", "right_click"],
	"super_jump": ["crouch", "move_up", "move_up"]
}

func _process(_delta):
	for input in VALID_INPUTS:
		if Input.is_action_just_pressed(input):
			add_input(input)
	
	clean_old_inputs()
	check_combos()

func add_input(input: String) -> void:
	input_sequence.append(input)
	input_times.append(Time.get_unix_time_from_system())
	
	# Trim arrays if they exceed max length
	if input_sequence.size() > max_stored_inputs:
		input_sequence.pop_front()
		input_times.pop_front()

func clean_old_inputs() -> void:
	var current_time = Time.get_unix_time_from_system()
	
	# Remove inputs that are older than timeout
	while input_times.size() > 0 and (current_time - input_times[0]) > input_timeout:
		input_sequence.pop_front()
		input_times.pop_front()

func check_combos() -> void:
	# Check each combo against our current sequence
	for combo_name in combos:
		var combo = combos[combo_name]
		
		# Strict check (exact match at end of sequence)
		if is_combo_match_strict(combo):
			execute_combo(combo_name)
			clear_sequence()
			return
			
		# Loose check (allow for extra inputs between combo inputs)
		elif is_combo_match_loose(combo):
			execute_combo(combo_name)
			clear_sequence()
			return

func is_combo_match_strict(combo: Array) -> bool:
	# Check if the last N inputs match the combo exactly
	if input_sequence.size() < combo.size():
		return false
	
	var start_idx = input_sequence.size() - combo.size()
	for i in combo.size():
		if input_sequence[start_idx + i] != combo[i]:
			return false
	return true

func is_combo_match_loose(combo: Array) -> bool:
	# Check for combo inputs in order, but allow other inputs between them
	var combo_idx = 0
	var sequence_idx = 0
	
	while sequence_idx < input_sequence.size() and combo_idx < combo.size():
		if input_sequence[sequence_idx] == combo[combo_idx]:
			combo_idx += 1
		sequence_idx += 1
	
	return combo_idx == combo.size()

func execute_combo(combo_name: String) -> void:
	print("Executed combo: ", combo_name)  # Replace with actual combo execution
	# Emit signal or call appropriate method to execute the combo
	
func clear_sequence() -> void:
	input_sequence.clear()
	input_times.clear()
