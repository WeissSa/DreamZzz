extends Node2D

var SPEED = 800
var entered = false
var movement = Vector2(SPEED, -100)
var paused = false

func _physics_process(delta):
	if not paused:
		movement.x = SPEED
		movement.y += 10
		movement.y = clamp(movement.y,-100, 5)
		$Body.move_and_slide(movement, Vector2.UP)
		if $Body.is_on_wall() and !entered:
			queue_free()

func _on_Hilt_body_entered(body):
	if body.collision_layer == 4 or body.collision_layer == 6:
		entered = true
		body.health -= 1
		if body.health > 0:
			body.hit()
		queue_free()

func spawn():
	queue_free()

func pause():
	paused = !paused
