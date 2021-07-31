extends "res://Scenes/Towers/Tower.gd"

onready var shootPoint1 = get_node("Gun/ShootPoint1")
onready var shootPoint2 = get_node("Gun/ShootPoint2")

func shoot():
	shootAt(shootPoint1)
	shootAt(shootPoint2)
	
	canShoot = false
	shootTimer.start()

	setRecoil()
	
func shootAt(shootPoint):
	var new_bullet = ammoScene.instance()
	new_bullet.direction = Vector2(cos(gun.rotation), sin(gun.rotation)).normalized()
	new_bullet.global_position = shootPoint.global_position
	new_bullet.target = target
	get_parent().bullets.add_child(new_bullet)
	new_bullet.setDamageResource(damageResource)
