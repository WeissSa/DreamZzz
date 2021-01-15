extends Node

func get_sprite(name):
	match name:
		"Pickles":
			var Pickles = get_node("/root").find_node("Pickle", true, false)
			return Pickles.path
		"Player":
			return "res://Dialogue/HighRes2.png"
	return null


