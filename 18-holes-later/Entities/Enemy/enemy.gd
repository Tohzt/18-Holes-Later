class_name NME_Zombie
extends RigidBody3D

@export var seight_range: int = 50.0
var Target: Entity_Character
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(_delta):
	if !Target:
		Target = Global.Player

func _on_timer_timeout():
	$GPUParticles3D.emitting = true
	$GPUParticles3D.reparent(get_parent())
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("Disc"):
		self.axis_lock_angular_x = false
		self.axis_lock_angular_z = false
		timer.start(1.0)
