extends Node2D


func _ready():
	$Player/UI/InGameMenu.visible = false
	Music.change_music(name)
	$Player.world = 1
	yield(get_tree(), "idle_frame")
	$Player.climbing_time = 1.5


func _input(event):
	if Input.is_action_just_pressed("menu") and !$Player.paused:
		get_tree().call_group("entities", "pause")
		get_tree().call_group("misc", "pause")
		$Player/UI/InGameMenu.visible = !$Player/UI/InGameMenu.visible


