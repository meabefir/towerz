extends Area2D

signal hurt

var enemy = null

func _ready():
	if get_parent() is Enemy:
		enemy = get_parent()

func hurt(from):
	emit_signal("hurt", from)

func disable():
	get_node("CollisionShape2D").disabled = true

func enable():
	get_node("CollisionShape2D").disabled = false
