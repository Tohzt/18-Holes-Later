extends Node
#
#const ENEMY = preload("res://Entities/Enemy/enemy.tscn")
#
#@export var num_enemies: int = 5
#@export var spawn_distance: float = 10.0
#
#func _process(_delta):
	#if Input.is_action_just_pressed("spawn_enemies"):
		#spawn_enemies(Global.Player.position)
		#num_enemies += 1
#
#func spawn_enemies(pos):
	#for i in range(num_enemies):
		#var nme = ENEMY.instantiate()
		#
		## Calculate the position around the player
		#var angle = 2 * PI * i / num_enemies
		#var offset = Vector3(
			#cos(angle) * randf_range(spawn_distance-2,spawn_distance+2),
			#0,  # Assuming you want them on the same Y level as the player
			#sin(angle) * randf_range(spawn_distance-2,spawn_distance+2)
		#)
		#
		#nme.position = pos + offset
		#nme.position.y = pos.y + 2
		#add_child(nme)
