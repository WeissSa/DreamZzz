extends CanvasLayer

func _ready():
	$EndScreens/RespawnAnim.hide()

func respawn():
	$EndScreens/RespawnAnim.show()
	yield(get_tree(), "idle_frame")
	$EndScreens/RespawnAnim/TextureRect/AnimationPlayer.play("ScreenWipe")
	

func game_over():
	$GameOver.popup_centered()
	$GameOver/CenterContainer/AnimatedSprite.frame = 0
	$game_over.playing = true



func _on_AnimationPlayer_animation_finished(anim_name):
	$EndScreens/RespawnAnim.hide()
	get_tree().call_group("entities", "respawn")


func _on_TryAgain_pressed():
	get_tree().reload_current_scene()


func _on_mainMenu_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
