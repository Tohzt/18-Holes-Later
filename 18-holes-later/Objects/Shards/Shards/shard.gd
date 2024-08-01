class_name Shard
extends Resource
enum shard_types {Player,Enemy,Weapon}
enum shard_rarity {Bone,Charred,Titanium,Special}
enum perks {health,critical_hit,movement_speed,damage_over_time,explosion,multiply_projectiles,fire_rate}
@export var name:String
@export var activation_type:shard_types
@export var intensity: int
@export var perk: perks
@export var rarity:shard_rarity



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
