extends Position2D

func spawn_arrow(direction, pos):
	if direction:
		position = pos + Vector2(-17, 0)
	else:
		position = pos + Vector2(17, 0)
	var arrow = preload("res://Player/atk/Arrow.tscn").instance()
	if direction:
		arrow.rotation_degrees = 180
		arrow.SPEED *= -1
	get_tree().get_root().add_child(arrow)
	arrow.position = position
