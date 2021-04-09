extends AudioStreamPlayer

var time_save = 0

func game_over():
	playing = false

func change_music(level_name):
	match level_name:
		"Menu":
			stream = load("res://Menu/JDB Artist - Inspirational Vol.2 - 19 Digital Frontier - Short Loop.ogg")
			play()
		"level1", "level2", "level3", "level4":
			if stream != load("res://LevelTemplate/Elfen_Lied_Loop.ogg"):
				stream = load("res://LevelTemplate/Elfen_Lied_Loop.ogg")
				playing = true
			else:
				play(time_save)
		"level5", "level6":
			if stream != load("res://Music/JDB_Detection.wav"):
				stream = load("res://Music/JDB_Detection.wav")
				playing = true
			else:
				play(time_save)
		"HutTemplate":
			if stream != load("res://Music/JDB Artist - Inspirational Vol.2 - 07 In the Name of Science (Adventure).ogg"):
				stream = load("res://Music/JDB Artist - Inspirational Vol.2 - 07 In the Name of Science (Adventure).ogg")
				playing = true
			else:
				play(time_save)

func store_time():
	time_save = get_playback_position()
