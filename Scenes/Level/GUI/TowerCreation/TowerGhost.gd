extends Area2D

onready var sprite = get_node("Sprite")
onready var timer = get_node("Timer")

var type
export(Color) var goodColor
export(Color) var badColor
onready var targetHighlightColor = badColor
onready var currentHighlightColor = badColor

var lerpSpeed = 10
var attemptPlacementNextFrame = false
var minLifetime = .05
var mouseOffset = Vector2(-50, -50)

func _ready():
	sprite.texture = load(TowerPreviewTextures.data[type])
	modulate = currentHighlightColor
	
	timer.start(-1)
	
	global_position = get_global_mouse_position() + mouseOffset

func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + mouseOffset

func _process(delta):
	# check if it should place it
	if attemptPlacementNextFrame:
		attemptPlacement()
		return
	
	if !Input.is_action_pressed("click"):
		var time_passed = timer.wait_time - timer.time_left
		if time_passed >= minLifetime:
			attemptPlacementNextFrame = true
		else:
			queue_free()
		
	# set target color
	if get_overlapping_areas().size() == 0:
		targetHighlightColor = goodColor
	else:
		targetHighlightColor = badColor	
	
	# intorpolate to target color
	if currentHighlightColor != targetHighlightColor:
		currentHighlightColor = currentHighlightColor.linear_interpolate(targetHighlightColor, lerpSpeed * delta)
		
		modulate = currentHighlightColor	
		 
func attemptPlacement():
	global_position.x += 1
	if get_overlapping_areas().size() == 0:
		var coinsManager = get_tree().get_nodes_in_group("coinsManager")[0]
		coinsManager.coins -= TowerPrices.data[type]
		Global.currentLevel.towers.spawnTower(global_position, type)
	queue_free()
