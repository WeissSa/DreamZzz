extends Node2D


export (String) var ID

func _on_Area2D_body_entered(body):
	if body.motion and $AnimatedSprite.visible:
		$Sparkle/AnimationPlayer.play("sparkle")
		$AudioStreamPlayer.play()
		$AnimatedSprite.hide()
		CoinTracker.add_coin(ID)
		body.health += 1
		get_tree().call_group("UI", "add_heart")
