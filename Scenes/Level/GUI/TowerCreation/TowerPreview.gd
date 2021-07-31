extends Control

export(NodePath) onready var texture = get_node(texture)
onready var tween = get_node("Tween")

var type
var offset

export var closeDuration = .2

func _ready():
	texture.texture_normal = load(TowerPreviewTextures.data[type])

func close():
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(), closeDuration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func _on_Tween_tween_completed(_object, _key):
	queue_free()

func _on_TextureButton_pressed():
		visible = false
		texture.disabled = true
		Global.currentLevel.towerGhostManager.createGhost(type)
		get_tree().call_group("towerCreationIcon", "close")
