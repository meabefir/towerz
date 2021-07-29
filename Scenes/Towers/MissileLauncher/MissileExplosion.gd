extends Node2D

var dir = randi()%2*2-1
var rotationSpeed = 3
onready var hitbox = get_node("Hitbox")

func _ready():
	$AnimationPlayer.play("explode")
	$AnimatedSprite.play("default")

func setDamageResource(explosionDamageResource):
	hitbox.setDamageInfo(explosionDamageResource)

func _process(delta):
	$AnimatedSprite.rotation += dir * rotationSpeed * delta

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
