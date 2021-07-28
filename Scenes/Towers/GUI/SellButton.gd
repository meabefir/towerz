extends Control

onready var button: TextureButton = get_node("TextureButton")

var sellValue = -1

func _ready():
	Events.connect("increase_cost", self, "increaseCost")

func increaseCost(value):
	sellValue += value

func init(sell_value):
	sellValue = sell_value

func _on_TextureButton_pressed():
	var sell_ref = funcref(self, "sell")
	var cancel_ref = funcref(self, "activate")
	
	button.disabled = true
	get_parent().createConfirmationPopup("Sell this tower for " + str(sellValue) + "?", "sell", self, "activate")

func sell():
	# add money
	# tbi
	get_parent().tower.destroy()

func activate():
	button.disabled = false
