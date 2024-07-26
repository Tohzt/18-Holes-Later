extends BTAction

@export var range_min_in_dir: float = 40.0
@export var range_max_in_dir: float = 100.0

@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"

func _tick(_delta) -> Status:
	var pos: Vector3
	var dir = rando_dir()
	
	pos = rando_pos(dir)
	blackboard.set_var(position_var, pos)
	
	return SUCCESS

func rando_pos(dir):
	var vector = Vector3.ZERO
	var distance = randi_range(range_min_in_dir, range_max_in_dir) * dir
	var final_x = (distance + agent.global_position.x)
	vector.x = final_x
	var final_z = (distance + agent.global_position.z)
	vector.z = final_z
	return vector

func rando_dir():
	var dir = randi_range(-2,1)
	if abs(dir) != dir:
		dir = -1
	else:
		dir = 1
	blackboard.set_var(dir_var, dir)
	return dir
