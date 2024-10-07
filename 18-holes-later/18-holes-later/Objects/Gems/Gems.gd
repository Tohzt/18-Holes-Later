class_name Gem
extends Resource 

@export var name:String
enum element_type {Earth,Wind,Fire,Water,Lightning,Metal,Holy,Dark}
@export var elemental_type:element_type
@export var icon: PackedScene
@export var master_shard:Array[Shard_Special]
@export var shard_array: Array[Shard]
@export var note:String
