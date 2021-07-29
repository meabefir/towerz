extends Node2D

func _ready():
	for child in get_children():
		child.rotation_degrees = rand_range(0, 360)
