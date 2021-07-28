extends Control

export(NodePath) onready var towers = get_node(towers)

func _gui_input(event):
	for tower in towers.get_children():
		tower.handleEvents(event)
