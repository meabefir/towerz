extends AnimationPlayer

func _ready():
	Events.connect("time_scale_changed", self, "updateAnimationSpeed")
	
	updateAnimationSpeed()
	
func updateAnimationSpeed():
	playback_speed = 1.0 / Global.timeScale
