extends RigidBody3D

var timer: Timer

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	$GPUParticles3D.emitting = true
	$GPUParticles3D.reparent(get_parent())
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("Disc"):
		self.axis_lock_angular_x = false
		self.axis_lock_angular_z = false
		timer.start(1.0)
