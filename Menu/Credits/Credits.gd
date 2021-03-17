extends Control

export (String, FILE) var path 
signal hidden


func _ready():
	hide()
	var creds = File.new()
	creds.open(path, creds.READ)
	var content = creds.get_as_text()
	var data = parse_json(content)
	creds.close()
	$RichTextLabel.text = data["MSG"]

func _on_Button_pressed():
	hide()
	$AudioStreamPlayer.stop()
	emit_signal("hidden")
