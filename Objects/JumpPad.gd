extends Node2D



func _ready():
	$JumpPad/AnimatedSprite.play("Idle")

func _on_JumpPad_body_entered(body):
	body.jumpPad()
	$JumpPad/AnimatedSprite.play("Squish")
	$JumpPad/AudioStreamPlayer.play()

	


func _on_AnimatedSprite_animation_finished():
	$JumpPad/AnimatedSprite.play("Idle")
