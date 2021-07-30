extends Control

export(PackedScene) var confirmationPopupScene

onready var towerMode = get_node("TowerMode")
onready var upgrades = get_node("Upgrades")
onready var sellButton = get_node("SellButton")
onready var animationPlayer = get_node("AnimationPlayer")

var tower: Tower = null

func _ready():
	get_parent().towerSettings = self
	
	towerMode.init(tower.settingsData.targetingModes)
	upgrades.init(tower.settingsData.upgradeInfo)
	sellButton.init(tower.settingsData.sellPrice)
	open()

func initSellButton():
	sellButton.init(tower.settingsData.sellPrice)

func open():
	animationPlayer.play("open")

func close():
	animationPlayer.play("close")
	tower.deselect()

func createConfirmationPopup(message, confirm_func, object, deny_func = null):
	var new_popup = confirmationPopupScene.instance()
	new_popup.init(message, confirm_func, object, deny_func)
	add_child(new_popup)

	
func destroy():
	queue_free()
