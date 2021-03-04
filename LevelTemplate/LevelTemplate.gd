extends Node2D


func _ready():
	$Player/UI/InGameMenu.visible = false
	Music.change_music(name)

func _input(event):
	if Input.is_action_just_pressed("menu") and !$Player.paused:
		get_tree().call_group("entities", "pause")
		get_tree().call_group("misc", "pause")
		$Player/UI/InGameMenu.visible = !$Player/UI/InGameMenu.visible
