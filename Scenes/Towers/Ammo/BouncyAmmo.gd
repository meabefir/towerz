extends "res://Scenes/Towers/Ammo/Ammo.gd"

export var bounces: float = 1

func killTimeout():
	fadeOut()

func hurtEnemy(enemy):
	bounces -= 1
	if bounces == 0:
		queue_free()
