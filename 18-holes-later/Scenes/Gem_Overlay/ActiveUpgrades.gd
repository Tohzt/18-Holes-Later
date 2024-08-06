extends VFlowContainer

var shard_length
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func renderInfo():
	var current_nodes = get_children()
	for node in current_nodes:
		node.queue_free()
	for shard in Global.upgrades:
		if(shard):
			var new_shard = Label.new()
			new_shard.text =str(shard.intensity) +" " + shard.perks.keys()[shard.perk]
			add_child(new_shard)
			continue


func _on_timer_timeout():
	print('timer_timeout')
	renderInfo()
	
	pass # Replace with function body.
