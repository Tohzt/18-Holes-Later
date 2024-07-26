extends CharacterBody2D

var dir : Vector2
var power = 0
var spin = 0
var max_height = 0
var height = 0
const gravity = 0.1

var grounded = false

const SPEED = 300
var height_scale = 1.0

func _ready():
	height = 10
	max_height = height
	print("Spin: ", spin)
	velocity = dir * SPEED * (1 + (2*power/100))
	
func _process(delta):
	if !grounded:
		height -= gravity
	
	if height > max_height/2:
		height_scale += .02
	else:
		height_scale -= .02
	scale.x = clamp(height_scale, 0.9, 1.5)
	scale.y = clamp(height_scale, 0.9, 1.5)
	
	if !grounded and height <= 0:
		grounded = true
		set_collision_mask_value(2, true)
		height = 0; 
		velocity = Vector2.ZERO
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.is_in_group("Tree"):
			velocity = velocity.bounce(collision_info.get_normal())
		if collider.is_in_group("Player"):
			collider.discs+=1
			queue_free()
