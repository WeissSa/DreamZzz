extends "res://Entities/Entity.gd"


onready var left_light = $LeftLight
onready var right_light = $RightLight

export var moving = true

const FOV_tolerance = 28

onready var pos = position

var can_flip = true
var previous = 0
var tension = true
var right = true
var seen = false
var awareness = 0
onready var Player = get_node("/root").find_node("Player", true, false)

func _ready():
	speed = 70
	$TextureProgress.value = 0
	motion.x = -speed
	check_lights()
	$AnimatedSprite.play("Idle")

func _physics_process(delta):
	if not paused:
		if moving:
			move()
		else:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.offset = Vector2(-30,0)
		animate()
		check_player(right)
		check_lights()
		if is_on_wall() and can_flip:
			right = !right
			motion.x = -motion.x
			can_flip = false
			$FlipCooldown.start()
		if seen and Player.detectable:
			$TextureProgress.value +=  $TextureProgress.step * 5
		else:
			$TextureProgress.value -= $TextureProgress.step
			

func animate():
	if awareness == 100 or $AnimatedSprite.animation == "Attack":
		$AnimatedSprite.play("Attack")
		speed = 0
		scale = Vector2(0.8,0.8)
		awareness = 0
	else:
		scale = Vector2(1,1)
		$AnimatedSprite.play("Idle")

func move():
	if !right:
		motion.x = speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.offset = Vector2(0,0)
	else:
		motion.x = -speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.offset = Vector2(-30,0)
	move_and_slide(motion)

func check_lights():
	if motion.x >= 0:
		right_light.visible = true
		left_light.visible = false
	elif motion.x < 0:
		right_light.visible = false
		left_light.visible = true

func check_player(right):
	if !right:
		var direction = Vector2(1,0)
		var direction_to_player = (Player.position - global_position).normalized()
		if abs(direction_to_player.angle_to(direction)) < deg2rad(FOV_tolerance) and abs(Player.position.x - global_position.x) < 380 and in_LOS():
			seen = true
		else:
			seen = false
	else:
		var direction = Vector2(-1,0)
		var direction_to_player = (Player.position - global_position).normalized()
		if abs(direction_to_player.angle_to(direction)) < deg2rad(FOV_tolerance) and in_LOS():
			seen = true
		else:
			seen = false
	if abs(Player.position.x - global_position.x) < 80 and abs(Player.position.y - global_position.y) < 100 and in_LOS():
		seen = true

func in_LOS():
	if !(abs(Player.position.x - global_position.x) < 380):
		return false
	else:
		var caster = $RayCast2D
		var direction_to_player = (Player.position - global_position)
		caster.cast_to = direction_to_player
		caster.force_raycast_update()
		if caster.get_collider():
			if caster.get_collider().collision_layer == 1:
				return true
			else:
				return false


func spawn():
	if moving:
		position = pos
		$TextureProgress.value = 0
		awareness = 0
		speed = 70
		$TextureProgress.step = 1
		right = false
		motion.x = -speed
		tension = true


func _on_TextureProgress_value_changed(value):
	if value == 200:
		awareness = 100
		$FireballTimer.start()
		$TextureProgress.step = 0
	elif value == 60 and tension and previous < value:
		$Tension.play()
		tension  = false
		$TensionTimer.start()
	previous = value


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		awareness = 0
		$TextureProgress.step = 2
		$AnimatedSprite.play("Idle")


func _on_FireballTimer_timeout():
	var fireball = preload("res://Entities/Enemies/Wizard/Attack/Fireball/Fireball.tscn").instance()
	add_child(fireball)
	$Fireball.play()


func _on_TensionTimer_timeout():
	tension = true


func _on_FlipCooldown_timeout():
	can_flip = true
