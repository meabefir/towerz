extends Control

export(Texture) var nextWaveTex
export(Texture) var doubleSpeedTex
export(Texture) var normalSpeedTex

export(NodePath) onready var button = get_node(button)

export var timeScaleChange = 3

func _ready():
	Events.connect("wave_finished", self, "waveFinished")
	
	button.texture_normal = nextWaveTex

func _on_TextureButton_pressed():
	if button.texture_normal == nextWaveTex:
		Events.emit_signal("load_next_wave")
		button.texture_normal = doubleSpeedTex
	elif button.texture_normal == doubleSpeedTex:
		Global.timeScale *= timeScaleChange
		button.texture_normal = normalSpeedTex
	else:
		Global.timeScale /= timeScaleChange
		button.texture_normal = doubleSpeedTex
		

func waveFinished():
	button.texture_normal = nextWaveTex
	Global.timeScale = 1

