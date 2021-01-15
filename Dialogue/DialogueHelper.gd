extends Node

func get_sprite(name):
	match name:
		"Pickles":
			return "res://Dialogue/Pickles9.png"
		"Player":
			return "res://Dialogue/HighRes2.png"
	return null

func get_pos(name):
	match name:
		"Pickles":
			return Vector2(30,320)
		"Player":
			return Vector2(30,200)
	return null
