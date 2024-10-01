# WALK STATE
extends CharacterStateClass

func init_state():
	State_Controller.state_options = state_options
	Master.can_throw = false
	Master.can_jump = false
	Master.anim_play("Jump")
	Master.velocity.y = Master.JUMP_FORCE

func monitor_state():
	pass

func update_state():
	if !Master.is_falling and Master.velocity.y < 0:
		Master.is_falling = true
		Master.anim_play("Falling")
	
	if Master.is_falling and Master.is_on_floor():
		Master.anim_play("Land")
		exit_state("Idle")

func exit_state(next_state: String):
	Master.is_jumping = false
	Master.is_falling = false
	Master.can_jump = true
	State_Controller.state_next = next_state
