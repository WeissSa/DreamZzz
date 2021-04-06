extends Area2D


func _ready():
	$AnimationPlayer.play("Hover")
	show()

func _on_HookShotPowerup_body_entered(body):
	if body.collision_layer == 1 and $Sprite.visible == true:
		body.jump_count -= 1
		$Sparkle/AnimationPlayer.play("sparkle")
		$RespawnTimer.start()
		$AudioStreamPlayer.play()
		$Sprite.hide()




func _on_RespawnTimer_timeout():
	show()
	$Sprite.show()

