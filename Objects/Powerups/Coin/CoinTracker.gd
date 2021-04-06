extends Node

var coins = []


func _ready():
	coins = SaveGame.save_data["coins"]

func reset():
	coins = []
	SaveGame.save_data["coins"] = []


func add_coin(ID):
	if not(ID in coins):
		coins += [ID]
		SaveGame.save_data["coins"] = coins
	get_tree().call_group("UI", "update_coin", len(coins))
