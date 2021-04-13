extends Node2D

onready var links = $chain
var direction = Vector2(0,0)
var tip = Vector2(0,0)

const SPEED = 50

var flying = false
var hooked = false


func shoot(dir):
	direction = dir.normalized()
	flying = true
	tip = self.global_position
	

func release():
	flying = false
	hooked = false

func _process(delta):
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)
	links.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	links.position = tip_loc/2
	links.region_rect.size.y = tip_loc.length() * 3.2

func _physics_process(delta):
	$Tip.global_position = tip
	if flying:
		if $Tip.move_and_collide(direction * SPEED):
			hooked = true
			$Tip/Node2D/HookParticles/AnimationPlayer.play("sparkle")
			$Tip/clink.play()
			flying = false
	tip = $Tip.global_position
