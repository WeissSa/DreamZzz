extends Node2D


func _ready():
	$Player/UI/InGameMenu.visible = false
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if Input.is_action_just_pressed("menu") and !$Player.paused:
		get_tree().call_group("entities", "pause")
		get_tree().call_group("misc", "pause")
		$Player/UI/InGameMenu.visible = !$Player/UI/InGameMenu.visible
