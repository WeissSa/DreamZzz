extends Area2D


func _ready():
	$AnimationPlayer.play("Hover")
	show()

func _on_HookShotPowerup_body_entered(body):
	if body.jump_count and $Sprite.visible == true:
		body.hookshottable = true
		body.cooldown = true
		get_tree().call_group("UI", "hookshot_track", true)
		$Sparkle/AnimationPlayer.play("sparkle")
		$AudioStreamPlayer.play()
		$Sprite.hide()
		$RespawnTimer.start()




func _on_RespawnTimer_timeout():
	$Sprite.show()
