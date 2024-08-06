extends VFlowContainer

var shard_length
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
var applied = []
var sum = {}
func renderInfo():
	var current_nodes = get_children()
	for node in current_nodes:
		node.queue_free()
		
	for shard in Global.upgrades:
		if shard:
			sum = consolidate(sum, shard)
			Global.upgrades.pop_front()
		
	for perk in sum.keys():
		var new_shard = Label.new()
		new_shard.text = str(sum[perk]) + " " + perk
		add_child(new_shard)
	#for sm in sum:
		#if(sm):
			#var new_shard = Label.new()
			#new_shard.text =str(shard.intensity) +" " + shard.perks.keys()[shard.perk]
			#add_child(new_shard)
			#continue

func consolidate(sum: Dictionary, shard: Shard) -> Dictionary:
	# Check if perk exists in sum dictionary, if not, initialize to 0
	var perk_key = shard.perks.keys()[shard.perk]
	var type_key = shard.shard_types.keys()[shard.activation_type]
	if not sum.has(perk_key):
		sum[perk_key] = 0
	if not sum.has(type_key):
		sum[type_key] = 0
		
	# Accumulate intensity
	sum[perk_key] += shard.intensity
	sum[type_key] += 1
	return sum
	
func _on_timer_timeout():
	renderInfo()
	
	pass # Replace with function body.
