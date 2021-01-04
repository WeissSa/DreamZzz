extends Popup

signal click


func _on_BackButton_pressed():
	emit_signal("click")
	hide()


func _on_KeyButton_pressed():
	$KeyBindings.popup_centered()
	emit_signal("click")


func _on_VideoButton_pressed():
	$VideoSettings.popup_centered()
	emit_signal("click")


func _on_Audio_Button_pressed():
	emit_signal("click")
	$AudioSettings.popup_centered()


func _on_AudioSettings_click():
	emit_signal("click")


func _on_VideoSettings_click():
	emit_signal("click")


func _on_KeyBindings_click():
	emit_signal("click")
