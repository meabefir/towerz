extends Area2D

onready var collision: CollisionShape2D = get_node("CollisionShape2D")

func setRadius(value):
	collision.shape.radius = value

func search():
	var areas = get_overlapping_areas()
	
	# if current target no longer overlaps	
	if not get_parent().target in areas:
		get_parent().target = null
	
	# if no targets in range
	if areas.size() == 0:
		return		
		
	var cantTarget = get_parent().cantTarget.data
	
	match get_parent().targetingMode:
		Tower.TARGETING_MODES.CLOSEST:
			var min_dist = global_position.distance_squared_to(areas[0].global_position)
			get_parent().target = areas[0].enemy
			
			areas.pop_front()
			for area in areas:
				var curr_dist = global_position.distance_squared_to(area.global_position)
				if curr_dist < min_dist and not area.enemy.type in cantTarget:
					min_dist = curr_dist
					get_parent().target = area.enemy
			
		Tower.TARGETING_MODES.FIRST:
			var max_offset = areas[0].enemy.offset
			get_parent().target = areas[0].enemy
			
			areas.pop_front()
			for area in areas:
				var curr_offset = area.enemy.offset
				if curr_offset > max_offset and not area.enemy.type in cantTarget:
					max_offset = curr_offset
					get_parent().target = area.enemy
		
		Tower.TARGETING_MODES.LAST:
			var min_offset = areas[0].enemy.offset
			get_parent().target = areas[0].enemy
			
			areas.pop_front()
			for area in areas:
				var curr_offset = area.get_parent().offset
				if curr_offset < min_offset and not area.enemy.type in cantTarget:
					min_offset = curr_offset
					get_parent().target = area.enemy
			
		Tower.TARGETING_MODES.STRONGEST:
			var max_danger = areas[0].enemy.danger
			get_parent().target = areas[0].enemy
			
			areas.pop_front()
			for area in areas:
				var curr_danger = area.enemy.danger
				if curr_danger > max_danger and not area.enemy.type in cantTarget:
					max_danger = curr_danger
					get_parent().target = area.enemy
		
		Tower.TARGETING_MODES.WEAKEST:
			var min_danger = areas[0].enemy.danger
			get_parent().target = areas[0].enemy
			
			areas.pop_front()
			for area in areas:
				var curr_danger = area.enemy.danger
				if curr_danger < min_danger and not area.enemy.type in cantTarget:
					min_danger = curr_danger
					get_parent().target = area.enemy
		
	if get_parent().target.type in cantTarget:
		get_parent().target = null
	
