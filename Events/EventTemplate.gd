extends Area2D



func _on_EventTemplate_body_entered(body):
	get_tree().call_group("entities", "pause")
	$CanvasLayer/DialogueBox.show() 




func _on_DialogueBox_dialogue_over():
	get_tree().call_group("entities", "pause")
	queue_free()
