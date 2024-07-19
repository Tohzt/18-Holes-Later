extends Camera2D
@onready var player = $"../Player"
var target : Vector2
func _ready():
	target = player.position
	pass

func _process(delta):
	if !player.stuck:
		#position = player.position - Vector2(600, 300)
		target = player.position - Vector2(600, 300)
	var discs = get_tree().get_nodes_in_group("Disc")
	for disc in discs:
		if !disc.grounded:
			#position = disc.position - Vector2(600, 300)
			target = disc.position - Vector2(600, 300)
	
	position.x = move_toward(position.x, target.x, 10)
	position.y = move_toward(position.y, target.y, 10)
