extends Node2D

var lower = false

export var intensity = 1

func _ready():
	$Area2D/Particles2D/.speed_scale = 1 * intensity
	$Area2D/Particles2D.emitting = true

func _on_Area2D_body_entered(body):
	if body.collision_layer != 0:
		if body.motion:
			if !lower:
				body.motion.y = 500
			body.fan_boost = 60 * intensity
			body.is_on_fan = true


func _on_Area2D_body_exited(body):
	if body.collision_layer != 0:
		if body.motion:
			body.is_on_fan = false


func _on_LowerChecker_body_entered(body):
	if body.name == "Player":
		lower = true


func _on_LowerChecker_body_exited(body):
	if body.collision_layer != 0:
		if body.motion:
			lower = false
