extends Area3D

var damage = 25
var knockback = 200

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		var knockback_force = get_parent().position.direction_to(body.position) * knockback
		knockback_force.y = 3
		body.take_damage(damage, knockback_force)
