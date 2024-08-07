class_name Shard_Button
extends CheckButton
@export var shard:Shard

func _ready():
	if(shard):
		print(shard.activation_type)
		tooltip_text = str(shard.intensity) + shard.perks.keys()[shard.perk] + shard.shard_types.keys()[shard.activation_type]+ shard.shard_rarity.keys()[shard.rarity]
		match shard.activation_type:
			0:
				modulate=Color(1,-0.7,0)
			1:
				modulate=Color(0,1,0)
			2:
				modulate=Color(0.5,-0.5,1)

func _on_pressed():

	Global.upgrades.append(shard)
	modulate=Color(1,1,1)
	disabled = true
			
	pass # Replace with function body.
