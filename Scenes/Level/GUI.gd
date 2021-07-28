extends CanvasLayer

export(PackedScene) var towerMenuScene

onready var coinsManager = get_node("CoinsManager")

var currentTowerMenu = null
var currentSelectedTower = null
var towerSettings = null

func towerSelected(_tower):
	if currentSelectedTower == _tower:
		return
	
	if currentTowerMenu != null:
		currentTowerMenu.close()
		currentTowerMenu = null
		currentSelectedTower = null
	
	currentTowerMenu = towerMenuScene.instance()
	currentTowerMenu.tower = _tower
	add_child(currentTowerMenu)
	
	currentSelectedTower = _tower
	
func towerDeselected(_tower):
	if currentSelectedTower == _tower:
		currentTowerMenu.close()
		currentTowerMenu = null
		currentSelectedTower = null
