extends "res://Scenes/Towers/Ammo.gd"

export(PackedScene) var explosionScene

func _ready():
	var killTimer = Timer.new()
	killTimer.connect("timeout", self, "explode")
	killTimer.wait_time = killAfter
	add_child(killTimer)
	killTimer.start()

func hurtEnemy(enemy):
	explode()
	
func explode():
	var new_explosion = explosionScene.instance()
	get_parent().add_child(new_explosion)
	new_explosion.global_position = global_position
	queue_free()
