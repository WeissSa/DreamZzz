extends Node2D


func _ready():
	$Player/UI/InGameMenu.visible = false

func _input(event):
	if Input.is_action_just_pressed("menu"):
		get_tree().call_group("entities", "pause")
		$Player/UI/InGameMenu.visible = !$Player/UI/InGameMenu.visible
