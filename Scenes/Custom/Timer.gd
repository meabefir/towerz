extends Node

signal timeout

export var wait_time = 0
var current_time = 0
var running = false

func _process(delta):
	
	if !running:
		return
		
	current_time += delta
	
	if current_time >= wait_time:
		emit_signal("timeout")
		current_time = 0
		running = false

func start():
	running = true
	current_time = 0
