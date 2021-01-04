extends Area2D


func _ready():
	$AnimationPlayer.play("Hover")
	show()

func _on_HookShotPowerup_body_entered(body):
	if body.collision_layer == 1 and visible == true:
		body.jump_count -= 1
		body.change_color()
		$Particles2D.emitting = true
		$ParticleTimer.start()
		$AudioStreamPlayer.play()


func _on_ParticleTimer_timeout():
	hide()
	$RespawnTimer.start()


func _on_RespawnTimer_timeout():
	show()

