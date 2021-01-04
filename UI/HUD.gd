extends Control

var hearts = [1, 1, 1]
var hookshot = true
onready var icon = "res://UI/Heart.png"
onready var hookicon = "res://Hookshot/HookShot.png"


func _ready():
	update_UI()

func respawn():
	hearts.pop_back()
	update_UI()
	
func take_damage():
	hearts.pop_back()
	update_UI()

func hookshot_track(used):
	if used:
		hookshot = true
	else:
		hookshot = false
	update_UI()
	

func update_UI():
	$ItemList.clear()
	$ItemList2.clear()
	for i in hearts:
		$ItemList.add_icon_item(load(icon), false)
	if hookshot:
		$ItemList2.add_icon_item(load(hookicon), false)
		
