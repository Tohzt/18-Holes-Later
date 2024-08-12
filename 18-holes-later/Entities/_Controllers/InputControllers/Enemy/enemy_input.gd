extends InputController

@onready var Target: Entity_Character

func init():
	Target = get_tree().get_first_node_in_group("Character")

func handle_input(_delta):
	_handle_movement_input()
	_handle_attack_input()

func _handle_attack_input():
	pass

func _handle_movement_input():
	#Master.velocity = Master.position.direction_to(Target.position).normalized()
	Master.velocity.y = 0
	
	#if input_dir:
		#Master.velocity.x = input_dir.x * Master.SPEED
		#Master.velocity.z = input_dir.z * Master.SPEED
	#else:
		#Master.velocity.x = move_toward(Master.velocity.x, 0, Master.SPEED)
		#Master.velocity.z = move_toward(Master.velocity.z, 0, Master.SPEED)
