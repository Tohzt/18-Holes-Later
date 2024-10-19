extends Area3D
@onready var character_container = $CanvasLayer/CharacterContainer

func _process(_delta):
	var overlap = get_overlapping_bodies()
	if overlap: _detect(overlap)

func _detect(overlap):
	for body in overlap:
		if body.is_in_group("Character"):
			if body.did_interact:
				body.cd_interact = 0
				character_container.toggle_slide()
				if character_container.slide_in:
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				else:
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				#set_active(false)
				#if accepts_input:
					#Global.Player.set_active(true)
					#Global.Cameraman.set_target(Global.Player, Global.Player.Cam_Mount)
				#else:
					#set_active(true)
					#Global.Player.set_active(false)
					#Global.Cameraman.set_target(self, Cam_Mount)
