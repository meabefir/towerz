extends "res://Scenes/Towers/Tower.gd"

onready var shootPoint = get_node("Gun/ShootPoint")
	
func shoot():
	var new_bullet = ammoScene.instance()
	new_bullet.direction = Vector2(cos(gun.rotation), sin(gun.rotation)).normalized()
	new_bullet.global_position = shootPoint.global_position
	new_bullet.target = target
	get_parent().bullets.add_child(new_bullet)
	new_bullet.setDamageResource(damageResource)
	
	canShoot = false
	shootTimer.start()

	setRecoil()
