extends "res://Entities/Entity.gd"


const JUMP = -700
const CHAIN_PULL = 60
var friction = 90
var jump_count = 0
var on_ground
var jumpBoost = -1100
var fan_boost = 60
var hookshottable = true
var cooldown = true
var knockbacked = false
export var slide_speed = 40

var animate_cancel = false

var detectable = true
var attacking = false
var sliding
var chain_vel = Vector2(0,0)

var respawn_point = Vector2()

onready var left_wall_raycasts = $WallRaycast/Left
onready var right_wall_raycasts = $WallRaycast/Right

var colors = [Color("ffffff"), Color("ffffff"), Color("21297c")]



func _ready():
	speed = 400
	health = 3
	$Light.show()
	

func _physics_process(delta):
	if not paused:
		$Light.show()
		move()
		apply_gravity()
		if not animate_cancel or not sliding:
			animate()
		wall_jump()
		jump()
		if $HookShot.hooked:
			hookshot()
		else:
			chain_vel = Vector2(0,0)
		if not is_on_ceiling():
			motion += chain_vel
		move_and_slide(motion, UP)
	else:
		motion.x = 0
		$AnimatedSprite.play("idle")
		if $Light.visible:
			$Light.hide()


			


func _input(event):
	if not knockbacked:
		if Input.is_action_just_pressed("attack") and not sliding and not paused:
			attacking = true
			$DrawString.start()
		elif event is InputEventMouseButton and not paused:
			if event.pressed and hookshottable and cooldown:
				hookshottable = false
				cooldown = false
				$HookShotCooldown.start()
				get_tree().call_group("UI", "hookshot_track", cooldown)
				animate_cancel = true
				$AnimatedSprite.play("Cast")
				$HookShot.shoot(event.position - get_viewport().size * HookShotMultiplier.generate_mult())
			else:
				$HookShot.release()
				animate_cancel = false
	else:
		$KnockbackTimeout.start()

func release():
	$HookShot.release()
	animate_cancel = false

func move():
	if not knockbacked:
		if Input.is_action_pressed("left"):
			if attacking and is_on_floor():
				motion.x = -10
			else:
				motion.x = clamp(motion.x - friction, -speed, 0)
		elif Input.is_action_pressed("right"):
			if attacking and is_on_floor():
				motion.x  = 10
			else:
				motion.x  = clamp(motion.x + friction, 0, speed)
		else:
			if motion.x > 0:
				motion.x = clamp(motion.x - friction, 0, speed)
			else:
				motion.x = clamp(motion.x + friction, -speed, 0)

func jump():
	if Input.is_action_just_pressed("jump"):
		if jump_count < 2 and not $HookShot.hooked and not $HookShot.flying:
			jump_count += 1
			motion.y = 0
			motion.y += JUMP
			on_ground = false
			$JumpSound.play()
			change_color()
			$AnimatedSprite.modulate = colors[jump_count]

func change_color():
	$AnimatedSprite.modulate = colors[jump_count]


func wall_jump():
	if not (is_on_floor() or motion.y == GRAVITY) and not animate_cancel:
		if check_wall(left_wall_raycasts):
			sliding = true
			motion.y = slide_speed
			$AnimatedSprite.play("WallJump")
			$AnimatedSprite.flip_h = true
			if Input.is_action_just_pressed("jump"):
				motion.y = JUMP
				motion.x = speed*2
				$JumpSound.play()
				sliding = false
		elif check_wall(right_wall_raycasts):
			sliding = true
			$AnimatedSprite.flip_h = false
			motion.y  = slide_speed
			$AnimatedSprite.play("WallJump")
			if Input.is_action_just_pressed("jump"):
				motion.y = JUMP
				motion.x = -speed*2
				$JumpSound.play()
				sliding = false

func check_wall(Raycast):
	for caster in Raycast.get_children():
		if caster.is_colliding():
			return true
	return false

func apply_gravity():
	if is_on_floor():
		if not on_ground:
			sliding = false
			on_ground = true
			jump_count = 0
			motion.y = 0
			knockbacked = false
			change_color()
			if not (hookshottable or $HookShot.hooked):
				hookshottable = true
				if cooldown:
					get_tree().call_group("UI", "hookshot_track", cooldown)
				
	else:
		if on_ground == true:
			on_ground = false
			$GracePeriod.start()
		motion.y += GRAVITY
	if is_on_fan:
		motion.y -= fan_boost

func _on_GracePeriod_timeout():
	if not is_on_floor():
		jump_count = 1

func animate():
	if motion.x > 0:
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite.flip_h = true
	
	if (is_on_floor() or motion.y == GRAVITY) and attacking and not animate_cancel:
		$AnimatedSprite.play("Attack")
		animate_cancel  = true
	elif attacking:
		$AnimatedSprite.play("AirAttack")
		animate_cancel  = true
	elif motion.x != 0 and (motion.y == 0 or motion.y == GRAVITY or on_ground):
		$AnimatedSprite.play("Run")
	elif motion.y > 0 and $AnimatedSprite.animation != "idle" and $AnimatedSprite.animation != "Run" and not (is_on_floor() or motion.y == GRAVITY):
		$AnimatedSprite.play("Fall")
	elif motion.y < 0:
		$AnimatedSprite.play("Jump")
	else:
		$AnimatedSprite.play("idle")
		
	
	
func jumpPad():
	motion.y = jumpBoost
	jump_count = 1
	change_color()
	
func bottomless_void():
	health -= 1
	check_death()
	$HitSound.play()
	get_tree().call_group("UI", "respawn")
	get_tree().call_group("entities", "pause")
	$RespawnTimer.start()
	position = respawn_point

func respawn():
	get_tree().call_group("entities", "spawn")
	hookshottable = true
	$Light.show()
	motion = Vector2(0,0)
	get_tree().call_group("UI", "hookshot_track", hookshottable)


func set_spawn(pos):
	respawn_point = pos

func check_death():
	if health < 1:
		$Light.hide()
		get_tree().call_group("UI", "game_over")
		pause()


func hookshot():
	chain_vel = to_local($HookShot.tip).normalized() * CHAIN_PULL
	if chain_vel.y > 0:
		chain_vel.y *= 0.55
	else:
		chain_vel *= 1.45
	if sign(chain_vel.x) != sign(motion.x):
		chain_vel.x *= 0.3
	if abs($HookShot.tip.x - position.x) > 500:
		release()

func _on_AnimatedSprite_animation_finished():
	attacking = false
	animate_cancel = false

func hit():
	$AnimationPlayer.play("Hit")
	$HitSound.play()
	
func _on_HookShotCooldown_timeout():
	cooldown = true
	if hookshottable or is_on_floor():
		hookshottable = true
		get_tree().call_group("UI", "hookshot_track", cooldown)


func _on_DrawString_timeout():
	$bowSound.play()
	get_tree().call_group("Bow", "spawn_arrow", $AnimatedSprite.flip_h, position)


func _on_KnockbackTimeout_timeout():
	knockbacked = false


func _on_RespawnTimer_timeout():
	get_tree().call_group("entities", "pause")
