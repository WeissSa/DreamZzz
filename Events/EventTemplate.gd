extends Area2D

var inside = false

export (bool) var mandatory = false

func _ready():
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/RichTextLabel.hide()
	var key = InputEventKey.new()
	key.scancode = SaveGame.save_data["action"]
	InputMap.action_add_event("action", key)
	$CanvasLayer/RichTextLabel.text = key.as_text()

func _on_EventTemplate_body_entered(body):
	if !mandatory:
		$CanvasLayer/ColorRect.show()
		$CanvasLayer/RichTextLabel.show()
	else:
		get_tree().call_group("entities", "pause")
		$CanvasLayer/DialogueBox.show() 
		$CanvasLayer/ColorRect.hide()
		$CanvasLayer/RichTextLabel.hide()
	inside = true

func _input(event):
	if Input.is_action_pressed("action") and inside and !mandatory:
		get_tree().call_group("entities", "pause")
		$CanvasLayer/DialogueBox.show() 
		$CanvasLayer/ColorRect.hide()
		$CanvasLayer/RichTextLabel.hide()


func pause():
	if inside and !mandatory:
		$CanvasLayer/ColorRect.visible = !$CanvasLayer/ColorRect.visible
		$CanvasLayer/RichTextLabel.visible = !$CanvasLayer/RichTextLabel.visible

func _on_DialogueBox_dialogue_over():
	get_tree().call_group("entities", "pause")
	queue_free()


func _on_DialogueEvent_body_exited(body):
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/RichTextLabel.hide()
	inside = false
