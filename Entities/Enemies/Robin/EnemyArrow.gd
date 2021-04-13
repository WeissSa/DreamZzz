extends "res://Player/atk/Arrow.gd"


func _on_Hilt_body_entered(body):
	if body.collision_layer == 1:
		body.health -= 1
		body.check_death()
		get_tree().call_group("UI", "take_damage")
		var knockback = 300
		if SPEED < 0:
			knockback = -300
		body.knockbacked = true
		body.hit()
		body.release()
		body.motion = Vector2(knockback, -600)
		body.move_and_slide(body.motion, Vector2.UP)
		queue_free()
