extends Label

func _process(delta):
	var player = get_tree().get_first_node_in_group("Player")
	var discs = player.discs
		
	self.text = "Discs: " + str(discs)
	pass
