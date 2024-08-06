class_name Shard_Button
extends CheckButton
@export var shard:Shard

func _ready():
	if(shard):
		print(shard.activation_type)

		match shard.activation_type:
			0:
				tooltip_text = str(shard.activation_type)
				modulate=Color(1,-0.7,0)
			1:
				tooltip_text = str(shard.activation_type)
				modulate=Color(0,1,0)
			2:
				tooltip_text = str(shard.activation_type)
				modulate=Color(0.5,-0.5,1)

func _on_pressed():
	print("you pushed the button",shard.name)
	print(str(shard.activation_type))
	
			
	pass # Replace with function body.
