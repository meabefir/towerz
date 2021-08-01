extends Control

export(PackedScene) var TowerPreviewScene

export(NodePath) onready var button = get_node(button)
export(NodePath) onready var animationPlayer = get_node(animationPlayer)

export var opened = false
export var dist_from_center: float = 50
export var transitioning = false

#func _draw():
#	draw_circle(button.rect_position + button.rect_pivot_offset, 140, Color.red)
#
#func _process(delta):
#	update()

func _ready():
	button.disabled = false
	opened = false
	mouse_filter = MOUSE_FILTER_IGNORE
	
	# set pivot on texture button
	button.rect_pivot_offset = button.texture_normal.get_size() / 2

func _gui_input(event):
	if Input.is_action_just_pressed("click"):
		if !transitioning:
			close()

func _on_TextureButton_pressed():
	if !opened:
		animationPlayer.play("open")
		closeTowerSettings()
	else:
		close()

func close():
	animationPlayer.play("close")

func createTowerPreviews():
	var towers_unlocked = Global.currentLevel.levelData.towersUnlocked.types

	var nr_available = towers_unlocked.size()
	var angle_between = 360 / nr_available
	
	var offset = Vector2.LEFT * dist_from_center - Vector2(button.rect_pivot_offset.x / 2, 0)
	
	for tower_type in towers_unlocked:
		var new_tower_preview = TowerPreviewScene.instance()
		new_tower_preview.type = tower_type
		#new_tower_preview.offset = offset
		button.add_child(new_tower_preview)
		new_tower_preview.rect_position = offset
		new_tower_preview.rect_position -= button.rect_pivot_offset / 2 / button.rect_scale.x
		offset = offset.rotated(deg2rad(angle_between))

func closeTowerSettings():
	get_tree().call_group("towerSettings", "close")

func closePreviews():
	for preview in button.get_children():
		preview.close()
