extends Control

onready var label = get_node("Label")

var coins = 0
var visibleValue = 0
var lerpSpeed = .02

func setCoins(value):
	coins = value
	
func _ready():
	label.text = str(visibleValue)
	
func _process(delta):
	updateLabel()

func updateLabel():
	if visibleValue != coins:
		var new_value = int(lerp(visibleValue, coins, lerpSpeed))
		if visibleValue == new_value:
			visibleValue = coins
		else:
			visibleValue = new_value
		label.text = str(visibleValue)
