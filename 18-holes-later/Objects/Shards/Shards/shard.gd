class_name Shard
extends Resource
enum shard_types {Player,Enemy,Weapon}
enum shard_rarity {Bone,Charred,Titanium,Graphene}
enum perks {health,disc_scale,critical_hit,movement_speed,damage_over_time,explosion,multiply_projectiles,fire_rate}
@export var name:String
@export var activation_type:shard_types
@export var intensity: int
@export var perk: perks
@export var rarity:shard_rarity
@export var note:String
