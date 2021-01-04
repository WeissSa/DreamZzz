extends Popup


signal click

func _ready():
	load_defaults()

func load_defaults():
	$VBoxContainer/HBoxContainer/CenterContainer/ResolutionOptions.selected = SaveGame.save_data["resolution_index"]
	var x = SaveGame.save_data["resolutionx"]
	var y = SaveGame.save_data["resolutiony"]
	OS.set_window_size(Vector2(x,y))
	$VBoxContainer/HBoxContainer2/CenterContainer/FullScreenMode.selected = int(SaveGame.save_data["Fullscreen"])
	OS.window_fullscreen = SaveGame.save_data["Fullscreen"]
	OS.vsync_enabled = SaveGame.save_data["VSync"]
	$VBoxContainer/HBoxContainer3/CenterContainer/VSyncButton.pressed = SaveGame.save_data["VSync"]

func _on_ResolutionOptions_item_selected(index):
	OS.set_window_size( set_resolution(index) )
	emit_signal("click")

func set_resolution(index):
	var resolution = Vector2()
	SaveGame.save_data["resolution_index"] = index
	match index:
		0:
			resolution = Vector2(1024, 768)
		1:
			resolution = Vector2(1280, 720)
		2:
			resolution = Vector2(1280, 800)
		3:
			resolution = Vector2(1280, 1024)
		4:
			resolution = Vector2(1366, 768)
		5:
			resolution = Vector2(1440, 900)
		6:
			resolution = Vector2(1600, 900)
		7:
			resolution = Vector2(1920, 1280)
	SaveGame.save_data["resolutionx"] = resolution.x
	SaveGame.save_data["resolutiony"] = resolution.y
	return resolution


func _on_FullScreenMode_item_selected(index):
	set_screen(bool(index))
	popup_centered()
	emit_signal("click")

func set_screen(index):
	match index:
		false:
			OS.window_fullscreen = false
			OS.window_borderless = false
			
		true:
			OS.window_fullscreen = true

func _on_BackButton_pressed():
	SaveGame.save_data["Fullscreen"] = bool($VBoxContainer/HBoxContainer2/CenterContainer/FullScreenMode.selected)
	SaveGame.save_data["VSync"] = $VBoxContainer/HBoxContainer3/CenterContainer/VSyncButton.pressed
	SaveGame.save_game()
	hide()
	emit_signal("click")


func _on_VSyncButton_toggled():
	OS.vsync_enabled = !OS.vsync_enabled
	emit_signal("click")
