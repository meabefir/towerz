extends Sprite

onready var animationPlayer = get_node("AnimationPlayer")
onready var activationTimer = get_node("ActivationTimer")

var isActive = true
const activationDelay = .5

func _ready():
	scale = Vector2()
	
	activationTimer.wait_time = activationDelay
	activationTimer.connect("timeout", self, "timeout")
	
	activate()
	
func activate():
	visible = true
	animationPlayer.play("load")
	
func deactivate():
	isActive = false
	scale = Vector2()
	visible = false
	activationTimer.start()
	
func timeout():
	activate()

func _on_AnimationPlayer_animation_finished(_anim_name):
	isActive = true
