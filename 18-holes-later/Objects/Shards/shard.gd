class_name Shard
extends Resource
enum shard_types {Player,Enemy,Weapon}
enum shard_rarity {Bone,Charred,Titanium,Special}
@export var name:String
@export var type:shard_types
@export var rarity:shard_rarity
@export var master_shard:Array[Shard]



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
