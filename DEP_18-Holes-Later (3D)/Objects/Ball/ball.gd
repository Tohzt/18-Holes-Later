extends RigidBody3D

@onready var collision = $CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.y < -200: queue_free()
	pass
