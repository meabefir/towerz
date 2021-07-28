extends Node2D

var dir = randi()%2*2-1
var rotationSpeed = 3

func _ready():
	$AnimationPlayer.play("explode")
	$AnimatedSprite.play("default")

func _process(delta):
	$AnimatedSprite.rotation += dir * rotationSpeed * delta

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
