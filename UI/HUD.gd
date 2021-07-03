extends Control

var hearts = [1, 1, 1]
var hookshot = true
onready var icon = "res://UI/Heart.png"
onready var hookicon = "res://Hookshot/HookShot.png"

export (int) var TOTAL

func _ready():
	update_UI()
	$Coin.hide()

func respawn():
	hearts.pop_back()
	update_UI()
	
func take_damage():
	hearts.pop_back()
	update_UI()

func add_heart():
	hearts.append(1)
	while len(hearts) > 3:
		hearts.pop_front()
	update_UI()

func hookshot_track(used):
	if used:
		hookshot = true
	else:
		hookshot = false
	update_UI()
	

func update_coin(number):
	$Coin.show()
	$Coin/Label.text = str(number) + "/" + str(TOTAL)
	$Coin/CoinTimer.start()

func update_UI():
	$ItemList.clear()
	$ItemList2.clear()
	for i in hearts:
		$ItemList.add_icon_item(load(icon), false)
	if hookshot:
		$ItemList2.add_icon_item(load(hookicon), false)
		


func _on_CoinTimer_timeout():
	$Coin.hide()
