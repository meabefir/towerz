extends Path2D

var enemiesInWave = -1 setget setEnemiesInWave
var enemiesTerminated = []

func setEnemiesInWave(value):
	enemiesInWave = value

func enemyTerminated(enemy):
	if enemy in enemiesTerminated:
		return

	enemiesInWave -= 1
	enemiesTerminated.append(enemy)
	
	if enemiesInWave <= 0:
		enemiesTerminated = []
		Events.emit_signal("wave_finished")
