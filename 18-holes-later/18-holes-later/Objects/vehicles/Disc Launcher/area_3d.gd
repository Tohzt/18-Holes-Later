extends Area3D
var player: Entity_Character
@onready var Master: Launcher_Class = get_parent()

func _process(_delta):
	var overlap = get_overlapping_bodies()
	if overlap:
		for body in overlap:
			if body.is_in_group("Character"):
				if body.did_interact:
					if !Master.accepts_input:
						Master.set_active(true)
						Global.Player.set_active(false)
						Global.Cameraman.set_target(Master, Master.Cam_Focus)
					print("Launcher touching: ",body.name)
