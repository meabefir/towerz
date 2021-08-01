extends "res://Scenes/Towers/Ammo/Ammo.gd"

export(PackedScene) var explosionScene
var explosionDamageResource = null

func hurtEnemy(enemy):
	explode()
	
func killTimeout():
	explode()
	
func explode():
	var new_explosion = explosionScene.instance()
	new_explosion.global_position = global_position
	get_parent().add_child(new_explosion)
	if explosionDamageResource != null:
		new_explosion.setDamageResource(explosionDamageResource)
	queue_free()

func setDamageResource(resource):
	explosionDamageResource = resource
