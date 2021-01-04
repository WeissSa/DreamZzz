extends Popup

signal click

var can_change_key = false
var action_string
enum ACTIONS {jump, left, right, action, down, attack}


func _ready():
	$ButtonChange.hide()
	$Filter.hide()
	load_defaults()

func load_defaults():
	set_inputs()
	_set_keys()

func set_inputs():
	for i in ACTIONS:
		InputMap.action_erase_event(i, InputMap.get_action_list(i)[0])
		var key = InputEventKey.new()
		key.scancode = SaveGame.save_data[i]
		InputMap.action_add_event(i, key)

func _set_keys():
	for i in ACTIONS:
		get_node("ScrollContainer/VBoxContainer/HBoxContainer_" + str(i) + "/button").set_pressed(false)
		if !InputMap.get_action_list(i).empty():
			get_node("ScrollContainer/VBoxContainer/HBoxContainer_" + str(i) + "/button").set_text(InputMap.get_action_list(i)[0].as_text())
		else:
			get_node("ScrollContainer/VBoxContainer/HBoxContainer_" + str(i) + "/button").set_text("No Button!")

func _on_Left1_pressed():
	_mark_button("left")
	emit_signal("click")


func _on_Up1_pressed():
	_mark_button("jump")
	emit_signal("click")

func _on_actionbutton_pressed():
	_mark_button("action")
	emit_signal("click")


func _on_rightbutton_pressed():
	_mark_button("right")
	emit_signal("click")


func _on_Back_pressed():
	SaveGame.save_game()
	emit_signal("click")
	hide()
func _on_attack_button_pressed():
	_mark_button("attack")
	emit_signal("click")


func _on_down_button_pressed():
	_mark_button("down")
	emit_signal("click")


func _mark_button(x):
	$Filter.show()
	$ButtonChange.show()
	can_change_key = true
	action_string = x
	for j in ACTIONS:
		if j!= x:
			get_node("ScrollContainer/VBoxContainer/HBoxContainer_" + str(j) + "/button").set_pressed(false)

func _input(event):
	if event is InputEventKey:
		if can_change_key:
			_change_key(event)
			can_change_key = false
			$Filter.hide()
			$ButtonChange.hide()

func _change_key(new_key):
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
	
	InputMap.action_add_event(action_string, new_key)
	SaveGame.save_data[action_string] = new_key.scancode
	
	_set_keys()







