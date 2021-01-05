extends KinematicBody2D

var sprites = []

onready var Player = get_node("/root").find_node("Player", true, false)

func _ready():
	$AnimationPlayer.play("Hover Left")
	randomize()
	randomize_timer()
	$CurrentSprite.modulate = Color("ffffff")
	$NextSprite.modulate = Color("00ffffff")
	var sprite_directory = Directory.new()
	sprite_directory.open("res://Player/Pickle/sprites/")
	sprite_directory.list_dir_begin()
	var sprite_path = sprite_directory.get_next()
	while sprite_path != "":
		if sprite_path.ends_with("png"):
			sprites.append("res://Player/Pickle/sprites/" + sprite_path)
		sprite_path = sprite_directory.get_next()
	print (sprites)

func randomize_timer():
	$Morph.wait_time = randi() % 5 + 5
	$Morph.start()


func _process(delta):
	if Player.motion.x > -1:
		$CurrentSprite.flip_h = false
		$NextSprite.flip_h = false
		$AnimationPlayer.play("Hover Left")
	else:
		$CurrentSprite.flip_h = true
		$NextSprite.flip_h = true
		$AnimationPlayer.play("Hover Right")



func _on_Morph_timeout():
	$NextSprite.texture = load(sprites[randi() % len(sprites)])
	$Morpher.play("Morph")


func _on_Morpher_animation_finished(anim_name):
	$CurrentSprite.texture = $NextSprite.texture
	$CurrentSprite.modulate = Color("ffffff")
	$NextSprite.modulate = Color("00ffffff")
	randomize_timer()
