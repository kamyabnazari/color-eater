# Author Kamyab Nazari - 2022

extends KinematicBody2D

export (int) var speed = 8
onready var explosion = GameAudio.get_node("Effect/Explosion")
var target = Vector2(288, 850)
var velocity = Vector2()
var obj
var didCol = false

func _input(event):
	if event.is_action_pressed('touched'):
		target = Vector2(300, 200)

func _physics_process(_delta):
	$CPUParticles2D.emitting = false
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 5:
		obj = move_and_collide(velocity, true, true, false)
		if(obj != null):
			$CPUParticles2D.emitting = true
			target = Vector2(288, 850)
			Globals.score += 1
			explosion.play()
			if(Globals.vibrationOn == true):
				Input.vibrate_handheld(500)
