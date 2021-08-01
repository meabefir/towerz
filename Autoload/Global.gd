extends Node

var currentLevel = null
var timeScale = 1 setget setTimeScale

func setTimeScale(value):
	timeScale = value
	
	Engine.time_scale = timeScale
	Events.emit_signal("time_scale_changed")
