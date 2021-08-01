extends Control

export(NodePath) onready var container = get_node(container)
export(NodePath) onready var leftButton = get_node(leftButton)
export(NodePath) onready var rightButton = get_node(rightButton)
export(PackedScene) var LevelPreviewScene

const previewsPerPage = 4
var nrPages
var currentPage

var containerSize = Vector2(768, 384)

func _ready():
	nrPages = floor(Levels.data.size() / previewsPerPage)
	if float(Levels.data.size()) / previewsPerPage != nrPages:
		nrPages += 1
	
	loadPage(1)
	
func loadPage(page):
	# delete current previews
	for child in container.get_children():
		child.free()
	
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
	
	# make this the current page and calculate the first index
	currentPage = page
	var first_index = (page - 1) * previewsPerPage + 1
	
	for i in range(first_index, first_index + previewsPerPage):
		if i > Levels.data.size():
			break
		var preview_data = Levels.data[i]
			
		var new_level_preview = LevelPreviewScene.instance()
		new_level_preview.init(preview_data["preview"], preview_data["scenePath"])
		container.add_child(new_level_preview)
		
	# no fucking idea
	container.rect_size = containerSize
		
func _on_Left_pressed():
	loadPage(currentPage - 1)

func _on_Right_pressed():
	loadPage(currentPage + 1)
