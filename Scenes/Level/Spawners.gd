extends Node2D

export(Resource) onready var enemyData
export(NodePath) onready var pathNode = get_node(pathNode)

var spawnerScene = preload("res://Scenes/Level/Spawner.tscn")

func _ready():
	for i in range(enemyData.enemyType.size()):
		addSpawner(enemyData.enemyType[i], enemyData.nrOfEnemies[i],enemyData.startDelay[i],enemyData.delay[i])

func addSpawner(enemyType, enemyCount, startDelay, delay):
	var new_spawner = spawnerScene.instance()
	add_child(new_spawner)
	new_spawner.pathNode = pathNode
	new_spawner.init(enemyType, enemyCount, startDelay, delay)
