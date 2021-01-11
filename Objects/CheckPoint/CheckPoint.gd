extends Node2D

var enabled = false

func _ready():
	$LightHolder/Light.enabled = false
	$Particles2D.emitting = false

func _on_Area2D_body_entered(body):
	if not enabled and body.collision_layer == 1:
		get_tree().call_group("spawnpoint", "disable")
		yield(get_tree(),"idle_frame")
		if body.health < 3:
			body.health += 1
			get_tree().call_group("UI", "add_heart")
		switch(true)

func disable():
	if enabled:
		enabled = false
		switch(enabled)

func switch(status):
	if status:
		$Particles2D.emitting = true
		$LightHolder/Light.enabled = true
		enabled = true
		get_tree().call_group("player", "set_spawn", global_position)
	else:
		$Particles2D.emitting = false
		$LightHolder/Light.enabled = false
