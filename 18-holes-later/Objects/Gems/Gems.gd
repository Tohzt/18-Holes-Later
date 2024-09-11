class_name Gem
extends Resource 

@export var name:String
enum element_type {Earth,Wind,Fire,Water,Lightning,Metal,Holy,Dark}
@export var elemental_type:element_type
@export var icon: PackedScene
@export var master_shard:Array[Shard_Special]
@export var shard_array: Array[Shard]
@export var note:String

# Constants for loading shard data
const SHARD_COUNT = 21
const MASTER_SHARD_COUNT = 4
const SHARD_DIR = "res://Objects/Shards/Shards/"
const MASTER_SHARD_DIR = "res://Objects/Shards/Shard_Specials/"

# Load all shards and populate shard_array
func load_shards():
	var shards:Array[Shard] = []
	var dir = DirAccess.open(SHARD_DIR)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		print(file_name)
		while file_name != "":
			if file_name.ends_with(".tres"):
				var shard_res = ResourceLoader.load(SHARD_DIR + file_name)
				if shard_res != null:
					shards.append(shard_res)
			file_name = dir.get_next()
		dir.list_dir_end()
	for i in SHARD_COUNT:
		shard_array.append(shards.pick_random())
	#else:
		#print("Not enough shards available to populate the shard array")

# Load all master shards and populate master_shard array
func load_master_shards():
	var master_shards:Array[Shard_Special] = []
	var dir = DirAccess.open(MASTER_SHARD_DIR)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tres"):
				print(file_name)
				var master_shard_res = ResourceLoader.load(MASTER_SHARD_DIR + file_name)
				if master_shard_res != null:
					master_shards.append(master_shard_res)
			file_name = dir.get_next()
		dir.list_dir_end()
	
	for i in MASTER_SHARD_COUNT:
		master_shard.append(master_shards.pick_random())	
	#if master_shards.size() >= MASTER_SHARD_COUNT:
		#master_shard = master_shards.duplicate().slice(0, MASTER_SHARD_COUNT)
	#else:
		#print("Not enough master shards available to populate the master shard array")

# Initialize and load shard data
func initialize_gem():
	load_shards()
	load_master_shards()
	print("Shards loaded:", shard_array)
	print("Master shards loaded:", master_shard)
