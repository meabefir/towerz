extends Node

const enemyScenePaths = {
	Enemy.ENEMY_TYPE.SOLDIER_E: "res://Scenes/Enemies/Soldiers/SoldierEasy.tscn",
	Enemy.ENEMY_TYPE.SOLDIER_M: "res://Scenes/Enemies/Soldiers/SoldierMedium.tscn",
	Enemy.ENEMY_TYPE.SOLDIER_H: "res://Scenes/Enemies/Soldiers/SoldierHard.tscn"
}

var pathNode = null
var enemyScene = null
var timer = null
var enemiesSpawned = 0
var enemyCount = -1
var delay = -1

func init(enemyType, _enemyCount, startDelay, _delay):
	enemyScene = load(enemyScenePaths[enemyType])
	
	enemyCount = _enemyCount
	delay = _delay
	
	timer = Timer.new()
	if startDelay == 0:
		timer.autostart = true
	else:
		timer.wait_time = startDelay
	timer.connect("timeout", self, "timeout")
	self.add_child(timer)
	timer.start()

func timeout():
	timer.wait_time = delay
	
	var new_enemy = enemyScene.instance()
	pathNode.add_child(new_enemy)
	
	enemiesSpawned += 1
	if enemiesSpawned == enemyCount:
		self.queue_free()
	
	timer.start()
