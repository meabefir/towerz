extends Node2D

export(Resource) var levelData

onready var gui = get_node("GUI")

func _ready():
	gui.coinsManager.setCoins(levelData.coins)

	Global.currentLevel = self
