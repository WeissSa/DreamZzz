extends Node2D

var hooked = false

func _on_Area_hide():
	$Area.collision_layer = 0
	$Area.collision_mask = 0
	$Area/StaticBody2D.collision_layer = 0
	$Area/StaticBody2D.collision_mask = 0
	get_tree().call_group("Hookshot", "release")


func _on_Area_body_entered(body):
	if visible:
		$Fade.play("Fade")
		if body.name == "Tip":
			hooked = true
			


func _on_Fade_animation_finished(anim_name):
	$Area.collision_layer = 2
	$Area.collision_mask = 21
	$Area/StaticBody2D.collision_layer = 2
	$Area/StaticBody2D.collision_mask = 21
	
