extends Control

signal music_start

func _ready():
	show()

func _on_Timer_timeout():
	$AudioStreamPlayer.play()


func _on_Timer2_timeout():
	$AnimationPlayer.play("Fade")
	emit_signal("music_start")
