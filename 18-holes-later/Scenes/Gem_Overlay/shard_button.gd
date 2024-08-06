class_name Shard_Button
extends CheckButton
@export var shard:Shard

func _ready():
	if(shard):
		print(shard.activation_type)

		match shard.activation_type:
			0:
				tooltip_text = shard.shard_types.keys()[shard.activation_type]
				modulate=Color(1,-0.7,0)
			1:
				tooltip_text = shard.shard_types.keys()[shard.activation_type]
				modulate=Color(0,1,0)
			2:
				tooltip_text = shard.shard_types.keys()[shard.activation_type]
				modulate=Color(0.5,-0.5,1)

func _on_pressed():

	Global.upgrades.append(shard)
	modulate=Color(1,1,1)
	disabled = true
			
	pass # Replace with function body.
