extends Node2D

export(Color) var color: Color

var radius
var visualRadius = 0
var killOnReach = false
export var lerpSpeed: float = 10

onready var tower = get_parent()

func destroy():
	radius = 0
	killOnReach = true

func _draw():
	draw_circle(Vector2(), visualRadius, color)
	draw_circle(Vector2(), max(0, visualRadius - 10), color.linear_interpolate(Color(1,1,1,color.a), .5))

func _process(delta):
	if !tower.selected:
		radius = 0
	else:
		radius = tower.radius

	if tower.state == Tower.STATE.DEAD:
		radius = 0

	if visualRadius != radius:
		visualRadius = lerp(visualRadius, radius, lerpSpeed * delta)
		
		if abs(radius - visualRadius) < .1:
			visualRadius = radius
		update()
	else:
		if killOnReach:
			queue_free()
