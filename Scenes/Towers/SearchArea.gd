extends Area2D

func search():
	var areas = get_overlapping_areas()
	
	if not get_parent().target in areas:
		get_parent().target = null
	
	if areas.size() == 0:
		return		
	
	match get_parent().targetingMode:
		Tower.TARGETING_MODES.CLOSEST:
			var min_dist = global_position.distance_squared_to(areas[0].global_position)
			get_parent().target = areas[0]
			
			areas.pop_front()
			for area in areas:
				var curr_dist = global_position.distance_squared_to(area.global_position)
				if curr_dist < min_dist:
					min_dist = curr_dist
					get_parent().target = area
			
		Tower.TARGETING_MODES.FIRST:
			var max_offset = areas[0].getOffset()
			get_parent().target = areas[0]
			
			areas.pop_front()
			for area in areas:
				var curr_offset = area.getOffset()
				if curr_offset > max_offset:
					max_offset = curr_offset
					get_parent().target = area
		
		Tower.TARGETING_MODES.LAST:
			var min_offset = areas[0].getOffset()
			get_parent().target = areas[0]
			
			areas.pop_front()
			for area in areas:
				var curr_offset = area.getOffset()
				if curr_offset < min_offset:
					min_offset = curr_offset
					get_parent().target = area
			
		Tower.TARGETING_MODES.MOST_DANGEROUS:
			var max_danger = areas[0].enemy.danger
			get_parent().target = areas[0]
			
			areas.pop_front()
			for area in areas:
				var curr_danger = area.enemy.danger
				if curr_danger > max_danger:
					max_danger = curr_danger
					get_parent().target = area
		
	
