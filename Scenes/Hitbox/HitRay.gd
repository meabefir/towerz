extends RayCast2D

export(Resource) var damageInfo

signal hurt_enemy

var enemiesHit = []

func setDamageInfo(resource):
	damageInfo = resource

func disable():
	enabled = false

func _process(delta):
	if is_colliding():
		var colliding_with = get_collider()
		if not colliding_with:
			return
		if colliding_with in enemiesHit:
			return
		enemiesHit.append(colliding_with)
		colliding_with.hurt(self)
		emit_signal("hurt_enemy", colliding_with)
