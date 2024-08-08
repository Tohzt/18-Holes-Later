class_name Entity_Zombie
extends Entity

func _ready():
	super._ready()

func _process(_delta):
	_self_cull()
	$SubViewport/ProgressBar.value = health

func _physics_process(delta):
	super._physics_process(delta)

func _self_cull():
	if position.y < -100:
		queue_free()
