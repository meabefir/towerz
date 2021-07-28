extends Control

export(NodePath) onready var increaseLabel = get_node(increaseLabel)
export(NodePath) onready var costLabel = get_node(costLabel)
export(NodePath) onready var buyButton = get_node(buyButton)

var increase = null
var cost = null
var type = null
var tower = null
var next = null

func init(_increase: float, _cost: float, _type, _tower):
	increase = _increase
	cost = _cost
	type = _type
	tower = _tower
	
func _ready():
	increaseLabel.text = "+" + str(increase)
	costLabel.text = str(cost)

func disable():
	buyButton.disabled = true
	buyButton.mouse_default_cursor_shape = CURSOR_FORBIDDEN
	
func enable():
	buyButton.disabled = false
	buyButton.mouse_default_cursor_shape = CURSOR_ARROW

func _on_BuyButton_pressed():
	if Global.currentLevel.gui.coinsManager.coins >= cost:
		Global.currentLevel.gui.towerSettings.createConfirmationPopup("Buy upgrade for " + str(cost) + " coins?", "confirmed", self)

func confirmed():
	Global.currentLevel.gui.coinsManager.coins -= cost
	
	tower.upgrade(type, increase)
	
	if next != null:
		next.enable()
	queue_free()

func _on_UpgradeButton_tree_exiting():
	get_parent().get_parent().checkFree()
