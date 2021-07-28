extends Area2D

signal hurt

var enemy = null

func _ready():
	if get_parent() is Enemy:
		enemy = get_parent()

func hurt(from):
	emit_signal("hurt", from)

func getOffset():
	if get_parent() is Enemy:
		return get_parent().offset
	return -1
