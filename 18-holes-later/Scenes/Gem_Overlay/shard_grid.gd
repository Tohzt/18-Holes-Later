extends GridContainer

@onready var shard_button:PackedScene = preload("res://Scenes/Gem_Overlay/shard_button.tscn")

func _ready():
	create_gem_grid()

func create_gem_grid():
		
	for child in get_children():
		child.queue_free()
		
	const shards = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
	
	for shard in shards:
		var new_shard: CheckButton = shard_button.instantiate()
		new_shard.name = "shard " + str(shard)
		var rndm = randi_range(1,9)
		if(rndm % 3 ==0):
			new_shard.modulate = Color(0.5,0,1)
		if(rndm % 2 == 0 ):
			new_shard.modulate = Color(1,0,0,1)
			
		add_child(new_shard)
				
