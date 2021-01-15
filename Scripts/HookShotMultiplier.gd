extends Node

func generate_mult():
	var view = get_viewport().size
	print (str(view.x) + "  " + str(view.y))
	var mul = 0.5
	if view.x ==1280:
		mul = 0.41
	elif view.x == 1024:
		mul = 0.5
	elif view.x == 1366:
		mul = 0.39
	elif view.x == 1440:
		mul = 0.35
	elif view.x == 1600:
		mul = 0.34
	elif view.x == 1920:
		mul = 0.265
	if SaveGame.save_data["Fullscreen"] == true:
		mul = 0.28
	return mul
