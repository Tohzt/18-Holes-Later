class_name Entity_Zombie
extends Entity

var prev_health

func _ready():
	super._ready()
	prev_health = health

func _process(_delta):
	if prev_health != health:
		$Lightning_Particle.emitting = true
		prev_health = health
	_self_cull()
	$SubViewport/ProgressBar.value = health

func _physics_process(delta):
	super._physics_process(delta)

func _self_cull():
	if position.y < -100:
		queue_free()
