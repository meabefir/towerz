extends PathFollow2D

class_name Enemy

enum ENEMY_TYPE {
	SOLDIER_E,
	SOLDIER_M, 
	SOLDIER_H
}

export(Resource) onready var enemyData
export(ENEMY_TYPE) var type

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

	connect("die", get_parent(), "enemyTerminated")
	connect("reached_end", get_parent(), "enemyTerminated")

func _process(delta):
	offset += speed * delta

	if get_parent().curve.get_baked_length() <= self.offset:
		emit_signal("reached_end", self)
		queue_free()
	
func hurt(from):
	self.health -= from.damageInfo.damage

func die():
	# give coins
	var coins_manager = get_tree().get_nodes_in_group("coinsManager")[0]
	coins_manager.coins += EnemyCoinsDrop.data[type]
	
	get_node("Hurtbox").disable()
	emit_signal("die", self)
	queue_free()
