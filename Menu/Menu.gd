extends Control

func _ready():
	pass


func _on_PlayButton_pressed():
	$Click.play()
	$LevelTimer.start()



func _on_OptionButton_pressed():
	$Settings.popup_centered()
	$Click.play()

func _on_CreditButton_pressed():
	$Click.play()
	
func _on_QuitButton_pressed():
	$Click.play()
	$QuitTimer.start()
	



func _on_QuitTimer_timeout():
	get_tree().quit()


func _on_LevelTimer_timeout():
	get_tree().change_scene("res://levels/TestLevel.tscn")


func _on_Settings_click():
	$Click.play()
