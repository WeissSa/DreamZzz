extends Node2D

export (String, FILE) var path = null

func _ready():
	var dialogue = File.new()
	dialogue.open(path, dialogue.READ)
	var content = dialogue.get_as_text()
	var data = parse_json(content)
	dialogue.close()
	for i in range (data.size()):
		print(data[str(i+1)])
