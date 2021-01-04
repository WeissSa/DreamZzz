extends Node

const SAVEGAME = "user://Savegame.json"

var save_data = {}


func _ready():
	save_data = get_data()
	get_tree().call_group("Menus", "load_defaults")

func get_data():
	var file = File.new()
	if not file.file_exists(SAVEGAME):
		save_data = { "Music" : 0,
			"Master_volume" : 0,
			"SFX": 0,
			"resolutionx" : 1280,
			"resolutiony" : 720,
			"resolution_index" : 1,
			"VSync" : false,
			"Fullscreen" : false,
			"right" : 68,
			"jump" : 87,
			"left" : 65,
			"action" : 70,
			"down" : 83,
			"attack" : 32
		}
		save_game()
	file.open(SAVEGAME, File.READ)
	var content = file.get_as_text()
	var data = parse_json(content)
	save_data = data
	file.close()
	return(data)

func save_game():
	var save_game = File.new()
	save_game.open (SAVEGAME, File.WRITE)
	save_game.store_line(to_json(save_data))
