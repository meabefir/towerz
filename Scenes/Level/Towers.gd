extends Node2D

export(NodePath) onready var bullets = get_node(bullets)
export(NodePath) onready var gui = get_node(gui)


func _ready():
	for tower in get_children():
		tower.connect("selected", gui, "towerSelected")
		tower.connect("deselected", gui, "towerDeselected")
