extends Area2D

export(Resource) var damageInfo

signal hurt_enemy

var enemiesHit = []

func setDamageInfo(resource):
	damageInfo = resource

func disable():
	monitoring = false

func _process(delta):
	if !monitoring:
		return
	var areas = get_overlapping_areas()
	for area in areas:
		if area in enemiesHit:
			return
		enemiesHit.append(area)
		area.hurt(self)
		emit_signal("hurt_enemy", area)
