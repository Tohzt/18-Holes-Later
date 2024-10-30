extends Area3D
@onready var character_container = $CanvasLayer/CharacterContainer

func interact():
	print("Interacting with Character Select")
	#character_container.toggle_slide()
	var char_sel = get_tree().get_first_node_in_group("Character Select")
	if char_sel:
		Global.Cameraman.set_target(char_sel)
