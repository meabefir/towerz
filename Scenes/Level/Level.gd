extends Node2D

export(Resource) var levelData

onready var gui = get_node("GUI")
onready var towerGhostManager = get_node("TowerGhostManager")
onready var towers = get_node("Towers")

func _ready():
	gui.coinsManager.coins = levelData.coins
	
	Global.currentLevel = self
	
	return
	# screen capture
	yield(VisualServer, "frame_post_draw")
	# Retrieve the captured Image using get_data().
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png("res://screen captures/img.png")
	
	return
	# this is cool
	yield(Events, "load_next_wave")
	print("wtf is this")
