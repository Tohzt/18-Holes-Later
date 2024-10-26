extends Interact_Class
@onready var Cam_Mount = $Cam_Mount

var look_forward = true
var look_around = false

func _process(delta):
	printt(can_interact, interact_cd)
	if active:
		if Input.is_action_just_pressed("interact"):
			interact_cd = interact_cd_max
			Global.Cameraman.set_target(Global.Player)
			can_interact = false
	
	else:
		can_interact = true
		if interact_cd > 0.0:
			can_interact = false
			interact_cd -= delta

func interact():
	if can_interact:
		Global.Cameraman.set_target(self)
