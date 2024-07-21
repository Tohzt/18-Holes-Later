extends Camera3D
@onready var Player = $"../../Player"
@onready var Anchor = $".."

var target:Vector3
var distance:int = 10

func _ready():
	pass
func _process(_delta):
	target = Player.position
	Anchor.position.x = target.x
	Anchor.position.z = target.z
