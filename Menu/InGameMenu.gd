extends Popup



func _on_VideoSettings_pressed():
	$VideoSettings.show()
	$Click.play()


func _on_AudioSettings_pressed():
	$AudioSettings.show()
	$Click.play()


func _on_backButton_pressed():
	$Click.play()
	get_tree().call_group("entities", "pause")
	hide()


func _on_ControlSettings_pressed():
	$KeyBindings.show()
	$Click.play()


func _on_Audio_Settings_click():
	$Click.play()


func _on_Video_Settings_click():
	hide()
	popup_centered()
	$Click.play()


func _on_KeyBindings_click():
	$Click.play()


func _on_QuitButton_pressed():
	SaveGame.save_game()
	get_tree().quit()
