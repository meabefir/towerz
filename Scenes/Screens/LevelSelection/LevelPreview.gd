extends CenterContainer

export(NodePath) onready var button = get_node(button)

var texPath
var scenePath

func init(_tex_path, _scene_path):
	texPath = _tex_path
	scenePath = _scene_path
	
func _ready():
	button.texture_normal = load(texPath)
	

func _on_TextureButton_pressed():
	get_tree().change_scene(scenePath)
