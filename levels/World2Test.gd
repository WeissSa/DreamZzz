extends "res://LevelTemplate/LevelTemplate.gd"


func _ready():
	$Player/UI/InGameMenu.visible = false
	Music.change_music(name)
	$Player/Light.queue_free()
	$Player.world = 2
