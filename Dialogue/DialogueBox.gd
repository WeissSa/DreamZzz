extends Control

onready var speechLabel = $NinePatchRect/DialogueLabel
onready var nameLabel = $NinePatchRect/NameLabel
var data
var i = 1 
var done = false
var first = true
var question = false
var over = false
export (String, FILE) var path = null


signal dialogue_over
signal yes
signal no


func _ready():
	speechLabel.visible_characters = 0
	var dialogue = File.new()
	dialogue.open(path, dialogue.READ)
	var content = dialogue.get_as_text()
	data = parse_json(content)
	dialogue.close()
	hide()


func _process(delta):
	if first and visible:
		display(i)
		speechLabel.visible_characters = 0
		first = false
	if visible:
		if Input.is_action_just_pressed("action") or Input.is_action_just_pressed("attack"):
			if not done:
				speechLabel.visible_characters = data[str(i)].get("text").length()
				done = true
			elif not question:
				i += 1
				speechLabel.visible_characters = 0
				display(i)



func display(message_number):
	if message_number <= data.size():
		speechLabel.bbcode_text = data[str(message_number)].get("text")
		nameLabel.bbcode_text = data[str(message_number)].get("person")
		var sprite = DialogueHelper.get_sprite(data[str(message_number)].get("person"))
		if load(sprite) != $TextureRect.texture:
			$TextureRect/AnimationPlayer.play("Fade")
		$TextureRect.texture = load(sprite)
		if data[str(message_number)].get("person") == "Pickles":
			var Pickles = get_node("/root").find_node("Pickle", true, false)
			sprite = Pickles.texture_store
		done = false
		$Timer.start()
		speechLabel.visible_characters = 0
		if data[str(message_number)].get("Question"):
			$YesButton.show()
			$NoButton.show()
			question = true
	else:
		i = -1
		hide()
		emit_signal("dialogue_over")
	if over:
		i = -1
		hide()
		emit_signal("dialogue_over")

func _on_Timer_timeout():
	speechLabel.visible_characters += 1
	if i != -1:
		if speechLabel.visible_characters == data[str(i)].get("text").length():
			done = true


func _on_YesButton_pressed():
	$YesButton.hide()
	$NoButton.hide()
	question = false
	i += 1
	speechLabel.visible_characters = 0
	display(i)
	over = true
	emit_signal("yes")


func _on_NoButton_pressed():
	$YesButton.hide()
	$NoButton.hide()
	i += 2
	speechLabel.visible_characters = 0
	display(i)
	question = false
	emit_signal("no")

