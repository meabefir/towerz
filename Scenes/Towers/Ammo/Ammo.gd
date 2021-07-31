extends Node2D

export var killAfter: float
export var speed: float
export var homingSpeed: float
export var homingAngle: float
export var fadeDuration: float

onready var hitbox = get_children()[0]

var direction = Vector2.RIGHT

var target = null

func _ready():
	hitbox.connect("hurt_enemy", self, "hurtEnemy")
	
	rotation = atan2(direction.y, direction.x)
	
func _process(delta):
	global_position += direction * speed * delta
	
	if target and homingSpeed > 0:
		var target_dir = (target.global_position - global_position).normalized()
		var dot = target_dir.dot(direction)
		if dot < homingAngle:
			return
		direction = direction.move_toward(target_dir, homingSpeed * delta).normalized()
		rotation = atan2(direction.y, direction.x)

func hurtEnemy(enemy):
	queue_free()
		
func fadeOut():
	hitbox.disable()
	var fade_tween = Tween.new()
	fade_tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), fadeDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	add_child(fade_tween)
	fade_tween.start()
	yield(get_tree().create_timer(fadeDuration), "timeout")
	queue_free()

func setDamageResource(resource):
	hitbox.setDamageInfo(resource)
