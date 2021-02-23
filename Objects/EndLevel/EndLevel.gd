extends Node2D

export (String) var  send_to

func _on_Area2D_body_entered(body):
	body.motion = Vector2(0,0)
	end_level()
	save_game()


func end_level():
	get_tree().change_scene("res://levels/level" + send_to + ".tscn")

func save_game():
	pass
