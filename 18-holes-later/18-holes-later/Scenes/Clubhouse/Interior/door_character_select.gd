extends Area3D
@onready var character_container = $CanvasLayer/CharacterContainer

func interact():
	Global.Transition.toggle_fade()
	Global.audio_stream_player.play()
	#character_container.toggle_slide()
	var char_sel = get_tree().get_first_node_in_group("Character Select")
	
	if char_sel:
		await get_tree().create_timer(1.0).timeout
		Global.Cameraman.set_target(char_sel)
		await get_tree().create_timer(1.0).timeout
		Global.Transition.toggle_fade(false)
