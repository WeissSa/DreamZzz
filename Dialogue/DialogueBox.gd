extends Control

onready var speechLabel = $NinePatchRect/DialogueLabel
onready var nameLabel = $NinePatchRect/NameLabel
var data
var i = 1 
var done = false
var first = true
export (String, FILE) var path = null


signal dialogue_over

func _ready():
	speechLabel.visible_characters = 0
	var dialogue = File.new()
	dialogue.open(path, dialogue.READ)
	var content = dialogue.get_as_text()
	data = parse_json(content)
	dialogue.close()
	hide()
	yield(get_tree(), "idle_frame" )
	display(i)

func _process(delta):
	if first and visible:
		display(i)
		first = false
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
		var sprite = DialogueHelper.get_sprite(data[str(message_number)].get("person"))
		if load(sprite) != $TextureRect.texture:
			$TextureRect/AnimationPlayer.play("Fade")
		$TextureRect.texture = load(sprite)
		if data[str(message_number)].get("person") == "Pickles":
			var Pickles = get_node("/root").find_node("Pickle", true, false)
			sprite = Pickles.texture_store
		done = false
		$Timer.start()
	else:
		i = -1
		hide()
		emit_signal("dialogue_over")

func _on_Timer_timeout():
	speechLabel.visible_characters += 1
	if i != -1:
		if speechLabel.visible_characters == data[str(i)].get("text").length():
			done = true
