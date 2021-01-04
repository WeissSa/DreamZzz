extends KinematicBody2D

onready var Player = get_node("/root").find_node("Player", true, false)

var motion = Vector2()
var speed = 300

func _ready():
	$Timer.start()

func _physics_process(delta):
	var direction_to_player = (Player.position - global_position).normalized()
	motion = direction_to_player * speed
	move_and_slide(motion, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body == Player:
		Player.bottomless_void()
		queue_free()


func _on_Timer_timeout():
	speed *= 1.5

func spawn():
	queue_free()
