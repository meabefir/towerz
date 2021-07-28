extends Control

onready var option: OptionButton = get_node("Option")

var mapToMode = []

func init(_targetingModeResource):
	var i = 0
	for mode in _targetingModeResource.modes:
		option.add_item(Tower.TARGETING_MODES.keys()[mode], int(mode))
		if mode == get_parent().tower.targetingMode:
			option.select(i)
		mapToMode.append(mode)
		
		i += 1

func _on_Option_item_selected(index):
	get_parent().tower.targetingMode = mapToMode[index]
	#print(Tower.TARGETING_MODES.keys()[mapToMode[index]])
	
