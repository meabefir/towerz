extends Node2D

export(NodePath) onready var bullets = get_node(bullets)
export(NodePath) onready var gui = get_node(gui)
export(Array, PackedScene) var towerScenes

func _ready():
	for tower in get_children():
		tower.connect("selected", gui, "towerSelected")
		tower.connect("deselected", gui, "towerDeselected")

func _input(event):
	if Input.is_action_just_pressed("right_click"):
		spawnTower(get_global_mouse_position(), Tower.TOWER_TYPE.MACHINE_GUN)

func spawnTower(_position, tower_type):
	var new_tower = towerScenes[tower_type].instance()
	new_tower.global_position = _position
	add_child(new_tower)
	
	new_tower.connect("selected", gui, "towerSelected")
	new_tower.connect("deselected", gui, "towerDeselected")
