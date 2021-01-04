extends Node

func generate_mult():
	var view = get_viewport().size
	print (str(view.x) + "  " + str(view.y))
	var mul = 0.38
	if view.x ==1280:
		mul = 0.38
	elif view.x == 1024:
		mul = 0.47
	elif view.x == 1366:
		mul = 0.36
	elif view.x == 1440:
		mul = 0.33
	elif view.x == 1600:
		mul = 0.31
	elif view.x == 1920:
		mul = 0.28
	if SaveGame.save_data["Fullscreen"] == true:
		mul = 0.26
	return mul
