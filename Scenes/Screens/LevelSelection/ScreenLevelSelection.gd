extends Control

export(NodePath) onready var container = get_node(container)
export(NodePath) onready var leftButton = get_node(leftButton)
export(NodePath) onready var rightButton = get_node(rightButton)
export(NodePath) onready var label = get_node(label)
export(NodePath) onready var animationPlayer = get_node(animationPlayer)
export(NodePath) onready var arrowAnimation = get_node(arrowAnimation)
export(PackedScene) var LevelPreviewScene

const previewsPerPage = 4
var nrPages
var currentPage = 0

var containerSize = Vector2(768, 384)

func _ready():
	nrPages = floor(Levels.data.size() / previewsPerPage)
	if float(Levels.data.size()) / previewsPerPage != nrPages:
		nrPages += 1
	
	if nrPages == 1:
		rightButton.disabled = true
		
	loadPage(1)
	
func loadPage(page):
	var smaller = page < currentPage
	if !smaller:
		animationPlayer.play("slide_left")
	else:
		animationPlayer.play("slide_right")
	yield(animationPlayer, "animation_finished")
	
	# make this the current page and calculate the first index
	currentPage = page
	var first_index = (page - 1) * previewsPerPage + 1
	
	# delete current previews
	for child in container.get_children():
		child.free()
	
	# change label
	label.text = str(currentPage)
	
	for i in range(first_index, first_index + previewsPerPage):
		if i > Levels.data.size():
			break
		var preview_data = Levels.data[i]
			
		var new_level_preview = LevelPreviewScene.instance()
		new_level_preview.init(preview_data["preview"], preview_data["scenePath"])
		container.add_child(new_level_preview)
		
	if smaller:
		animationPlayer.play("slide_from_left")
	else:
		animationPlayer.play("slide_from_right")
	yield(animationPlayer, "animation_finished")
		
	# disable or enable buttons
	if page == 1:
		leftButton.disabled = true
		rightButton.disabled = false
		if nrPages == 1:
			rightButton.disabled = true
	elif page == nrPages:
		rightButton.disabled = true
		leftButton.disabled = false
		if nrPages == 1:
			leftButton.disabled = true
	else:
		leftButton.disabled = false
		rightButton.disabled = false
		
func _on_Left_pressed():
	arrowAnimation.play("left")
	loadPage(currentPage - 1)

func _on_Right_pressed():
	arrowAnimation.play("right")
	loadPage(currentPage + 1)
