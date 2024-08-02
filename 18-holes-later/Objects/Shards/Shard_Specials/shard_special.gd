class_name Shard_Special
extends Resource
enum damage_type {PROJECTILE,AOE,MELEE}
enum element_type {Earth,Wind,Fire,Water,Lightning,Metal,Holy,Dark}
enum activation_type {Player,Enemy,Weapon}
@export var activates_on: activation_type
@export var intensity: int
@export var damage:damage_type
@export var elemental:element_type
@export var note:String
