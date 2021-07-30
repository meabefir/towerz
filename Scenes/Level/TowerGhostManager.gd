extends Node2D

export(PackedScene) var TowerGhostScene

func createGhost(type):
	var new_tower_ghost = TowerGhostScene.instance()
	new_tower_ghost.global_position = get_global_mouse_position()
	new_tower_ghost.type = type
	add_child(new_tower_ghost)
