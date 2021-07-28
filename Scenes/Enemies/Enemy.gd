extends PathFollow2D

class_name Enemy

enum ENEMY_TYPE {SOLDIER_E, SOLDIER_M, SOLDIER_H}

export(Resource) onready var enemyData

onready var speed = enemyData.speed
onready var health = enemyData.health setget setHealth
onready var danger = enemyData.danger

signal reached_end
signal die

func setHealth(value):
	health = value
	
	if health <= 0:
		die()
	
func _ready():
	get_node("Hurtbox").connect("hurt", self, "hurt")

func _process(delta):
	offset += speed * delta

	if get_parent().curve.get_baked_length() <= self.offset:
		emit_signal("reached_end")
		queue_free()
	
func hurt(from):
	self.health -= from.damageInfo.damage

func die():
	emit_signal("die")
	queue_free()
