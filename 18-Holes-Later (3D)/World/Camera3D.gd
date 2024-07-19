extends Camera3D
@onready var Player = $"../Player"

var target:Vector3
var distance:int = 10

func _ready():
	pass
func _process(_delta):
	target = Player.position
	position.x = target.x
	position.z = target.z
