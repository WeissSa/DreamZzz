extends Popup

const MASTER = 0
const SFX = 1
const MUSIC = 2

signal click

func _ready():
	load_defaults()

func load_defaults():
	$VBoxContainer/CenterContainer/MasterSlider.value = SaveGame.save_data["Master_volume"]
	$VBoxContainer/CenterContainer3/SFXSlider.value = SaveGame.save_data["SFX"]
	$VBoxContainer/CenterContainer2/MusicSlider.value = SaveGame.save_data["Music"]

func _on_SaveButton_pressed():
	SaveGame.save_data["Master_volume"] = $VBoxContainer/CenterContainer/MasterSlider.value
	SaveGame.save_data["SFX"] = $VBoxContainer/CenterContainer3/SFXSlider.value
	SaveGame.save_data["Music"] = $VBoxContainer/CenterContainer2/MusicSlider.value
	SaveGame.save_game()
	emit_signal("click")
	hide()


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER, value)


func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX, value)


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC, value)

func _input(event):
	if Input.is_action_just_pressed("menu"):
		hide()
