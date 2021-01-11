extends KinematicBody2D

var sprites = []
var motion = Vector2(0,0)
var skip = false

onready var Player = get_node("/root").find_node("Player", true, false)

func _ready():
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


func _physics_process(delta):
	if Player.motion.x > 0 and !Player.sliding:
		move(false)
	elif Player.motion.x < 0 and !Player.sliding:
		move(true)
	
	if motion.x > 0:
		$CurrentSprite.flip_h = false
		$NextSprite.flip_h = false
	elif motion.x < 0:
		$CurrentSprite.flip_h = true
		$NextSprite.flip_h = true
	
	
	move_and_slide(motion, Vector2.UP)


func move(left):
	var destinationX
	if left:
		destinationX = Player.position.x - 12
		if global_position.x < (destinationX):
			motion.x = 0
			skip = true
		else:
			skip = false
	else:
		destinationX = Player.position.x + 12
		if global_position.x > (destinationX):
			motion = (Vector2(0,0))
			skip = true
		else:
			skip = false
	if !skip:
		var dirX = destinationX - position.x
		var dirY = Player.position.y - position.y - (randi() % 20 - 10)
		motion = Vector2(dirX, dirY)

func _on_Morph_timeout():
	$NextSprite.texture = load(sprites[randi() % len(sprites)])
	$Morpher.play("Morph")


func _on_Morpher_animation_finished(anim_name):
	$CurrentSprite.texture = $NextSprite.texture
	$CurrentSprite.modulate = Color("ffffff")
	$NextSprite.modulate = Color("00ffffff")
	randomize_timer()
