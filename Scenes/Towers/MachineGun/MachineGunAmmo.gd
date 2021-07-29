extends "res://Scenes/Towers/Ammo.gd"

export var bounces: float = 1

func _ready():
	var killTimer = Timer.new()
	killTimer.connect("timeout", self, "fadeOut")
	killTimer.wait_time = killAfter
	add_child(killTimer)
	killTimer.start()


func hurtEnemy(enemy):
	bounces -= 1
	if bounces == 0:
		queue_free()
