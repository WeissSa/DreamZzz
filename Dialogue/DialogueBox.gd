extends Control

onready var speechLabel = $NinePatchRect/DialogueLabel
onready var nameLabel = $NinePatchRect/NameLabel
var data
var i = 1 
var done = false
export (String, FILE) var path = null

func _ready():
	speechLabel.visible_characters = 0
	var dialogue = File.new()
	dialogue.open(path, dialogue.READ)
	var content = dialogue.get_as_text()
	data = parse_json(content)
	dialogue.close()
	display(i)

func _process(delta):
	if visible:
		if Input.is_action_just_pressed("action") or Input.is_action_just_pressed("attack"):
			if not done:
				speechLabel.visible_characters = data[str(i)].get("text").length()
				done = true
			else:
				i += 1
				speechLabel.visible_characters = 0
				display(i)


func display(message_number):
	if message_number <= data.size():
		speechLabel.text = data[str(message_number)].get("text")
		nameLabel.text = data[str(message_number)].get("person")
		done = false
		$Timer.start()
	else:
		i = -1
		hide()

func _on_Timer_timeout():
	speechLabel.visible_characters += 1
	if i != -1:
		if speechLabel.visible_characters == data[str(i)].get("text").length():
			done = true
