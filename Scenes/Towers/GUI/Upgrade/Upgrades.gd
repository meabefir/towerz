extends Control

export(PackedScene) var UpgradeRowScene
export(NodePath) onready var container = get_node(container)

onready var panel = get_node("Panel")

func init(upgradeData: UpgradeInfo):
	for i in range(upgradeData.type.size()):
		var type = upgradeData.type[i]
		var data = upgradeData.data[i]
		
		var new_upgrades_row = UpgradeRowScene.instance()
		new_upgrades_row.init(type, data, get_parent().tower)
		container.add_child(new_upgrades_row)
		
	panel.rect_size.y *= upgradeData.type.size()

func checkFree():
	if container.get_child_count() == 1:
		queue_free()
