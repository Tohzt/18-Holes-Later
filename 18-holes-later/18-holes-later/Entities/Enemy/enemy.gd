class_name Entity_Zombie
extends Entity

@onready var zanim = $ZanimController

@export var seight_range: int = 999
var Target: Entity_Character
var timer: Timer
var dir_to_target = Vector3.ZERO
var is_walking = false

var direction: Vector3

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(delta):
	if !Target:
		Target = Global.Player
	
	var spd = SPEED * delta
	if direction:
		velocity = direction * spd
	else:
		velocity.x = move_toward(direction.x, 0, spd)
		velocity.y = move_toward(direction.y, 0, spd)
		velocity.z = move_toward(direction.z, 0, spd)

func _on_body_entered(body):
	if body.is_in_group("Disc"):
		take_damage(10,Vector3.UP*10)

func _on_area_3d_area_entered(area):
	if area.name == "BoneHand":
		take_damage(10,Vector3.UP*10)

func _on_timer_timeout():
	$GPUParticles3D.emitting = true
	$GPUParticles3D.reparent(get_parent())
	queue_free()
