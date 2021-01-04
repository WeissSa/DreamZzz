extends Area2D


func _ready():
	$AnimationPlayer.play("Hover")
	show()

func _on_HookShotPowerup_body_entered(body):
	if body.jump_count and visible == true:
		body.hookshottable = true
		body.cooldown = true
		get_tree().call_group("UI", "hookshot_track", true)
		$Particles2D.emitting = true
		$ParticleTimer.start()
		$AudioStreamPlayer.play()


func _on_ParticleTimer_timeout():
	hide()
	$RespawnTimer.start()


func _on_RespawnTimer_timeout():
	show()
