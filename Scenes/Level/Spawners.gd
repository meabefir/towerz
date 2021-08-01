extends Node2D

export(NodePath) onready var pathNode = get_node(pathNode)

var spawnerScene = preload("res://Scenes/Level/Spawner.tscn")

var waves
var currentWave = -1

func _ready():
	Events.connect("load_next_wave", self, "spawnNextWave")
	
	waves = get_parent().levelData.enemiesInLevel.waves

	# stc
	# now im starting the waves when pressing the button
	#spawnNextWave()
	
func spawnNextWave():
	currentWave += 1
	
	if currentWave >= waves.size():
		# tbi
		# level ends here
		return
	
	var enemies_in_wave = 0
	for i in range(waves[currentWave].enemyType.size()):
		addSpawner(waves[currentWave].enemyType[i], waves[currentWave].nrOfEnemies[i],waves[currentWave].startDelay[i],waves[currentWave].delay[i])
		
		enemies_in_wave += waves[currentWave].nrOfEnemies[i]

	pathNode.enemiesInWave = enemies_in_wave

func addSpawner(enemyType, enemyCount, startDelay, delay):
	var new_spawner = spawnerScene.instance()
	add_child(new_spawner)
	new_spawner.pathNode = pathNode
	new_spawner.init(enemyType, enemyCount, startDelay, delay)
