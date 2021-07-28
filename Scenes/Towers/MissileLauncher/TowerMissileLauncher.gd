extends "res://Scenes/Towers/Tower.gd"

onready var missileLeft = get_node("Gun/MissileLeft")
onready var missileRight = get_node("Gun/MissileRight")

var last_one_shot = 1

func shoot():
	# if no missile is active, return
	if !missileRight.isActive and !missileLeft.isActive:
		return
		
	# alternate between missiles
	var active_missile = null
	if last_one_shot == 1 and missileLeft.isActive:
		active_missile = missileLeft
		last_one_shot *= -1
	elif last_one_shot == -1 and missileRight.isActive:
		active_missile = missileRight
		last_one_shot *= -1
	elif missileLeft.isActive:
		active_missile = missileLeft
		last_one_shot = -1
	else:
		active_missile = missileRight
		last_one_shot = 1
	
	var new_bullet = ammoScene.instance()
	new_bullet.direction = Vector2(cos(gun.rotation), sin(gun.rotation)).normalized()
	get_parent().bullets.add_child(new_bullet)
	new_bullet.global_position = active_missile.global_position
	active_missile.deactivate()
	new_bullet.target = target
	
	canShoot = false
	shootTimer.start()

	setRecoil()

