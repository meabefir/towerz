extends Control

export(NodePath) onready var texture = get_node(texture)
export(NodePath) onready var price = get_node(price)
export(NodePath) onready var price_label = get_node(price_label)
onready var tween = get_node("Tween")
onready var animationPlayer = get_node("AnimationPlayer")

var type
var offset

export var closeDuration = .2

func _ready():
	texture.texture_normal = load(TowerPreviewTextures.data[type])

	price_label.text = str(TowerPrices.data[type])

func close():
	price.visible = false
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(), closeDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func _on_Tween_tween_completed(_object, _key):
	if _object == self:
		queue_free()

func _on_TextureButton_pressed():
		var coinsManager = get_tree().get_nodes_in_group("coinsManager")[0]
		if coinsManager.coins < TowerPrices.data[type]:
			animationPlayer.play("price_highlight")
			return
	
		visible = false
		texture.disabled = true
		Global.currentLevel.towerGhostManager.createGhost(type)
		get_tree().call_group("towerCreationIcon", "close")
