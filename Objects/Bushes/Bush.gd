extends Node2D



func _on_Area2D_body_entered(body):
	if body.collision_layer == 1:
		body.detectable = false



	


func _on_Area2D_body_exited(body):
	if body.collision_layer == 1:
		body.detectable = true
