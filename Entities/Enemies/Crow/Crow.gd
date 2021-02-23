extends "res://Entities/Entity.gd"

var fan_boost = 1

onready var initial = position

func _ready():
	speed = 200
	health = 1

func _physics_process(delta):
	if not paused:
		if is_on_wall():
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		move()
		move_and_slide(motion, UP)
		check_death()

func check_death():
	if health == 0:
		$AnimationPlayer.play("Die")
		collision_layer = 0
		$Area2D.monitoring = false
		health -=1

func spawn():
	position = initial
	$AnimatedSprite.flip_h = false
	health = 1
	show()
	modulate = Color("ffffff")
	collision_layer = 4
	$Area2D.monitoring = true

func move():
	if $AnimatedSprite.flip_h == true:
		motion.x = -speed
	else:
		motion.x = speed
	if is_on_fan:
		motion.y = -fan_boost*3
	else:
		motion.y=0


func _on_Area2D_body_entered(body):
	if body.collision_layer == 1 and not body.knockbacked:
		body.health -= 1
		body.check_death()
		get_tree().call_group("UI", "take_damage")
		var knockback = 300
		if $AnimatedSprite.flip_h:
			knockback = -300
		body.knockbacked = true
		body.hit()
		body.release()
		body.motion = Vector2(knockback, -600)
		body.move_and_slide(motion, UP)

