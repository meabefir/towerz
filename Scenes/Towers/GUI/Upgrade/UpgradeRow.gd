extends Control

export(PackedScene) var UpgradeButtonScene

onready var label = get_node("Label")
export(NodePath) onready var container = get_node(container)

var tower = null
var type = null
var data = null

func init(_type, _data, _tower):
	tower = _tower
	type = _type
	data = _data
	
func _ready():
	label.text = Tower.UPGRADE_TYPE.keys()[type]

	var previous = null
	
	for entry in data:
		var new_upgrade_button = UpgradeButtonScene.instance()
		new_upgrade_button.init(entry[0], entry[1], type, tower)
		container.add_child(new_upgrade_button)
		if entry != data[0]:
			new_upgrade_button.disable()
		
		if previous != null:
			previous.next = new_upgrade_button
		
		previous = new_upgrade_button

func checkFree():
	if container.get_child_count() == 1:
		queue_free()

func _on_UpgradeRow_tree_exiting():
	get_parent().get_parent().checkFree()
