extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 40

var health
var speed = 300
var is_on_fan
var paused = false

var motion = Vector2()


func pause():
	paused = !paused

