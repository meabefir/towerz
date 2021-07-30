extends Area2D

const towerPreviewTextures = {
	Tower.TOWER_TYPE.MACHINE_GUN: preload("res://assets/tower previews/machine_gun.png"),
	Tower.TOWER_TYPE.MISSILE_LAUNCHER: preload("res://assets/tower previews/missile_launcher.png"),
}

onready var sprite = get_node("Sprite")

var type
export(Color) var goodColor
export(Color) var badColor
onready var targetHighlightColor = goodColor
onready var currentHighlightColor = goodColor

var lerpSpeed = 10

func _ready():
	sprite.texture = towerPreviewTextures[type]
	modulate = currentHighlightColor

func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()

func _process(delta):
	if !Input.is_action_pressed("click"):
		attemptPlacement()
		
	if currentHighlightColor != targetHighlightColor:
		currentHighlightColor = currentHighlightColor.linear_interpolate(targetHighlightColor, lerpSpeed * delta)
		
		modulate = currentHighlightColor	
		
func attemptPlacement():
	if get_overlapping_areas().size() == 0:
		Global.currentLevel.towers.spawnTower(global_position, type)
	queue_free()


func _on_TowerGhost_area_entered(area):
	targetHighlightColor = badColor
	
func _on_TowerGhost_area_exited(area):
	if get_overlapping_areas().size() == 1:
		targetHighlightColor = goodColor
