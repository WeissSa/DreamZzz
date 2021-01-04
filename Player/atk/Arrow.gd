extends Node2D

var SPEED = 800

var movement = Vector2(SPEED, -100)

func _physics_process(delta):
	movement.x = SPEED
	movement.y += 10
	movement.y = clamp(movement.y,-100, 5)
	$Body.move_and_slide(movement, Vector2.UP)
	if $Body.is_on_wall():
		queue_free()

func _on_Hilt_body_entered(body):
	if body.collision_layer == 4:
		body.health -= 1
		queue_free()
