extends GridContainer
var resources = []

@onready var shard_button:PackedScene = preload("res://Scenes/Gem_Overlay/shard_button.tscn")
@export var shard_array:Array[Shard]
func _ready():
	await load_resources()
	await create_gem_grid()

func create_gem_grid():
		
	for child in get_children():
		child.queue_free()
		
	var shards = []
	for possible in range(20):
		var surprise = randi_range(0,resources.size()-1)
		shards.append(resources[surprise])
	
	for shard in shards:
		var new_shard: Shard_Button = shard_button.instantiate()
		print(shard)
		new_shard.name = "shard " + str(shard)
		new_shard.shard = shard

		add_child(new_shard)
				



func load_resources():
	var dir = DirAccess.open("res://Objects/Shards/Shards")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
				#print("Found directory: " + file_name)
			else:
				#print("Found file: " + file_name)
				var shrd = ResourceLoader.load("res://Objects/Shards/Shards/" + file_name,"shard",ResourceLoader.CACHE_MODE_REUSE)
				resources.append(shrd)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

#func create_buttons():
	#var y_position = 0
	#for resource in resources:
		#var button = Button.new()
		#button.text = resource.get_name()  # Assuming the resource has a `get_name` method or similar
		#button.rect_min_size = Vector2(200, 40)  # Set size of the button
		#button.rect_position = Vector2(10, y_position)  # Set position of the button
		#y_position += 50
		#
		## You can store the resource info in the button's metadata or custom data
		#button.set_meta("resource", resource)
		#
		#button.connect("pressed", self, "_on_button_pressed", [resource])
		#
		#add_child(button)

