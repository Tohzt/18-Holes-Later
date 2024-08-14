extends StaticBody3D

@export var hole: int = 0


func _on_area_3d_body_entered(body):
	print("Basket was hit by: ", body.name)
