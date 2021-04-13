extends "res://Entities/Entity.gd"

var fan_boost = 1
var can_shoot = true
onready var initial = position
var rebuilding = false

var scale_mult = 4

func _ready():
	speed = 0
	collision_layer = 4
	modulate = Color("ffffff")
	health = 2
	$AnimatedSprite.animation = "Idle"
	$ArrowSpawn.position = Vector2((position.x - 20 * scale.x * scale_mult), position.y + 5)
	

func _physics_process(delta):
	if not paused and not rebuilding:
		check_death()
		if health > 0:
			if $Sight.is_colliding():
				$AnimatedSprite.animation = "Shoot"
				if $AnimatedSprite.frame == 9 and can_shoot:
					var arrow = preload("res://Entities/Enemies/Robin/EnemyArrow.tscn").instance()
					get_tree().get_root().add_child(arrow)
					arrow.scale.x = -scale.x * scale_mult
					arrow.SPEED *= -scale.x * scale_mult
					arrow.position = $ArrowSpawn.position
					can_shoot = false
					$Arrowtimer.start()
					$Bow.play()
			else:
				$AnimatedSprite.animation = "Idle"

func check_death():
	if health == 0:
		$AnimatedSprite.animation = "Collapse"
		collision_layer = 0
		if !rebuilding:
			$Rebuild.start()
			rebuilding = true

func spawn():
	position = initial
	$AnimatedSprite.flip_h = false
	health = 2
	show()
	modulate = Color("ffffff")
	collision_layer = 4
	$AnimatedSprite.animation = "Idle"

func hit():
	$AnimationPlayer.play("Hit")

func _on_Rebuild_timeout():
	$AnimatedSprite.animation = "Rebuild"


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Rebuild":
		collision_layer = 4
		$AnimatedSprite.animation = "Idle"
		rebuilding = false
		health = 2


func _on_Arrowtimer_timeout():
	can_shoot = true
