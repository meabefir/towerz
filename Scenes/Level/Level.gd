extends Node2D

export(Resource) var levelData

onready var gui = get_node("GUI")
onready var towerGhostManager = get_node("TowerGhostManager")
onready var towers = get_node("Towers")

func _ready():
	gui.coinsManager.coins = levelData.coins
	
	Global.currentLevel = self
