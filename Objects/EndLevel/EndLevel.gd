extends Node2D

export (int) var  send_to

func _on_Area2D_body_entered(body):
	end_level()
	save_game()


func end_level():
	get_tree().quit()


func save_game():
	pass
