class_name Entity_Zombie
extends Entity

func _ready():
	super._ready()

func _process(_delta):
	_self_cull()
	$SubViewport/ProgressBar.value = health

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()

func _self_cull():
	if position.y < -100:
		queue_free()
